import 'package:flutter/material.dart';

class PuzzleButton extends StatelessWidget {
  final bool image;
  final String? imageName;
  final Size buttonSize;
  final void Function() onTap;

  const PuzzleButton({
    super.key,
    this.image = true,
    this.imageName,
    required this.buttonSize,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: (image && imageName != null)
          ? Image.asset(
              imageName!,
              width: buttonSize.width,
              height: buttonSize.height,
            )
          : Container(
              color: Colors.red.withOpacity(0.5),
              alignment: Alignment.center,
            ),
    );
  }
}
