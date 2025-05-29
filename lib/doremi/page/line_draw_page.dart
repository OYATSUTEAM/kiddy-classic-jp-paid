//import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kiddy_classic/doremi/page_state/sticker_page_state.dart';
import '../page_state/line_draw_page_state.dart';
import '../setting.dart';
import '../widget/background.dart';
import '../widget/completed.dart';
import '../widget/line_draw.dart';
import '../widget/line_draw_target.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/flavor_config.dart';

class LineDrawPage extends ConsumerStatefulWidget {
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
  ConsumerState<LineDrawPage> createState() => _LineDrawPageState();
}

class _LineDrawPageState extends ConsumerState<LineDrawPage> {
  final AudioPlayer nextAudioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nextAudioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCompleted = ref.watch(
        lineDrawPageStateNotifierProvider.select((state) => state.isCompleted));

    final screenSize = getScreenSize(context);
    final folder = getSizeFolderName(context);

    LineDrawTargetViewSetting drawTargetSetting =
        getDrawViewSetting(context, widget.soundNo);
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
                    '${FlavorConfig.assetPath}/images/$folder/${widget.imageName}',
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
                    .checkPoints(context, screenSize, widget.soundNo);
              },
              onInit: () {
                ref
                    .read(lineDrawPageStateNotifierProvider.notifier)
                    .init(context, widget.soundNo);
              },
              screenSize: screenSize,
              soundNo: widget.soundNo,
            ),
            isCompleted
                ? Completed(
                    onTap: () {
                      ref
                          .read(lineDrawPageStateNotifierProvider.notifier)
                          .reset();

                      nextAudioPlayer.setAsset('assets/sounds/004.mp3');
                      nextAudioPlayer.play();
                      ref
                          .read(stickerPageStateNotifierProvider.notifier)
                          .bgmStop();
                      if (context.mounted) {
                        Navigator.of(context).pushNamed(widget.nextPageRoute);
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
