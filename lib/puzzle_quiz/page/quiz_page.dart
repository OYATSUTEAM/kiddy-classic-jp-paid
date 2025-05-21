import 'package:flutter/material.dart';
import '../page_state/quiz_page_state.dart';
import '../setting.dart';
import '../widget/background.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widget/puzzle_button.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

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
        child: Consumer(
          builder: (context, ref, child) {
            // Initialize the state when the page is first loaded
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ref.read(quizPageNotifierProvider.notifier).reset();
            });
            return _MainParts();
          },
        ),
      ),
    ));
  }
}

class _MainParts extends ConsumerWidget {
  const _MainParts();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isCompleted = ref
        .watch(quizPageNotifierProvider.select((state) => state.isCompleted));
    Size screenSize = getScreenSize(context);
    String folderName = getSizeFolderName(context);
    return isCompleted
        ? GestureDetector(
            onTap: () {
              ref.read(quizPageNotifierProvider.notifier).reset();
              Navigator.pushReplacementNamed(context, '/');
            },
            child: Container(
              color: Colors.white,
              width: screenSize.width,
              height: screenSize.height,
              child: Image.asset(
                'assets/images/$folderName/end.png',
                width: screenSize.width,
                height: screenSize.height,
                fit: BoxFit.cover,
              ),
            ),
          )
        : Container(color: Colors.white, child: _GameParts());
  }
}

class _GameParts extends ConsumerWidget {
  const _GameParts();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size screenSize = getScreenSize(context);
    String folderName = getSizeFolderName(context);

    return Stack(
      children: [
        Background(
          name: 'assets/images/$folderName/bg.png',
          width: screenSize.width,
          height: screenSize.height,
        ),
        Consumer(
          builder: (context, WidgetRef ref, child) {
            final isStarted = ref.watch(
                quizPageNotifierProvider.select((state) => state.isStarted));
            final isPreStarted = ref.read(
                quizPageNotifierProvider.select((state) => state.isPreStarted));
            final level = ref
                .watch(quizPageNotifierProvider.select((state) => state.level));
            ViewSetting quizButtonSetting = getQuizButtonViewSetting(context);
            List<Offset> quizButtonPositions = getQuizButtonPositions(context);
            ViewSetting nextButtonSetting = getNextButtonViewSetting(context);
            return Stack(
              children: [
                ...quizButtonPositions.asMap().entries.map(
                      (entry) => Positioned(
                        left: entry.value.dx,
                        top: entry.value.dy,
                        width: quizButtonSetting.size.width,
                        height: quizButtonSetting.size.height,
                        child: PuzzleButton(
                          image: true,
                          imageName:
                              getSoundButtonName(folderName, entry.key, level),
                          buttonSize: quizButtonSetting.size,
                          onTap: isStarted
                              ? () {
                                  ref
                                      .read(quizPageNotifierProvider.notifier)
                                      .checkCorrect(entry.key);
                                }
                              : () {},
                        ),
                      ),
                    ),
                (isStarted || !isPreStarted)
                    ? Container()
                    : _getNextButton(ref, folderName, nextButtonSetting),
              ],
            );
          },
        ),
        Consumer(builder: (context, ref, child) {
          final isPreStarted = ref.watch(
              quizPageNotifierProvider.select((state) => state.isPreStarted));
          ViewSetting startButtonSetting = getStartButtonViewSetting(context);

          return isPreStarted
              ? Container()
              : _getStartButton(ref, folderName, startButtonSetting);
        })
      ],
    );
  }
}

Widget _getStartButton(
    WidgetRef ref, String folderName, ViewSetting startButtonSetting) {
  return Positioned(
    left: startButtonSetting.position.dx,
    top: startButtonSetting.position.dy,
    width: startButtonSetting.size.width,
    height: startButtonSetting.size.height,
    child: PuzzleButton(
      image: true,
      imageName: 'assets/images/$folderName/start_racing.png',
      buttonSize: startButtonSetting.size,
      onTap: () {
        ref.read(quizPageNotifierProvider.notifier).start();
      },
    ),
  );
}

Widget _getNextButton(
    WidgetRef ref, String folderName, ViewSetting nextButtonSetting) {
  return Positioned(
    left: nextButtonSetting.position.dx,
    top: nextButtonSetting.position.dy,
    width: nextButtonSetting.size.width,
    height: nextButtonSetting.size.height,
    child: PuzzleButton(
      image: true,
      imageName: 'assets/images/$folderName/next.png',
      buttonSize: nextButtonSetting.size,
      onTap: () {
        ref.read(quizPageNotifierProvider.notifier).nextLevel();
      },
    ),
  );
}
