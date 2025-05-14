import 'sticker.dart';
import 'package:flutter/material.dart';

class StickerTarget extends StatefulWidget {
  final double top;
  final double left;
  final Size stickerSize;
  final int index;

  const StickerTarget({
    super.key,
    required this.top,
    required this.left,
    required this.stickerSize,
    required this.index,
  });

  @override
  State<StickerTarget> createState() => _StickerTargetState();
}

class _StickerTargetState extends State<StickerTarget> {
  bool hasAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top,
      left: widget.left,
      width: widget.stickerSize.width,
      height: widget.stickerSize.height,
      child: IgnorePointer(
        ignoring: hasAccepted,
        child: DragTarget<Sink<StickerPosition>>(
          onAcceptWithDetails: (details) {
            setState(() {
              hasAccepted = true;
            });
            details.data.add(
              StickerPosition(
                left: widget.left,
                top: widget.top,
                targetIndex: widget.index,
              ),
            );
          },
          builder: (context, candidateData, rejectedData) {
            /*return Container(
              color: Colors.green.withOpacity(0.5),
              height: widget.stickerSize.height,
              width: widget.stickerSize.width,
            );*/
            return SizedBox();
          },
        ),
      ),
    );
  }
}
