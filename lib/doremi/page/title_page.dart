import 'package:kiddy_classic/onpu/page/line_space_a_page.dart';

import '../setting.dart';
import 'package:flutter/material.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';

/*class TitlePage extends StatefulWidget {
  final String imageName;
  final String nextPageRoute;
  final AudioPlayer? audioPlayer;

  const TitlePage({
    super.key,
    required this.imageName,
    required this.nextPageRoute,
    this.audioPlayer,
  });

  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (mounted) {
          Navigator.of(context).pushReplacementNamed(widget.nextPageRoute);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      widget.imageName,
      fit: BoxFit.contain,
      width: double.infinity,
      height: double.infinity,
    );
  }
}
*/
/*
class TitlePage extends StatelessWidget {
  final String imageName;
  final String nextPageRoute;
  final AudioPlayer? audioPlayer;

  const TitlePage({
    super.key,
    required this.imageName,
    required this.nextPageRoute,
    this.audioPlayer,
  });
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        Image.asset(
          imageName,
          fit: BoxFit.contain,
          width: double.infinity,
          height: double.infinity,
        ),
        GestureDetector(
          onTap: () {
            if (audioPlayer != null) {
              audioPlayer!.play(AssetSource('assets/sounds/006.mp3'));
            }
            Navigator.of(context).pushReplacementNamed(nextPageRoute);
          },
          child: Container(
            width: screenSize.width,
            height: screenSize.height,
            color: Colors.blue.withOpacity(0),
          ),
        ),
      ],
    );
  }
}*/

class TitlePage extends StatefulWidget {
  final String imageName;
  final String nextPageRoute;
  // final AudioPlayer? audioPlayer;

  const TitlePage({
    super.key,
    required this.imageName,
    required this.nextPageRoute,
    // this.audioPlayer,
  });

  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  final backgroundAudioPlayer = AudioPlayer();
  bool _isTapped = false;
  @override
  void dispose() {
    backgroundAudioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
            color: Colors.white,
            child: Image.asset(
              widget.imageName,
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            )),
        GestureDetector(
          onTap: () async {
            if (_isTapped) return;
            setState(() {
              _isTapped = true;
            });
            backgroundAudioPlayer.setAsset('assets/sounds/007.mp3');
            backgroundAudioPlayer.play();
            await Future.delayed(const Duration(seconds: 7));

            if (mounted) {
              Navigator.of(context).pushReplacementNamed(widget.nextPageRoute);
            }
          },
          child: Container(
            width: screenSize.width,
            height: screenSize.height,
            color: Colors.blue.withOpacity(0),
          ),
        ),
      ],
    );
  }
}
