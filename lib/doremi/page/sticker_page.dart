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
class StickerPage extends ConsumerWidget {
  final int level;
  final int soundNo;
  const StickerPage({
    super.key,
    required this.level,
    required this.soundNo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCompleted = ref.watch(
        stickerPageStateNotifierProvider.select((state) => state.isCompleted));
    final stateNotifier = ref.read(stickerPageStateNotifierProvider.notifier);
    final setting = stateNotifier.setting;
    final screenSize = getScreenSize(context);
    final folder = getSizeFolderName(context);
    final StickerViewSetting stickerTargetSetting =
        getStickerTargetViewSetting(context, soundNo, level);
    final List<Offset> stickerInitOffsets =
        getStickerInitSetting(context, getStickerNum());
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
                      ref
                          .read(stickerPageStateNotifierProvider.notifier)
                          .reset();
                      Navigator.of(context)
                          .pushReplacementNamed(setting.nextPageRoute);
                      AudioPlayer nextAudioPlayer = AudioPlayer();
                      nextAudioPlayer.setAsset('assets/sounds/004.mp3');
                      nextAudioPlayer.play();

                      if (setting.audioPlayer != null) {
                        if (setting.nextPageRoute == '/draw') {
                          setting.audioPlayer!
                              .setAsset('assets/sounds/bgm4.mp3');
                          setting.audioPlayer!
                              .play();
                        } else {
                          setting.audioPlayer!.stop();
                        }
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
