import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../page_state/onpu_puzzle_he_page_state.dart';
import '../page_state/onpu_puzzle_page_state.dart';
import '../setting.dart';
import '../widget/background.dart';
import '../widget/puzzle_button.dart';
import '../widget/onpu_puzzle_piece.dart';

class OnpuPuzzleHePage extends StatelessWidget {
  final bool type;
  const OnpuPuzzleHePage({super.key, required this.type});
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
        /*child: Stack(
          children: [
            _MainParts(type),
            //_DebugView(),
          ],
        ),*/
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
    bool isAllCompleted = ref.watch(onpuPuzzleHePageNotifierProvider
        .select((state) => state.isAllCompleted));
    Size screenSize = getScreenSize(context);
    String folder = getSizeFolderNameFromSize(screenSize);
    // final String folder = getSizeFolderName(context);
    return isAllCompleted
        ? GestureDetector(
            onTap: () {
              ref.read(onpuPuzzlePageNotifierProvider.notifier).reset();
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
        : Stack(
            children: [
              Container(color: Colors.white, child: _GameParts(type)),
              Container(color: Colors.white, child: _NextButtonPart(type)),
            ],
          );
  }
}

class _GameParts extends ConsumerWidget {
  final bool type;
  const _GameParts(this.type);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool preStarted = ref.watch(
        onpuPuzzleHePageNotifierProvider.select((state) => state.isPreStarted));
    return !preStarted
        ? _TitleParts(type)
        : Stack(
            children: [
              _BackGround(type),
              _ButtonParts(type),
            ],
          );
  }
}

class _TitleParts extends ConsumerWidget {
  final bool type;
  const _TitleParts(this.type);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String sizeFolder = getSizeFolderName(context);
    String imageName = getOnpuPuzzleTitleBGName(sizeFolder, type);
    Size size = getScreenSize(context);
    final ViewSetting startViewSetting =
        getPuzzleStartButtonViewSetting(context);
    final String folder = getSizeFolderName(context);
    return Stack(
      children: [
        Background(
          name: imageName,
          width: size.width,
          height: size.height,
        ),
        _TitlePieceParts(type),
        Positioned(
          left: startViewSetting.position.dx,
          top: startViewSetting.position.dy,
          child: PuzzleButton(
            onTap: () {
              ref.read(onpuPuzzleHePageNotifierProvider.notifier).titleStart();
            },
            imageName: 'assets/images/$folder/tugihe.png',
            buttonSize: startViewSetting.size,
          ),
        ),
      ],
    );
  }
}

class _BackGround extends ConsumerWidget {
  final bool type;
  const _BackGround(this.type);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int level = ref
        .watch(onpuPuzzleHePageNotifierProvider.select((state) => state.level));
    Size size = getScreenSize(context);
    String sizeFolder = getSizeFolderName(context);
    String imageName = getOnpuPuzzleBGName(sizeFolder, level, type);
    return Background(
      name: imageName,
      width: size.width,
      height: size.height,
    );
  }
}

class _ButtonParts extends ConsumerWidget {
  final bool type;
  const _ButtonParts(this.type);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isStarted = ref.watch(
        onpuPuzzleHePageNotifierProvider.select((state) => state.isStarted));

    final ViewSetting startViewSetting =
        getPuzzleStartButtonViewSetting(context);
    final String folder = getSizeFolderName(context);

