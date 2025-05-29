import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class PiecePosition {
  final double left;
  final double top;
  final int angle;

  PiecePosition({
    required this.left,
    required this.top,
    required this.angle,
  });
}

class PuzzlePiece extends StatefulWidget {
  final int index;
  final double initialLeft;
  final double initialTop;
  final int initialAngle;
  final bool isStarted;
  final String imageName;
  final Function(int, Offset, StreamController<PiecePosition>)? onDragEnd;
  final Function(Function) onReset;
  final Size screenSize;
  final Size pieceSize;
  final Offset correctPosition;

  const PuzzlePiece({
    super.key,
    required this.index,
    required this.initialLeft,
    required this.initialTop,
    required this.initialAngle,
    required this.isStarted,
    required this.imageName,
    this.onDragEnd,
    required this.onReset,
    required this.screenSize,
    required this.pieceSize,
    required this.correctPosition,
  });

  @override
  State<PuzzlePiece> createState() => _PuzzlePieceState();
}

class _PuzzlePieceState extends State<PuzzlePiece> {
  final _acceptedController = StreamController<PiecePosition>();
  StreamSubscription<PiecePosition>? _acceptedSubscription;

  double left = 0;
  double top = 0;
  bool hasCompleted = false;
  Size oldScreenSize = Size(0, 0);

  @override
  void initState() {
    super.initState();
    print(widget.imageName);
    print('=========================================');
    left = widget.initialLeft;
    top = widget.initialTop;
    oldScreenSize = widget.screenSize;
    widget.onReset(reset);

    _acceptedSubscription = _acceptedController.stream.listen((position) {
      setState(() {
        left = position.left;
        top = position.top;
        hasCompleted = true;
      });
    });
  }

  @override
  void dispose() {
    _acceptedSubscription?.cancel();
    _acceptedController.close();
    super.dispose();
  }

  void reset() {
    left = widget.initialLeft;
    top = widget.initialTop;
    hasCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    final piece = Container(
      width: widget.pieceSize.width,
      height: widget.pieceSize.height,
      alignment: Alignment.center,
      // color: Colors.grey,
      child: Image.asset(
        widget.imageName,
        width: widget.pieceSize.width,
        height: widget.pieceSize.height,
        fit: BoxFit.cover,
      ),
    );

    int angle = (hasCompleted || !widget.isStarted) ? 0 : widget.initialAngle;
    if (oldScreenSize != widget.screenSize) {
      if (hasCompleted || !widget.isStarted) {
        left = widget.correctPosition.dx;
        top = widget.correctPosition.dy;
      } else {
        left = left * widget.screenSize.width / oldScreenSize.width;
        top = top * widget.screenSize.height / oldScreenSize.height;
        if (left < 0) {
          left = 0;
        }
        if (top < 0) {
          top = 0;
        }
        if (left > widget.screenSize.width - widget.pieceSize.width) {
          left = widget.screenSize.width - widget.pieceSize.width;
        }
        if (top > widget.screenSize.height - widget.pieceSize.height) {
          top = widget.screenSize.height - widget.pieceSize.height;
        }
      }
      oldScreenSize = widget.screenSize;
    }
    return Positioned(
      left: left,
      top: top,
      child: Transform.rotate(
        angle: angle * pi / 180,
        child: IgnorePointer(
          ignoring: hasCompleted || !widget.isStarted,
          child: GestureDetector(
            child: piece,
            onPanUpdate: (details) {
              setState(() {
                left += details.delta.dx * cos(angle * pi / 180) -
                    details.delta.dy * sin(angle * pi / 180);
                top += details.delta.dy * cos(angle * pi / 180) +
                    details.delta.dx * sin(angle * pi / 180);
              });
            },
            onPanEnd: (details) {
              widget.onDragEnd!(
                      widget.index, Offset(left, top), _acceptedController) ??
                  () {};
              bool forceMove = false;
              double newLeft = left;
              double newTop = top;
              if (newLeft < 0) {
                newLeft = 0;
                forceMove = true;
              }
              if (newTop < 0) {
                newTop = 0;
                forceMove = true;
              }
              if (newLeft > widget.screenSize.width - widget.pieceSize.width) {
                newLeft = widget.screenSize.width - widget.pieceSize.width;
                forceMove = true;
              }
              if (newTop > widget.screenSize.height - widget.pieceSize.height) {
                newTop = widget.screenSize.height - widget.pieceSize.height;
                forceMove = true;
              }
              if (forceMove) {
                setState(() {
                  left = newLeft;
                  top = newTop;
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
