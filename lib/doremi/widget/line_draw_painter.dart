import 'package:flutter/material.dart';

class LineDrawPainter extends CustomPainter {
  final List<List<Offset>> _paintList;
  final BuildContext context;
  LineDrawPainter(this._paintList, this.context);
  final double strokeWidth = 5.0;
  final Paint _paint = Paint()
    ..color = Colors.black
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 5.0;

  @override
  void paint(Canvas canvas, Size size) {
    for (var paint in _paintList) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromCenter(
                center: paint[0], width: strokeWidth, height: strokeWidth),
            Radius.circular(strokeWidth)),
        _paint,
      );
      for (int i = 0; i < paint.length - 1; i++) {
        canvas.drawLine(paint[i], paint[i + 1], _paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
