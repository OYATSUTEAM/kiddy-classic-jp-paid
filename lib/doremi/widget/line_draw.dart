import '../page_state/line_draw_page_state.dart';
import 'line_draw_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LineDraw extends StatefulWidget {
  final Function(Offset ofs) onStart;
  final Function(Offset ofs) onUpdate;
  final Function() onEnd;
  final Function() onInit;
  final Size screenSize;
  final int soundNo;

  const LineDraw({
    super.key,
    required this.onStart,
    required this.onUpdate,
    required this.onEnd,
    required this.onInit,
    required this.screenSize,
    required this.soundNo,
  });

  @override
  State<LineDraw> createState() => _LineDrawState();
}

class _LineDrawState extends State<LineDraw> {
  bool hasCompleted = false;
  Size oldScreenSize = Size(0, 0);

  @override
  void initState() {
    super.initState();
    oldScreenSize = widget.screenSize;
    widget.onInit();
  }

  @override
  Widget build(BuildContext context) =>
      Consumer(builder: (context, WidgetRef ref, child) {
        if (oldScreenSize != widget.screenSize) {
          ref.read(lineDrawPageStateNotifierProvider.notifier).adjustPosints(
              context, oldScreenSize, widget.screenSize, widget.soundNo);
          oldScreenSize = widget.screenSize;
        }
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onPanStart: (details) {
            widget.onStart(details.localPosition);
            setState(() {});
          },
          onPanUpdate: (details) {
            widget.onUpdate(details.localPosition);
            setState(() {});
          },
          onPanEnd: (details) {
            // 成否判定
            widget.onEnd();
          },
          child: SizedBox(
            width: widget.screenSize.width,
            height: widget.screenSize.height,
            child: CustomPaint(
              painter: LineDrawPainter(
                  ref
                      .read(lineDrawPageStateNotifierProvider.notifier)
                      .getPoints(),
                  context),
            ),
          ),
        );
      });
}
