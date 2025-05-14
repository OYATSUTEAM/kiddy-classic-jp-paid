import '../page_state/onpu1_page_state.dart';
import '../setting.dart';
import '../widget/background.dart';
import '../widget/onpu_button.dart';
import '../widget/flash_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Onpu1Page extends StatelessWidget {
  final bool soundType;
  const Onpu1Page({super.key, required this.soundType});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = getScreenSize(context);
    return Center(
      child: SizedBox(
        /*decoration: BoxDecoration(
          border: Border.all(
            color: Colors.red,
            width: 2,
          ),
        ),*/
        width: screenSize.width,
        height: screenSize.height,
        child: Stack(
          children: [
            _BackgroundPart(),
            _FlashCardPart(soundType),
            _AllCompletedPart(),
          ],
        ),
      ),
    );
  }
}

class _BackgroundPart extends ConsumerWidget {
  const _BackgroundPart();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(onpu1PageNotifierProvider.select((state) => state.level));

    String folderName = getSizeFolderName(context);
    final int sound = ref.read(onpu1PageNotifierProvider.notifier).getSoundNo();
    Size size = getScreenSize(context);
    return Background(
      name: getBackGroundImageName(folderName, sound),
      width: size.width,
      height: size.height,
    );
  }
}

class _FlashCardPart extends ConsumerWidget {
  final bool soundType;
  const _FlashCardPart(this.soundType);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isStarted =
        ref.watch(onpu1PageNotifierProvider.select((state) => state.isStarted));

    final soundNo = ref.read(onpu1PageNotifierProvider.notifier).getSoundNo();
    String folderName = getSizeFolderName(context);
    ViewSetting frashCardViewSetting = getFlashCardsViewSetting(context);
    ViewSetting carViewSetting = getOnpu1CarButtonViewSetting(context);
    ViewSetting planeViewSetting = getOnpu1PlaneButtonViewSetting(context);
    return isStarted
        ? _FlashCardPart2(soundType)
        : Stack(
            children: [
              Positioned(
                left: frashCardViewSetting.position.dx,
                top: frashCardViewSetting.position.dy,
                child: Image.asset(
                  getFlashCardImageName(folderName, soundNo, soundType),
                  width: frashCardViewSetting.size.width,
                  height: frashCardViewSetting.size.height,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
              OnpuButton(
                onTap: () {
                  ref.read(onpu1PageNotifierProvider.notifier).start(false);
                },
                icon: true,
                imageName: 'assets/images/$folderName/OnpuGame1/start_car.png',
                position: carViewSetting.position,
                buttonSize: carViewSetting.size,
              ),
              OnpuButton(
                onTap: () {
                  ref.read(onpu1PageNotifierProvider.notifier).start(true);
                },
                icon: true,
                imageName:
                    'assets/images/$folderName/OnpuGame1/start_plane.png',
                position: planeViewSetting.position,
                buttonSize: planeViewSetting.size,
              ),
            ],
          );
  }
}

class _FlashCardPart2 extends ConsumerWidget {
  final bool soundType;
  const _FlashCardPart2(this.soundType);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCompleted = ref
        .read(onpu1PageNotifierProvider.select((state) => state.isCompleted));
    final frashCards =
        ref.read(onpu1PageNotifierProvider.notifier).getFrashCards();

    final bool isEnd =
        ref.read(onpu1PageNotifierProvider.notifier).isEndFrash();
    final soundNo = ref.read(onpu1PageNotifierProvider.notifier).getSoundNo();
    int index =
        ref.watch(onpu1PageNotifierProvider.select((state) => state.index));
    int imageIndex = index >= frashCards.length
        ? frashCards[frashCards.length - 1].index
        : frashCards[index].index;
    String folderName = getSizeFolderName(context);
    String imageName = isEnd
        ? getFlashCardImageName(folderName, imageIndex, soundType)
        : getFlashCardImageName(folderName, soundNo, soundType);
    ViewSetting frashCardViewSetting = getFlashCardsViewSetting(context);

    return isCompleted
        ? Stack(
            children: [
              Positioned(
                left: frashCardViewSetting.position.dx,
                top: frashCardViewSetting.position.dy,
                child: Image.asset(
                  imageName,
                  width: frashCardViewSetting.size.width,
                  height: frashCardViewSetting.size.height,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
              _getNextButton(ref, folderName, context),
            ],
          )
        : Stack(
            children: [
              FlashCard(
                imageName:
                    getFlashCardImageName(folderName, imageIndex, soundType),
                position: frashCardViewSetting.position,
                size: frashCardViewSetting.size,
                speedType:
                    ref.read(onpu1PageNotifierProvider.notifier).getSpeedType(),
                index: index,
              ),
              _getCharaButton(ref, context),
            ],
          );
  }
}

Widget _getCharaButton(WidgetRef ref, BuildContext context) {
  ViewSetting charaViewSetting = getOnpu1CharaButtonViewSetting(context);
  return OnpuButton(
    onTap: () {
      ref.read(onpu1PageNotifierProvider.notifier).push();
    },
    icon: false,
    position: charaViewSetting.position,
    buttonSize: charaViewSetting.size,
  );
}

Widget _getNextButton(WidgetRef ref, String folderName, BuildContext context) {
  ViewSetting nextViewSetting = getOnpu1NextButtonViewSetting(context);
  return OnpuButton(
    onTap: () {
      ref.read(onpu1PageNotifierProvider.notifier).next();
    },
    icon: true,
    imageName: 'assets/images/$folderName/OnpuGame1/next.jpg',
    position: nextViewSetting.position,
    buttonSize: nextViewSetting.size,
  );
}

class _AllCompletedPart extends ConsumerWidget {
  const _AllCompletedPart();

  String getLastImageName(bool highSpeed, String folderName) {
    return highSpeed
        ? 'assets/images/$folderName/OnpuGame1/gold.png'
        : 'assets/images/$folderName/OnpuGame1/silver.png';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAllCompleted = ref.watch(
        onpu1PageNotifierProvider.select((state) => state.isAllCompleted));
    final bool speedType =
        ref.read(onpu1PageNotifierProvider.notifier).getSpeedType();
    String folderName = getSizeFolderName(context);
    Size size = getScreenSize(context);

    return isAllCompleted
        ? Background(
            name: getLastImageName(speedType, folderName),
            width: size.width,
            height: size.height,
          )
        : SizedBox();
  }
}
