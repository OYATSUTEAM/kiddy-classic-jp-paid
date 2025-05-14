import 'package:flutter/material.dart';

class LineDrawTarget extends StatefulWidget {
  final double top;
  final double left;
  final Size targetSize;

  const LineDrawTarget({
    super.key,
    required this.top,
    required this.left,
    required this.targetSize,
  });

  @override
  State<LineDrawTarget> createState() => _LineDrawTargetState();
}

class _LineDrawTargetState extends State<LineDrawTarget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*return Positioned(
      top: widget.top,
      left: widget.left,
      width: widget.targetSize.width,
      height: widget.targetSize.height,
      child: IgnorePointer(
        child: Container(
          alignment: Alignment.center,
          height: widget.targetSize.height,
          width: widget.targetSize.width,
          decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.5), shape: BoxShape.circle),
        ),
      ),
    );*/
    return SizedBox();
  }
}
