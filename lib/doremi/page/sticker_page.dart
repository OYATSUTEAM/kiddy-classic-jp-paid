//import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
import '../page_state/sticker_page_state.dart';
import '../setting.dart';
import '../widget/background.dart';
import '../widget/completed.dart';
import '../widget/sticker.dart';
import '../widget/sticker_target.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/flavor_config.dart';

/// シールをはりましょう 画面
class StickerPage extends ConsumerStatefulWidget {
  final int level;
  final int soundNo;
  const StickerPage({
    super.key,
    required this.level,
    required this.soundNo,
  });

  @override
  ConsumerState<StickerPage> createState() => _StickerPageState();
}

class _StickerPageState extends ConsumerState<StickerPage> {
  final AudioPlayer nextAudioPlayer = AudioPlayer();
  final AudioPlayer drawAudioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nextAudioPlayer.dispose();
    drawAudioPlayer.dispose();
    drawAudioPlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCompleted = ref.watch(
        stickerPageStateNotifierProvider.select((state) => state.isCompleted));
    final stateNotifier = ref.read(stickerPageStateNotifierProvider.notifier);
    final setting = stateNotifier.setting;
    final screenSize = getScreenSize(context);
    final folder = getSizeFolderName(context);
    final StickerViewSetting stickerTargetSetting =
        getStickerTargetViewSetting(context, widget.soundNo, widget.level);
    final List<Offset> stickerInitOffsets =
        getStickerInitSetting(context, getStickerNum());
    // AudioPlayers are now managed in state

    return Scaffold(
        body: Center(
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
              name:
                  '${FlavorConfig.assetPath}/images/$folder/${setting.backgroundImageName}',
              width: screenSize.width,
              height: screenSize.height,
            ),
            // シールのターゲット位置リストからターゲットを生成
            ...stickerTargetSetting.positions.asMap().entries.map(
                  (entry) => StickerTarget(
                    top: entry.value.dy,
                    left: entry.value.dx,
                    stickerSize: stickerTargetSetting.size,
                    index: entry.key,
                  ),
                ),
            // シール位置リストからシールを生成
            ...stickerInitOffsets.map(
              (position) => Sticker(
                initialLeft: position.dx,
                initialTop: position.dy,
                onCompleted: () {
                  ref
                      .read(stickerPageStateNotifierProvider.notifier)
                      .increment();
                },
                imageNmae:
                    '${FlavorConfig.assetPath}/images/$folder/${setting.stickerImageName}',
                correctSoundName: setting.correctSoundName,
                incorrectSoundName: setting.incorrectSoundName,
                screenSize: screenSize,
                stickerSize: stickerTargetSetting.size,
                targetPositions: stickerTargetSetting.positions,
              ),
            ),
            isCompleted
                ? Completed(
                    onTap: () {
                      nextAudioPlayer.setAsset('assets/sounds/004.mp3');
                      nextAudioPlayer.play();

                      ref
                          .read(stickerPageStateNotifierProvider.notifier)
                          .reset();
                      Navigator.of(context).pushNamed(setting.nextPageRoute);

                      // if (setting.nextPageRoute == '/draw') {
                      //   drawAudioPlayer.setAsset('assets/sounds/bgm4.mp3');
                      //   drawAudioPlayer.play();
                      // }

                      if (setting.nextPageRoute == '/draw') {
                        // drawAudioPlayer.setAsset('assets/sounds/bgm4.mp3');
                        // drawAudioPlayer.play();

                        // // Wait for 40 seconds
                        // Future.delayed(Duration(seconds: 60), () async {
                        //   const fadeDuration =
                        //       Duration(seconds: 5);
                        //   final int steps = 50; // number of volume steps
                        //   final double initialVolume =
                        //       1.0; // assuming starting volume is max
                        //   final double stepDurationSeconds =
                        //       fadeDuration.inSeconds / steps;

                        //   for (int i = 0; i <= steps; i++) {
                        //     final double volume =
                        //         initialVolume * (1 - i / steps);
                        //     await Future.delayed(Duration(
                        //         milliseconds:
                        //             (stepDurationSeconds * 1000).toInt()));
                        //     await drawAudioPlayer.setVolume(volume);
                        //   }

                        //   // Optionally stop the player after fade out
                        //   await drawAudioPlayer.stop();
                        // });
                        ref
                            .read(stickerPageStateNotifierProvider.notifier)
                            .bgmPlay();
                      }
                    },
                    imageName: setting.completedImageName,
                    nextButtonImageName: setting.nextButtonImageName,
                    screenSize: screenSize,
                    nextButtonSize: getStickerNextButtonSize(context),
                    completedSize: getStickerCompleteSize(context),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    ));
  }
}
