import 'dart:async';

import 'package:flutter/material.dart';

class StickerPosition {
  final double left;
  final double top;
  final double target;

  StickerPosition({
    required this.left,
    required this.top,
    required this.target,
  });
}

class LineSpaceSticker extends StatefulWidget {
  final double initialLeft;
  final double initialTop;
  final String imageNmae;
  final Function(Offset, StreamController<StickerPosition>)? onDragEnd;
  final Size screenSize;
  final Size stickerSize;
  final Offset linePosition;
  final double lineHeight;
  final bool isStarted;
  final Function(Function)? onReset;

  const LineSpaceSticker({
    super.key,
    required this.initialLeft,
    required this.initialTop,
    required this.imageNmae,
    this.onDragEnd,
    required this.screenSize,
    required this.stickerSize,
    required this.linePosition,
    required this.lineHeight,
    required this.isStarted,
    this.onReset,
  });

  @override
  State<LineSpaceSticker> createState() => _LineSpaceStickerState();
}

class _LineSpaceStickerState extends State<LineSpaceSticker> {
  final _acceptedController =
      StreamController<StickerPosition>(); // 正解位置にドラッグ時にその位置を受け取るために使用
  StreamSubscription<StickerPosition>? _acceptedSubscription;

  double left = 0;
  double top = 0;
  bool hasCompleted = false;
  bool isDragged =
      false; // 各サイズの背景画像でイラストの位置が変わっていたりするため、イラストと被らないよう初期位置を設定から持ってくるためのフラグ

  double target = 0;
  Size oldScreenSize = Size(0, 0);

  @override
  void initState() {
    super.initState();

    left = widget.initialLeft;
    top = widget.initialTop;
    oldScreenSize = widget.screenSize;
    widget.onReset?.call(reset);

    _acceptedSubscription = _acceptedController.stream.listen((position) {
      setState(() {
        left = position.left;
        top = position.top;
        target = position.target;
        hasCompleted = true;
      });
    });
  }

  void reset() {
    if (mounted) {
      setState(() {
        left = widget.initialLeft;
        top = widget.initialTop;
        isDragged = false;
        hasCompleted = false;
      });
    }
  }

  @override
  void dispose() {
    _acceptedSubscription?.cancel();
    _acceptedController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sticker = Container(
      width: widget.stickerSize.width,
      height: widget.stickerSize.height,
      alignment: Alignment.center,
      child: Image.asset(
        widget.imageNmae,
        fit: BoxFit.cover,
      ),
    );

    if (oldScreenSize != widget.screenSize) {
      if (!isDragged) {
        left = widget.initialLeft;
        top = widget.initialTop;
      } else {
        if (hasCompleted) {
          left = left * widget.screenSize.width / oldScreenSize.width;
          top = widget.linePosition.dy +
              widget.lineHeight * target -
              widget.stickerSize.height / 2;
        } else {
          left = left * widget.screenSize.width / oldScreenSize.width;
          top = top * widget.screenSize.height / oldScreenSize.height;
        }
      }
      if (left < 0) {
        left = 0;
      }
      if (top < 0) {
        top = 0;
      }
      if (left > widget.screenSize.width - widget.stickerSize.width) {
        left = widget.screenSize.width - widget.stickerSize.width;
      }
      if (top > widget.screenSize.height - widget.stickerSize.height) {
        top = widget.screenSize.height - widget.stickerSize.height;
      }
      oldScreenSize = widget.screenSize;
    }

    return Positioned(
      left: left,
      top: top,
      width: widget.stickerSize.width,
      height: widget.stickerSize.height,
      child: IgnorePointer(
        ignoring: hasCompleted || !widget.isStarted,
        child: Draggable(
          data: _acceptedController.sink,
          feedback: sticker,
          childWhenDragging: const IgnorePointer(),
          child: sticker,
          onDragStarted: () {
            isDragged = true;
          },
          onDragUpdate: (details) {
            setState(() {
              left += details.delta.dx;
              top += details.delta.dy;
            });
          },
          onDragEnd: (detail) {
            widget.onDragEnd!(Offset(left, top), _acceptedController) ?? () {};
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
            if (newLeft > widget.screenSize.width - widget.stickerSize.width) {
              newLeft = widget.screenSize.width - widget.stickerSize.width;
              forceMove = true;
            }
            if (newTop > widget.screenSize.height - widget.stickerSize.height) {
              newTop = widget.screenSize.height - widget.stickerSize.height;
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
    );
  }
}
