import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final void Function() onTap;
  final Offset position;
  final Size buttonSize;
  const MenuButton({
    super.key,
    required this.onTap,
    required this.position,
    required this.buttonSize,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: position.dx,
          top: position.dy,
          width: buttonSize.width,
          height: buttonSize.height,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              color: Colors.black.withOpacity(0),
              alignment: Alignment.center,
            ),
          ),
        ),
      ],
    );
  }
}