    return Stack(
      children: [
        _PieceParts(isStarted, type),
        Positioned(
          left: startViewSetting.position.dx,
          top: startViewSetting.position.dy,
          child: isStarted
              ? SizedBox()
              : PuzzleButton(
                  onTap: () {
                    ref
                        .read(onpuPuzzleHePageNotifierProvider.notifier)
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

class _PieceParts extends ConsumerWidget {
  final bool isStarted;
  final bool type;
  const _PieceParts(this.isStarted, this.type);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCompleted = ref.watch(
        onpuPuzzleHePageNotifierProvider.select((state) => state.isCompleted));

    List<OnpuPieceHeState> states = isStarted
        ? ref
            .read(onpuPuzzleHePageNotifierProvider.notifier)
            .getPieceStates(context, type)
        : ref
            .read(onpuPuzzleHePageNotifierProvider.notifier)
            .getPieceStartStates(context, type);

    final level = ref
        .read(onpuPuzzleHePageNotifierProvider.select((state) => state.level));

    final Size screenSize = getScreenSize(context);
    final String folder = getSizeFolderName(context);
    return Stack(
      children: [
        ...states.map(
          (state) => OnpuPuzzlePiece(
            index: state.index,
            initialLeft: state.position.dx,
            initialTop: state.position.dy,
            initialAngle: getPartAngle(context, level, state.index, type),
            isStarted: isStarted,
            isCompleted: isCompleted,
            type: type,
            isCorrect: ref
                .read(onpuPuzzleHePageNotifierProvider.notifier)
                .isCorrect(state.index),
            imageName: getOnpuPuzzleImageName(folder, state.index, type),
            onDragEnd: (index, offset, detail) {
              ref
                  .read(onpuPuzzleHePageNotifierProvider.notifier)
                  .judgePiece(context, index, offset, detail, type);
            },
            onUpdate: (index, position) {
              ref
                  .read(onpuPuzzleHePageNotifierProvider.notifier)
                  .setPiecePos(context, index, position, type);
            },
            onAdjust: (index, detail) {
              ref
                  .read(onpuPuzzleHePageNotifierProvider.notifier)
                  .adjustPiecePositions(context, index, detail, type);
            },
            screenSize: screenSize,
            pieceSize: getOnpuPuzzlePieceSize(context, state.index, type),
            correctPosition: ref
                .read(onpuPuzzleHePageNotifierProvider.notifier)
                .getCorrectPosition(context, state.index, isStarted, type),
          ),
        ),
      ],
    );
  }
}

class _TitlePieceParts extends ConsumerWidget {
  final bool type;
  const _TitlePieceParts(this.type);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<OnpuPieceHeState> states = ref
        .read(onpuPuzzleHePageNotifierProvider.notifier)
        .getPiecePreStartStates(context, type);

    final Size screenSize = getScreenSize(context);
    final String folder = getSizeFolderName(context);
    return Stack(
      children: [
        ...states.map(
          (state) => OnpuPuzzlePiece(
            index: state.index,
            initialLeft: state.position.dx,
            initialTop: state.position.dy,
            initialAngle: getPartAngle(context, 0, state.index, type),
            isStarted: false,
            isCompleted: false,
            isCorrect: false,
            type: type,
            imageName: getOnpuPuzzleImageName(folder, state.index, type),
            onDragEnd: (index, offset, detail) {
              ref
                  .read(onpuPuzzleHePageNotifierProvider.notifier)
                  .judgePiece(context, index, offset, detail, type);
            },
            onUpdate: (index, position) {
              ref
                  .read(onpuPuzzleHePageNotifierProvider.notifier)
                  .setPiecePos(context, index, position, type);
            },
            onAdjust: (index, detail) {
              ref
                  .read(onpuPuzzleHePageNotifierProvider.notifier)
                  .adjustPiecePositions(context, index, detail, type);
            },
            screenSize: screenSize,
            pieceSize: getOnpuPuzzlePieceSize(context, state.index, type),
            correctPosition: state.position,
          ),
        ),
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
        onpuPuzzleHePageNotifierProvider.select((state) => state.isCompleted));
    final ViewSetting nextViewSetting = getPuzzleNextButtonViewSetting(context);
    final String folder = getSizeFolderName(context);
    return isCompleted
        ? Positioned(
            left: nextViewSetting.position.dx,
            top: nextViewSetting.position.dy,
            child: PuzzleButton(
              onTap: () {
                ref.read(onpuPuzzleHePageNotifierProvider.notifier).next(type);
              },
              imageName: 'assets/images/$folder/tugihe.png',
              buttonSize: nextViewSetting.size,
            ),
          )
        : SizedBox();
  }
}

// ignore: unused_element
class _DebugView extends StatelessWidget {
  const _DebugView();
  @override
  Widget build(BuildContext context) {
    ViewSetting setting = getOnpuPuzzleCorrectAreaSetting(context);
    return Positioned(
      left: setting.position.dx,
      top: setting.position.dy,
      width: setting.size.width,
      height: setting.size.height,
      child: IgnorePointer(
        child: Container(
          color: Colors.red.withOpacity(0.5),
        ),
      ),
    );
  }
}
