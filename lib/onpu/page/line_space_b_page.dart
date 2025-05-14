import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../page_state/line_space_b_page_state.dart';
import '../setting.dart';
import '../widget/background.dart';
import '../widget/onpu_button.dart';

class LineSpaceBPage extends StatelessWidget {
  final bool type;
  const LineSpaceBPage({super.key, required this.type});

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

class _MainParts extends ConsumerWidget {
  final bool type;
  const _MainParts(this.type);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isAllCompleted = ref.watch(
        lineSpaceBPageNotifierProvider.select((state) => state.isAllCompleted));
    Size screenSize = getScreenSize(context);
    String folder = getSizeFolderNameFromSize(screenSize);

    return isAllCompleted
        ? GestureDetector(
            onTap: () {
              ref
                  .read(lineSpaceBPageNotifierProvider.notifier)
                  .initStart(context, true);

              Navigator.of(context).pushReplacementNamed('/');
            },
            child: Stack(
              children: [
                Container(color: Colors.white),
                Background(
                    name: 'assets/images/$folder/end.png',
                    width: screenSize.width,
                    height: screenSize.height),
              ],
            ))
        : Stack(
            children: [
              _GameParts(type),
              _NextPart(),
            ],
          );
  }
}

class _GameParts extends ConsumerWidget {
  final bool lineType;
  const _GameParts(this.lineType);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size screenSize = getScreenSize(context);
    String folder = getSizeFolderNameFromSize(screenSize);
    final level = ref
        .watch(lineSpaceBPageNotifierProvider.select((state) => state.level));

    return Stack(
      children: [
        Background(
          name: getLineSpaceBBGImageName(folder, lineType, level),
          width: screenSize.width,
          height: screenSize.height,
        ),
        _ButtonParts(folder, level, lineType),
      ],
    );
  }
}

class _ButtonParts extends ConsumerWidget {
  final String folder;
  final int level;
  final bool lineType;
  const _ButtonParts(this.folder, this.level, this.lineType);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<LineSpaceButtonSetting> state =
        getLineSpaceBButtonSetting(context, level);
    final isStarted = ref.watch(
        lineSpaceBPageNotifierProvider.select((state) => state.isStarted));
    final ViewSetting startButtonSetting =
        getLineSpaceBStartButtonViewSetting(context);

    return Stack(
      children: [
        ...state.asMap().entries.map(
              (entry) => OnpuButton(
                icon: true,
                imageName:
                    getLineSpaceBButtonImageName(folder, level, entry.key),
                position: entry.value.position,
                buttonSize: getLineSpaceBButtonSize(context, level, entry.key),
                onTap: !isStarted
                    ? null
                    : () {
                        ref
                            .read(lineSpaceBPageNotifierProvider.notifier)
                            .push(entry.value.index, context, lineType);
                      },
              ),
            ),
        isStarted
            ? SizedBox()
            : OnpuButton(
                onTap: () {
                  ref
                      .read(lineSpaceBPageNotifierProvider.notifier)
                      .start(context, lineType);
                },
                icon: true,
                imageName: 'assets/images/$folder/LineSpaceB/start_car.png',
                position: startButtonSetting.position,
                buttonSize: startButtonSetting.size,
              )
      ],
    );
  }
}

class _NextPart extends ConsumerWidget {
  const _NextPart();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCompleted = ref.watch(
        lineSpaceBPageNotifierProvider.select((state) => state.isCompleted));
    final ViewSetting nextButtonSetting =
        getLineSpaceBNextButtonViewSetting(context);
    String folder = getSizeFolderName(context);

    return isCompleted
        ? OnpuButton(
            onTap: () {
              ref.read(lineSpaceBPageNotifierProvider.notifier).next();
            },
            icon: true,
            imageName: 'assets/images/$folder/LineSpaceB/next.jpg',
            position: nextButtonSetting.position,
            buttonSize: nextButtonSetting.size,
          )
        : SizedBox();
  }
}
