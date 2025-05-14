import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../page_state/puzzle_page_state.dart';
import '../setting.dart';
import '../widget/background.dart';
import '../widget/puzzle_button.dart';
import '../widget/puzzle_piece.dart';

class PuzzlePage extends StatelessWidget {
  final bool type;
  const PuzzlePage({super.key, required this.type});
  @override
  Widget build(BuildContext context) {
    final Size screenSize = getScreenSize(context);

    return Scaffold(
        body: Center(
      child: SizedBox(
        /*decoration: BoxDecoration(
          border: Border.all(
            color: Colors.red,
            width: 2,
          ),
        ),
        alignment: Alignment.center,*/
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
        puzzlePageNotifierProvider.select((state) => state.isAllCompleted));
    Size screenSize = getScreenSize(context);
    String folder = getSizeFolderNameFromSize(screenSize);
    return isAllCompleted
        ? GestureDetector(
            onTap: () {
              ref.read(puzzlePageNotifierProvider.notifier).reset();
              Navigator.pushReplacementNamed(context, '/');
            },
            child: Container(
              color: Colors.white,
              width: screenSize.width,
              height: screenSize.height,
              child: Image.asset(
                'assets/images/$folder/end.png',
                width: screenSize.width,
                height: screenSize.height,
                fit: BoxFit.cover,
              ),
            ),
          )
        : Container(color: Colors.white, child: _GameParts(type));
  }
}

class _GameParts extends ConsumerWidget {
  final bool type;
  const _GameParts(this.type);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size screenSize = getScreenSize(context);
    String folder = getSizeFolderNameFromSize(screenSize);
    final ViewSetting nextViewSetting = getPuzzleNextButtonViewSetting(context);

    return Scaffold(
        body: Center(
      child: Stack(
        children: [
          _BackGround(type),
          _PieceParts(type),
          Positioned(
            left: nextViewSetting.position.dx,
            top: nextViewSetting.position.dy,
            child: Consumer(
              builder: (context, WidgetRef ref, child) {
                final isCompleted = ref.watch(puzzlePageNotifierProvider
                    .select((state) => state.isCompleted));

                return isCompleted
                    ? PuzzleButton(
                        onTap: () {
                          ref.read(puzzlePageNotifierProvider.notifier).next();
                        },
                        imageName: 'assets/images/$folder/tugihe.png',
                        buttonSize: nextViewSetting.size,
                      )
                    : SizedBox();
              },
            ),
          ),
        ],
      ),
    ));
  }
}

class _BackGround extends ConsumerWidget {
  final bool type;
  const _BackGround(this.type);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int level = type ? 0 : 1;
    Size size = getScreenSize(context);
    String sizeFolder = getSizeFolderName(context);
    String folder = getPuzzleFolderName(level);
    return Background(
      name: 'assets/images/$sizeFolder/$folder/bg.png',
      width: size.width,
      height: size.height,
    );
  }
}

class _PieceParts extends ConsumerWidget {
  final bool type;
  const _PieceParts(this.type);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isStarted = ref
        .watch(puzzlePageNotifierProvider.select((state) => state.isStarted));

    List<PieceState> states = isStarted
        ? ref
            .read(puzzlePageNotifierProvider.notifier)
            .getPieceStates(context, type)
        : ref
            .read(puzzlePageNotifierProvider.notifier)
            .getPieceStartStates(context, type);

    final int level = type ? 0 : 1;

    final ViewSetting piecesViewSetting = getPieceViewSetting(context, 0);
    final ViewSetting startViewSetting =
        getPuzzleStartButtonViewSetting(context);
    final Size screenSize = getScreenSize(context);
    final String folder = getSizeFolderName(context);

    return Stack(
      children: [
        ...states.map(
          (state) => PuzzlePiece(
            index: state.index,
            initialLeft: state.position.dx,
            initialTop: state.position.dy,
            initialAngle: state.angle,
            isStarted: isStarted,
            imageName: getPuzzleImageName(folder, state.index, level),
            onDragEnd: (index, offset, detail) {
              ref
                  .read(puzzlePageNotifierProvider.notifier)
                  .pieceCheck(context, index, offset, detail);
            },
            onReset: (detail) {
              ref
                  .read(puzzlePageNotifierProvider.notifier)
                  .setResetFunction(detail);
            },
            screenSize: screenSize,
            pieceSize: piecesViewSetting.size,
            correctPosition: ref
                .read(puzzlePageNotifierProvider.notifier)
                .getCorrectPosition(context, state.index),
          ),
        ),
        Positioned(
          left: startViewSetting.position.dx,
          top: startViewSetting.position.dy,
          child: isStarted
              ? SizedBox()
              : PuzzleButton(
                  onTap: () {
                    ref
                        .read(puzzlePageNotifierProvider.notifier)
                        .start(context, type);
                  },
                  imageName: 'assets/images/$folder/start.png',
                  buttonSize: startViewSetting.size,
                ),
        ),
      ],
    );
  }
}
