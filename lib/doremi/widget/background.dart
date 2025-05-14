import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({
    super.key,
    required this.name,
    required this.width,
    required this.height,
  });

  final String name;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: 0,
      width: width,
      height: height,
      child: Image.asset(
        name,
        width: width,
        height: height,
        fit: BoxFit.fill,
      ),
    );
  }
}
