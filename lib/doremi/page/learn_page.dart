import 'dart:developer';

import '../setting.dart';
import 'package:flutter/material.dart';
import '../widget/background.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
import '../config/flavor_config.dart';

/*
class LearnPage extends StatelessWidget {
  final String imageName;
  final String nextPageRoute;
  final AudioPlayer? audioPlayer;

  const LearnPage({
    super.key,
    required this.imageName,
    required this.nextPageRoute,
    this.audioPlayer,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = getScreenSize(context);
    final ViewSetting learnButtonSetting = getLearnButtonViewSetting(context);
    final folder = getSizeFolderName(context);
    return Center(
      child: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        /*decoration: BoxDecoration(
          border: Border.all(
            color: Colors.red,
            width: 2,
          ),
        ),*/
        child: Stack(
          children: [
            Background(
                name: 'assets/images/$folder/$imageName',
                width: screenSize.width,
                height: screenSize.height),
            Positioned(
              left: learnButtonSetting.position.dx,
              top: learnButtonSetting.position.dy,
              width: learnButtonSetting.size.width,
              height: learnButtonSetting.size.height,
              child: GestureDetector(
                onTap: () {
                  if (audioPlayer != null) {
                    audioPlayer!.stop();
                  }
                  Navigator.pushNamed(context, nextPageRoute);
                },
                child: Container(
                  width: learnButtonSetting.size.width,
                  height: learnButtonSetting.size.height,
                  color: Colors.blue.withOpacity(0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/

class LearnPage extends StatefulWidget {
  final String imageName;
  final String animationImageName;
  final String nextPageRoute;
  final AudioPlayer? audioPlayer;

  const LearnPage({
    super.key,
    required this.imageName,
    required this.animationImageName,
    required this.nextPageRoute,
    this.audioPlayer,
  });

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _initializeAudio();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _initializeAudio() async {
    // Stop any existing audio from the parent player

    // Use our dedicated player for 006.mp3
    _audioPlayer.setAsset('assets/sounds/006.mp3');
    _audioPlayer.play();

    // Wait for the full duration
    await Future.delayed(const Duration(seconds: 12));

    if (mounted && context.mounted) {
      // await _audioPlayer.stop();
      Navigator.of(context).pushReplacementNamed(widget.nextPageRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = getScreenSize(context);
    final folder = getSizeFolderName(context);
    final ViewSetting learnCharacterSetting =
        getLearnCharacterViewSetting(context);
    return Scaffold(
        body: SizedBox(
      width: screenSize.width,
      height: screenSize.height,
      child: Stack(
        children: [
          Background(
              name:
                  '${FlavorConfig.assetPath}/images/$folder/${widget.imageName}',
              width: screenSize.width,
              height: screenSize.height),
          Positioned(
            top: learnCharacterSetting.position.dy,
            left: learnCharacterSetting.position.dx,
            width: learnCharacterSetting.size.width,
            height: learnCharacterSetting.size.height,
            child: Image.asset(
                'assets/ja_toon/images/animation/${widget.animationImageName}'),
          ),
        ],
      ),
    ));
  }
}
