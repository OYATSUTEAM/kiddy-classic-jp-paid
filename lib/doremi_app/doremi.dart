import '/all_app.dart';
import 'package:kiddy_classic/doremi/page_state/sticker_page_state.dart';
import 'package:flutter/material.dart';
import 'package:kiddy_classic/doremi/doremi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiddy_classic/doremi/setting.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
import '/doremi_app/config/flavor_config.dart';

class Doremi extends ConsumerWidget {
  final Settings setting;
  final AudioPlayer? audioPlayer;
  const Doremi({super.key, required this.setting, required this.audioPlayer});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Settings setting = selectEnv();
    Size screenSize = getScreenSize(context);

    return MaterialApp(
      title: 'どれみとあそぼ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => TitlePage(
              imageName: '${FlavorConfig.assetPath}/images/Title.png',
              nextPageRoute: '/learn',
              audioPlayer: audioPlayer,
            ),
        '/learn': (context) => LearnPage(
              imageName: setting.learnImageName,
              animationImageName: setting.animationImageName,
              nextPageRoute: '/sticker1',
              audioPlayer: audioPlayer,
            ),
        '/sticker1': (context) {
          final stickerSetting = StickerPageSetting(
            nextPageRoute: '/sticker2',
            stickerImageName: setting.stickerImageName,
            backgroundImageName: setting.stickerBackImageName,
            targetNum: getStickerCorrectNum(0, setting.soundNo),
            audioPlayer: audioPlayer,
          );
          final stateNotifier =
              ref.read(stickerPageStateNotifierProvider.notifier);
          stateNotifier.setting = stickerSetting;
          return StickerPage(level: 0, soundNo: setting.soundNo);
        },
        '/sticker2': (context) {
          final stickerSetting = StickerPageSetting(
            nextPageRoute: '/draw',
            stickerImageName: setting.stickerImageName,
            backgroundImageName: setting.stickerBackImageName2,
            targetNum: getStickerCorrectNum(1, setting.soundNo),
            audioPlayer: audioPlayer,
          );
          final stateNotifier =
              ref.read(stickerPageStateNotifierProvider.notifier);
          stateNotifier.setting = stickerSetting;
          return StickerPage(level: 1, soundNo: setting.soundNo);
        },
        '/draw': (context) => LineDrawPage(
              nextPageRoute: '/menu',
              imageName: setting.drawImageName,
              soundNo: setting.soundNo,
              audioPlayer: audioPlayer,
            ),
        '/menu': (context) => AllApp(audioPlayer: audioPlayer)
      },
    );
  }
}
