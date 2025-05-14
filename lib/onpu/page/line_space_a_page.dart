//import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../page_state/line_space_a_page_state.dart';
import '../widget/background.dart';
import '../widget/completed.dart';
import '../widget/line_space_sticker.dart';
import '../setting.dart';
import '../widget/onpu_button.dart';

class LineSpaceAPage extends StatelessWidget {
  final bool type;
  const LineSpaceAPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize(context);

    return Scaffold(
        body: Center(
      /*child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.red,
            width: 2,
          ),
        ),
        alignment: Alignment.center,*/
      child: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: _MainParts(type),
      ),
    ));
  }
}

AudioPlayer audioPlayer = AudioPlayer();

class _MainParts extends ConsumerWidget {
  final bool type;
  const _MainParts(this.type);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(lineSpaceAPageNotifierProvider.notifier).init(type);
    bool isAllCompleted = ref.watch(
        lineSpaceAPageNotifierProvider.select((state) => state.isAllCompleted));
    Size screenSize = getScreenSize(context);
    String folder = getSizeFolderNameFromSize(screenSize);

    return isAllCompleted
        ? GestureDetector(
            onTap: () {
              ref.read(lineSpaceAPageNotifierProvider.notifier).reset();
              ref.read(lineSpaceAPageNotifierProvider.notifier).init(type);
              Navigator.of(context).pushReplacementNamed('/', arguments: 2);
            },
            child: Stack(
              children: [
                Container(color: Colors.white),
                Background(
                  name: 'assets/images/$folder/end.png',
                  width: screenSize.width,
                  height: screenSize.height,
                ),
              ],
            ))
        : Stack(
            children: [
              _GameParts(type),
              _NextButtonPart(type),
              _StartButtonPart(type),
            ],
          );
  }
}

class _GameParts extends ConsumerWidget {
  final bool type;
  const _GameParts(this.type);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size screenSize = getScreenSize(context);
    String folder = getSizeFolderNameFromSize(screenSize);
    final isStarted = ref.watch(
        lineSpaceAPageNotifierProvider.select((state) => state.isStarted));
    final level =
        ref.read(lineSpaceAPageNotifierProvider.select((state) => state.level));
    List<Offset> stickerPositions = getStickerPositions(context, type);
    ViewSetting fivelineSetting = getFiveLineAViewSetting(context, type);

    return Stack(
      children: [
        Background(
          name: getLineSpaceABGImageName(folder, level, type),
          width: screenSize.width,
          height: screenSize.height,
        ),
        ...stickerPositions.asMap().entries.map(
              (entry) => LineSpaceSticker(
                  initialLeft: entry.value.dx,
                  initialTop: entry.value.dy,
                  imageNmae:
                      getLineSpaceAPartName(context, level, entry.key, type),
                  onDragEnd: isStarted
                      ? (offset, detail) {
                          Size size =
                              getStickerSize(context, type, level, entry.key);
                          ref
                              .read(lineSpaceAPageNotifierProvider.notifier)
                              .lineSpaceCheck(
                                  context, offset, detail, size, type);
                        }
                      : null,
                  screenSize: screenSize,
                  stickerSize: getStickerSize(context, type, level, entry.key),
                  linePosition: fivelineSetting.position,
                  lineHeight: fivelineSetting.size.height,
                  isStarted: isStarted,
                  onReset: (func) {
                    ref
                        .read(lineSpaceAPageNotifierProvider.notifier)
                        .setResetFunc(func);
                  }),
            ),
        //_DebugViewPart(type),
      ],
    );
  }
}

class _NextButtonPart extends ConsumerWidget {
  final bool type;
  const _NextButtonPart(this.type);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCompleted = ref.watch(
        lineSpaceAPageNotifierProvider.select((state) => state.isCompleted));
    final ViewSetting nextButtonSetting =
        getLineSpaceANextButtonViewSetting(context, type);
    return isCompleted
        ? Stack(
            children: [
              OnpuButton(
                onTap: () {
                  ref.read(lineSpaceAPageNotifierProvider.notifier).next();
                },
                icon: true,
                imageName: getLineSpaceANextButtonImageName(context),
                position: nextButtonSetting.position,
                buttonSize: nextButtonSetting.size,

                
              ),
              Completed(
                imageName: 'assets/images/Completed.png',
                screenSize: getScreenSize(context),
                completedSize: getCompleteSize(context),
              )
            ],
          )
        : SizedBox();
  }
}

class _StartButtonPart extends ConsumerWidget {
  final bool type;
  const _StartButtonPart(this.type);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isStarted = ref.watch(
        lineSpaceAPageNotifierProvider.select((state) => state.isPreStarted));
    final ViewSetting startButtonSetting =
        getLineSpaceAStartButtonViewSetting(context, type);
    return isStarted
        ? SizedBox()
        : OnpuButton(
            onTap: () {
              ref.read(lineSpaceAPageNotifierProvider.notifier).start();
            },
            icon: true,
            imageName: getLineSpaceAStartButtonImageName(context),
            position: startButtonSetting.position,
            buttonSize: startButtonSetting.size,
          );
  }
}

// デバッグ用表示
// ignore: unused_element
class _DebugViewPart extends StatelessWidget {
  final bool lineType;
  const _DebugViewPart(this.lineType);
  @override
  Widget build(BuildContext context) {
    ViewSetting gakufuViewSetting =
        getLineSpaceAGakufuSetting(context, lineType);
    List<Offset> fiveLineAPositions = getFiveLineAPosition(context, lineType);
    return Stack(
      children: [
        Positioned(
          left: gakufuViewSetting.position.dx,
          top: gakufuViewSetting.position.dy,
          child: IgnorePointer(
            child: Container(
              color: Colors.blue.withOpacity(0.2),
              width: gakufuViewSetting.size.width,
              height: gakufuViewSetting.size.height * 4,
            ),
          ),
        ),
        ...fiveLineAPositions.map(
          (e) => Positioned(
            left: e.dx,
            top: e.dy,
            child: Container(
              color: Colors.red.withOpacity(1),
              width: gakufuViewSetting.size.width,
              height: 1,
            ),
          ),
        )
      ],
    );
  }
}
