import 'package:flutter/material.dart';

class OnpuButton extends StatelessWidget {
  final void Function()? onTap;

  final bool icon;
  final String? imageName;
  final Offset position;
  final Size buttonSize;
  const OnpuButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.imageName,
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
            onTap: onTap ?? () {},
            child: (icon && imageName != null)
                ? Image.asset(
                    imageName!,
                    fit: BoxFit.cover,
                  )
                : Container(
                    //color: Colors.red.withOpacity(0.5),
                    color: Colors.red.withOpacity(0),
                    alignment: Alignment.center,
                  ),
          ),
        ),
      ],
    );
  }
}
