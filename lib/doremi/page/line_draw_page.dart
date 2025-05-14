//import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
import '../page_state/line_draw_page_state.dart';
import '../setting.dart';
import '../widget/background.dart';
import '../widget/completed.dart';
import '../widget/line_draw.dart';
import '../widget/line_draw_target.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/flavor_config.dart';

class LineDrawPage extends ConsumerWidget {
  final String imageName;
  final String nextPageRoute;
  final int soundNo;
  final AudioPlayer? audioPlayer;

  const LineDrawPage({
    super.key,
    required this.imageName,
    required this.nextPageRoute,
    required this.soundNo,
    this.audioPlayer,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCompleted = ref.watch(
        lineDrawPageStateNotifierProvider.select((state) => state.isCompleted));

    final screenSize = getScreenSize(context);
    final folder = getSizeFolderName(context);
    LineDrawTargetViewSetting drawTargetSetting =
        getDrawViewSetting(context, soundNo);
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
                name: '${FlavorConfig.assetPath}/images/$folder/$imageName',
                width: screenSize.width,
                height: screenSize.height),
            ...drawTargetSetting.targets.map(
              (target) => LineDrawTarget(
                top: target.position.dy,
                left: target.position.dx,
                targetSize: drawTargetSetting.size,
              ),
            ),
            LineDraw(
              onStart: (detail) {
                ref
                    .read(lineDrawPageStateNotifierProvider.notifier)
                    .addPoints(detail);
              },
              onUpdate: (detail) {
                ref
                    .read(lineDrawPageStateNotifierProvider.notifier)
                    .updatePoints(detail);
              },
              onEnd: () {
                ref
                    .read(lineDrawPageStateNotifierProvider.notifier)
                    .checkPoints(context, screenSize, soundNo);
              },
              onInit: () {
                ref
                    .read(lineDrawPageStateNotifierProvider.notifier)
                    .init(context, soundNo);
              },
              screenSize: screenSize,
              soundNo: soundNo,
            ),
            isCompleted
                ? Completed(
                    onTap: () async {
                      ref
                          .read(lineDrawPageStateNotifierProvider.notifier)
                          .reset();
                      if (audioPlayer != null) {
                        audioPlayer!.stop();
                      }
                      AudioPlayer nextAudioPlayer = AudioPlayer();

                      // if (nextAudioPlayer != null) {
                      //   await nextAudioPlayer.stop();
                      // }

                       nextAudioPlayer.setAsset('assets/sounds/004.mp3');
                       nextAudioPlayer.play();

                      // await Future.delayed(const Duration(seconds: 1));

                      if (context.mounted) {
                        // await nextAudioPlayer.stop();
                        Navigator.of(context)
                            .pushReplacementNamed(nextPageRoute);
                      }
                    },
                    compledText: false,
                    screenSize: screenSize,
                    nextButtonSize: getStickerNextButtonSize(context),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    ));
  }
}
