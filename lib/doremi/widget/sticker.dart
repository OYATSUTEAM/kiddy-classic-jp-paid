import 'dart:async';

//import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';

class StickerPosition {
  final double left;
  final double top;
  final int targetIndex;

  StickerPosition({
    required this.left,
    required this.top,
    required this.targetIndex,
  });
}

class Sticker extends StatefulWidget {
  final double initialLeft;
  final double initialTop;
  final String imageNmae;
  final String correctSoundName;
  final String incorrectSoundName;
  final Function() onCompleted;
  final Size screenSize;
  final Size stickerSize;
  final List<Offset> targetPositions;

  const Sticker({
    super.key,
    required this.initialLeft,
    required this.initialTop,
    required this.imageNmae,
    required this.correctSoundName,
    required this.incorrectSoundName,
    required this.onCompleted,
    required this.screenSize,
    required this.stickerSize,
    required this.targetPositions,
  });

  @override
  State<Sticker> createState() => _StickerState();
}

class _StickerState extends State<Sticker> {
  final _acceptedController =
      StreamController<StickerPosition>(); // ドラッグ成功時にTaget側の位置を受け取るために使用
  final _audioPlayer = AudioPlayer();
  StreamSubscription<StickerPosition>? _acceptedSubscription;
  double left = 0;
  double top = 0;
  bool hasCompleted = false;
  bool isDragged =
      false; // 各サイズの背景画像でイラストの位置が変わっていたりするため、初期位置を設定から持ってくるためのフラグ(現在は背景画像1種類のためなくても問題なし)
  Size oldScreenSize = Size(0, 0);
  int targetIndex = 0;

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
        targetIndex = position.targetIndex;
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

  @override
  Widget build(BuildContext context) {
    final sticker = SizedBox(
      width: widget.stickerSize.width,
      height: widget.stickerSize.height,
      child: Image.asset(
        widget.imageNmae,
        width: widget.stickerSize.width,
        height: widget.stickerSize.height,
        fit: BoxFit.cover,
      ),
    );

    if (oldScreenSize != widget.screenSize) {
      if (!isDragged) {
        left = widget.initialLeft;
        top = widget.initialTop;
      } else {
        if (hasCompleted) {
          left = widget.targetPositions[targetIndex].dx;
          top = widget.targetPositions[targetIndex].dy;
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
        ignoring: hasCompleted,
        child: Draggable<Sink<StickerPosition>>(
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
          onDragCompleted: () {
            setState(() {
              hasCompleted = true;
            });
            _audioPlayer.setAsset(widget.correctSoundName);
            _audioPlayer.play();
            widget.onCompleted();
          },
          onDraggableCanceled: (velocity, offset) {
            _audioPlayer.setAsset(widget.incorrectSoundName);
            _audioPlayer.play();
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
                isDragged = true;
              });
            }
          },
        ),
      ),
    );
  }
}
