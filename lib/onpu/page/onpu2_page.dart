import 'package:flutter/material.dart';
import '../page_state/onpu2_page_state.dart';
import '../setting.dart';
import '../widget/background.dart';
import '../widget/onpu_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// *線と間Cでも使う
class Onpu2Page extends StatelessWidget {
  final int keyType;
  final bool soundType;
  const Onpu2Page({super.key, required this.keyType, required this.soundType});

  @override
  Widget build(BuildContext context) {
    final screenSize = getScreenSize(context);
    return Scaffold(
        body: Center(
      child: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: Consumer(
          builder: (context, WidgetRef ref, child) {
            return _MainPart(keyType, soundType);
          },
        ),
      ),
    ));
  }
}

class _MainPart extends ConsumerWidget {
  final int keyType;
  final bool soundType;
  const _MainPart(this.keyType, this.soundType);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isCompleted = ref
        .watch(onpu2PageNotifierProvider.select((state) => state.isCompleted));
    String folder = getSizeFolderName(context);
    Size screenSize = getScreenSize(context);
    return isCompleted
        ? GestureDetector(
            onTap: () {
              ref.read(onpu2PageNotifierProvider.notifier).reset();
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
              Background(
                name: getOnpu2LineSpaceCBGName(context, keyType, soundType),
                width: screenSize.width,
                height: screenSize.height,
              ),
              // Background(
              //   name: 'assets/images/$folder/LineSpaceC/To/bg.png',
              //   width: screenSize.width,
              //   height: screenSize.height,
              // ),
              _GakufuPart(keyType, soundType),
              _ButtonPart(keyType),
            ],
          );
  }
}

class _GakufuPart extends ConsumerWidget {
  final int keyType;
  final bool soundType;
  const _GakufuPart(this.keyType, this.soundType);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String folder = getSizeFolderName(context);
    final isCompleted =
        ref.read(onpu2PageNotifierProvider.notifier).isCompleted();
    int level =
        ref.watch(onpu2PageNotifierProvider.select((state) => state.level)) -
            (isCompleted ? 1 : 0);
    final int index = ref
        .read(onpu2PageNotifierProvider.notifier)
        .getQuestion(level, keyType, soundType)
        .index;
    final String gakufuName = (keyType < 2)
        ? getOnpu2GakufuName(folder, index, soundType, keyType == 0)
        : getLineSpaceCGakufuName(folder, index, soundType, keyType == 2);
    final ViewSetting gakufuViewSetting = (keyType < 2)
        ? getOnpu2GakufuViewSetting(context, keyType == 0)
        : getLineSpaceCGakufuViewSetting(context);

    final ViewSetting nextButtonSetting =
        getOnpu2LineSpaceCNextButtonViewSetting(context, keyType);

    return Stack(
      children: [
        Positioned(
          left: gakufuViewSetting.position.dx,
          top: gakufuViewSetting.position.dy,
          child: Image.asset(
            gakufuName,
            width: gakufuViewSetting.size.width,
            height: gakufuViewSetting.size.height,
            fit: BoxFit.fitWidth,
          ),
        ),
        isCompleted
            ? OnpuButton(
                onTap: () {
                  ref.read(onpu2PageNotifierProvider.notifier).end();
                },
                icon: true,
                imageName: getOnpu2LineSpaceCNextButtonImageName(context),
                position: nextButtonSetting.position,
                buttonSize: nextButtonSetting.size,
              )
            : Container(
                color: Colors.transparent,
              ),
      ],
    );
  }
}

class _ButtonPart extends ConsumerWidget {
  final int keyType;
  const _ButtonPart(this.keyType);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isStarted =
        ref.watch(onpu2PageNotifierProvider.select((state) => state.isStarted));
    final isCompleted =
        ref.read(onpu2PageNotifierProvider.notifier).isCompleted();
    final List<OnpuKeyboardSetting> state = (keyType < 2)
        ? ((keyType == 0)
            ? getOnpuKenbanSetting(context)
            : getOnpuIconSetting(context))
        : getLineSpaceCButtonSetting(context, keyType == 2);
    final Size size = (keyType < 2)
        ? getOnpuIconSize(context)
        : getLineSpaceCButtonSize(context);
    final ViewSetting startViewSetting = (keyType < 2)
        ? getOnpu2StartButtonViewSetting(context, keyType == 0)
        : getLineSpaceCStartButtonViewSetting(context);
    return Stack(
      children: [
        ...state.map(
          (key) => OnpuButton(
            icon: key.image,
            imageName: key.imageName,
            onTap: (isCompleted || !isStarted)
                ? null
                : () {
                    ref
                        .read(onpu2PageNotifierProvider.notifier)
                        .checkCorrect(key.index);
                  },
            position: key.position,
            buttonSize:
                (keyType == 0) ? getKenbanSize(context, key.index) : size,
          ),
        ),
        isStarted
            ? const SizedBox()
            : OnpuButton(
                icon: true,
                imageName:
                    getOnpu2LineSpaceCStartButtonImageName(context, keyType),
                onTap: () {
                  ref.read(onpu2PageNotifierProvider.notifier).start();
                },
                position: startViewSetting.position,
                buttonSize: startViewSetting.size,
              ),
      ],
    );
  }
}
