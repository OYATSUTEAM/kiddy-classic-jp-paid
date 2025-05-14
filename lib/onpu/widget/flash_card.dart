//import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlashCard extends StatefulWidget {
  final String imageName;
  final Offset position;
  final Size size;
  final bool speedType;
  final int index;
  const FlashCard({
    super.key,
    required this.imageName,
    required this.position,
    required this.size,
    required this.speedType,
    required this.index,
  });

  @override
  State<FlashCard> createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  final int millisec = 1500;
  final int millisec2 = 3000;
  bool speedType = false;
  bool isDelay = false;
  int index = 0;
  AudioPlayer audioplayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    speedType = widget.speedType;
  }

  @override
  Widget build(BuildContext context) => Consumer(
        builder: (context, WidgetRef ref, child) {
          return Stack(
            children: [
              Positioned(
                left: widget.position.dx,
                top: widget.position.dy,
                child: Image.asset(
                  widget.imageName,
                  width: widget.size.width,
                  height: widget.size.height,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ],
          );
        },
      );
}
