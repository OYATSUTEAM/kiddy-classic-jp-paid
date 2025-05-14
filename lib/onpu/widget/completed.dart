import 'package:flutter/material.dart';

class Completed extends StatelessWidget {
  final String imageName;
  final Size screenSize;
  final Size completedSize;

  const Completed({
    super.key,
    required this.imageName,
    required this.screenSize,
    required this.completedSize,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: 0,
      width: screenSize.width,
      height: screenSize.height,
      child: Center(
        child: Image.asset(
          imageName,
          width: completedSize.width,
          height: completedSize.height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
