import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import '../setting.dart';

class OnpuPiecePosition {
  final double left;
  final double top;
  final double angle;
  final bool isCompleted;

  OnpuPiecePosition({
    required this.left,
    required this.top,
    required this.angle,
    this.isCompleted = true,
  });
}

class OnpuPuzzlePiece extends StatefulWidget {
  final int index;
  final double initialLeft;
  final double initialTop;
  final double initialAngle;
  final bool isStarted;
  final bool isCompleted;
  final bool isCorrect;
  final String imageName;
  final Function(int, Offset, StreamController<OnpuPiecePosition>)? onDragEnd;
  final Function(int, Offset)? onUpdate;
  final Function(int, StreamController<OnpuPiecePosition>) onAdjust;
  final Size screenSize;
  final Size pieceSize;
  final Offset correctPosition;
  final bool type;

  const OnpuPuzzlePiece({
    super.key,
    required this.index,
    required this.initialLeft,
    required this.initialTop,
    required this.initialAngle,
    required this.isStarted,
    required this.isCompleted,
    required this.isCorrect,
    required this.imageName,
    this.onDragEnd,
    this.onUpdate,
    required this.onAdjust,
    required this.screenSize,
    required this.pieceSize,
    required this.correctPosition,
    required this.type,
  });

  @override
  State<OnpuPuzzlePiece> createState() => _OnpuPuzzlePieceState();
}

class _OnpuPuzzlePieceState extends State<OnpuPuzzlePiece> {
  final _acceptedController = StreamController<OnpuPiecePosition>();
  StreamSubscription<OnpuPiecePosition>? _acceptedSubscription;

  double left = 0;
  double top = 0;
  Size oldScreenSize = Size(0, 0);
  bool isStarted = false;

  @override
  void initState() {
    super.initState();

    left = widget.initialLeft;
    top = widget.initialTop;
    oldScreenSize = widget.screenSize;

    _acceptedSubscription = _acceptedController.stream.listen((position) {
      setState(() {
        left = position.left;
        top = position.top;
        widget.onUpdate?.call(widget.index, Offset(left, top));
      });
    });
  }

  @override
  void dispose() {
    _acceptedSubscription?.cancel();
    _acceptedController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final piece = Container(
      width: widget.pieceSize.width,
      height: widget.pieceSize.height,
      alignment: Alignment.center,
      //color: Colors.green.withOpacity(0.5),
      child: Image.asset(
        widget.imageName,
        width: widget.pieceSize.width,
        height: widget.pieceSize.height,
        fit: BoxFit.cover,
      ),
    );

    /*final debugMargin = getOnpuPieceMargin(context, widget.index, false);
    final debugPiece = Stack(
      children: [
        piece,
        Positioned(
          left: debugMargin.left,
          top: debugMargin.top,
          child: Container(
            width:
                widget.pieceSize.width - debugMargin.left - debugMargin.right,
            height:
                widget.pieceSize.height - debugMargin.top - debugMargin.bottom,
            //alignment: Alignment.center,
            color: Colors.red.withOpacity(0.5),
          ),
        ),
      ],
    );*/
    double angle = widget.initialAngle;
    bool update = false;
    if (isStarted != widget.isStarted) {
      isStarted = widget.isStarted;
      left = widget.initialLeft;
      top = widget.initialTop;
      update = true;
    } else if (!isStarted) {
      left = widget.initialLeft;
      top = widget.initialTop;
    }
    if (oldScreenSize != widget.screenSize) {
      widget.onAdjust(widget.index, _acceptedController);
      oldScreenSize = widget.screenSize;
      update = false;
    }
    if (update) {
      widget.onUpdate?.call(widget.index, Offset(left, top));
    }

    return Positioned(
      left: left,
      top: top,
      child: Transform.rotate(
        angle: angle * pi / 180,
        child: IgnorePointer(
          ignoring: widget.isCompleted || !widget.isStarted,
          child: GestureDetector(
            child: piece,
            onPanUpdate: (details) {
              setState(() {
                left += details.delta.dx * cos(angle * pi / 180) -
                    details.delta.dy * sin(angle * pi / 180);
                top += details.delta.dy * cos(angle * pi / 180) +
                    details.delta.dx * sin(angle * pi / 180);
                widget.onUpdate?.call(widget.index, Offset(left, top));
              });
            },
            onPanEnd: (details) {
              bool forceMove = false;
              double newLeft = left;
              double newTop = top;
              final margin =
                  getOnpuPieceMargin(context, widget.index, widget.type);
              if (newLeft + margin.left < 0) {
                newLeft = -margin.left;
                forceMove = true;
              }
              if (newTop + margin.top < 0) {
                newTop = -margin.top;
                forceMove = true;
              }
              if (newLeft - margin.right >
                  widget.screenSize.width - widget.pieceSize.width) {
                newLeft = widget.screenSize.width -
                    widget.pieceSize.width +
                    margin.right;
                forceMove = true;
              }
              if (newTop - margin.bottom >
                  widget.screenSize.height - widget.pieceSize.height) {
                newTop = widget.screenSize.height -
                    widget.pieceSize.height +
                    margin.bottom;
                forceMove = true;
              }
              if (forceMove) {
                setState(() {
                  left = newLeft;
                  top = newTop;
                  widget.onUpdate?.call(widget.index, Offset(left, top));
                });
              }
              widget.onDragEnd!(
                      widget.index, Offset(left, top), _acceptedController) ??
                  () {};
            },
          ),
        ),
      ),
    );
  }
}
