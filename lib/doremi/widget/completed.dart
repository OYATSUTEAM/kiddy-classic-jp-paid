import 'package:flutter/material.dart';
import '../config/flavor_config.dart';

class Completed extends StatelessWidget {
  final void Function() onTap;
  final String? imageName;
  final String? nextButtonImageName;
  final bool compledText;
  final Size screenSize;
  final Size nextButtonSize;
  final Size? completedSize;

  const Completed({
    super.key,
    required this.onTap,
    this.imageName,
    this.nextButtonImageName,
    this.compledText = true,
    required this.screenSize,
    required this.nextButtonSize,
    this.completedSize = const Size(1612 * 0.6, 624 * 0.6),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            onTap: onTap,
            child: Image.asset(
              nextButtonImageName ??
                  // 'packages/doremi/
                  '${FlavorConfig.assetPath}/images/Next.png',
              width: nextButtonSize.width,
              height: nextButtonSize.height,
            ),
          ),
        ),
        compledText
            ? Positioned(
                left: 0,
                top: 0,
                width: screenSize.width,
                height: screenSize.height,
                child: Center(
                  child: Image.asset(
                    imageName ??
                        // 'packages/doremi/
                        '${FlavorConfig.assetPath}/images/Tablet_Completed.png',
                    width: completedSize!.width,
                    height: completedSize!.height,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
