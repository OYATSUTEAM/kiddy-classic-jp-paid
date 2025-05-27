import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../setting.dart';
import '../widget/onpu_puzzle_piece.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';

class OnpuPuzzlePageState {
  final bool isPreStarted;
  final bool isStarted;
  final bool isCompleted;
  final bool isAllCompleted;
  final int level;

  OnpuPuzzlePageState({
    required this.isPreStarted,
    required this.isStarted,
    required this.isCompleted,
    required this.isAllCompleted,
    required this.level,
  });
}

class OnpuPieceState {
  int index;
  Offset position;

  OnpuPieceState({
    required this.index,
    required this.position,
  });
}

class OnpuCompleteState {
  int linkIndex;
  bool isCompleted;

  OnpuCompleteState({
    required this.linkIndex,
    required this.isCompleted,
  });
}

class OnpuPuzzlePageStateNotifier extends StateNotifier<OnpuPuzzlePageState> {
  int _completedCount = 0;
  int _targetCount = 0;
  List<OnpuCompleteState> _onpuStates = List.empty(growable: true);
  List<bool> _isPieceCorrectArea = List.empty(growable: true);
  List<OnpuPieceState> piecesInit = List.empty(growable: true);
  List<OnpuPieceState> pieceStates = List.empty(growable: true);
  List<OnpuPieceState> piecePreStartStates = List.empty(growable: true);
  final _audioPlayer = AudioPlayer();
  final _completeAudioPlayer = AudioPlayer();
  final _bgmAudioPlayer = AudioPlayer();
  bool _isBGMPlaying = false;
  Size oldScreenSize = Size(-1, -1);
  bool _isStart = false;
  bool _isPreStart = false;

  OnpuPuzzlePageStateNotifier()
      : super(
          OnpuPuzzlePageState(
              isPreStarted: false,
              isStarted: false,
              isCompleted: false,
              isAllCompleted: false,
              level: 0),
        );

  void init(BuildContext context, bool type) {
    _targetCount = getOnpuPuzzlePartNum(type);
    _completedCount = 0;
    _isPieceCorrectArea = List.filled(_targetCount, true); // 最初は全ピース正解内にいる
    piecesInit = List.empty(growable: true);
    pieceStates = List.empty(growable: true);
    _onpuStates = List.empty(growable: true);
    List<int> indexes = List.generate(_targetCount, (index) => index);
    indexes.shuffle();
    oldScreenSize = getScreenSize(context);
    ViewSetting area = getOnpuPuzzleCorrectAreaSetting(context);
    Offset ofs =
        area.position + Offset(area.size.width / 2, area.size.height / 2);
    for (int i = 0; i < _targetCount; i++) {
      _onpuStates.add(OnpuCompleteState(linkIndex: -1, isCompleted: false));
      List<Offset> positions = getOnpuStartPositions(context, type);
      Size pieceSize = getOnpuPuzzlePieceSize(context, indexes[i], type);
      Offset piecePos = positions[i] +
          ofs -
          Offset(pieceSize.width / 2, pieceSize.height / 2);
      if (area.position.dx < piecePos.dx &&
          piecePos.dx + pieceSize.width < area.position.dx + area.size.width &&
          area.position.dy < piecePos.dy &&
          piecePos.dy + pieceSize.height <
              area.position.dy + area.size.height) {
      } else {
        // 枠内に収まるように補正
        piecePos = adjustInsideArea(piecePos, pieceSize, area.position,
            area.size, getOnpuPieceMargin(context, indexes[i], type));
      }
      piecesInit.add(OnpuPieceState(index: indexes[i], position: piecePos));
      pieceStates.add(OnpuPieceState(index: indexes[i], position: piecePos));
    }
  }

  void bgmPlay() {
    if (!_isBGMPlaying) {
      _bgmAudioPlayer.setLoopMode(LoopMode.all);
      _bgmAudioPlayer.setAsset('assets/sounds/BGM_01.mp3');
      _bgmAudioPlayer.play();
      _isBGMPlaying = true;
    }
  }

  List<OnpuPieceState> getPieceStates(BuildContext context, bool type) {
    if (_targetCount <= 0) {
      init(context, type);
    }

    return piecesInit;
  }

  List<OnpuPieceState> getPieceStartStates(BuildContext context, bool type) {
    List<OnpuPieceState> pieceStartStates = List.empty(growable: true);
    List<OnpuPuzzleSetting> puzzleSettings =
        getOnpuPuzzleSetting(context, state.level, type);
    ViewSetting area = getOnpuPuzzleCorrectAreaSetting(context);
    Offset ofs =
        area.position + Offset(area.size.width / 2, area.size.height / 2);
    int cnt = 0;
    int num = getOnpuPuzzlePartNum(type);
    for (int i = 0; i < num; i++) {
      if (isCorrectPiece(puzzleSettings, i)) {
        List<Offset> positions =
            getOnpuCorrectPositions(context, state.level, type);
        pieceStartStates
            .add(OnpuPieceState(index: i, position: positions[cnt++] + ofs));
      }
    }
    return pieceStartStates;
  }

  List<OnpuPieceState> getPiecePreStartStates(BuildContext context, bool type) {
    int num = getOnpuPuzzlePartNum(type);
    ViewSetting area = getOnpuPuzzleCorrectAreaSetting(context);
    Offset ofs =
        area.position + Offset(area.size.width / 2, area.size.height / 2);
    List<int> indexes = List.generate(num, (index) => index);
    if (_isPreStart) {
      for (int i = 0; i < indexes.length; i++) {
        indexes[i] = piecePreStartStates[i].index;
      }
    } else {
      indexes.shuffle();
    }
    piecePreStartStates = List.empty(growable: true);

    for (int i = 0; i < num; i++) {
      _onpuStates.add(OnpuCompleteState(linkIndex: -1, isCompleted: false));
      List<Offset> positions = getOnpuStartPositions(context, type);
      Size pieceSize = getOnpuPuzzlePieceSize(context, indexes[i], type);
      Offset piecePos = positions[i] +
          ofs -
          Offset(pieceSize.width / 2, pieceSize.height / 2);
      if (area.position.dx < piecePos.dx &&
          piecePos.dx + pieceSize.width < area.position.dx + area.size.width &&
          area.position.dy < piecePos.dy &&
          piecePos.dy + pieceSize.height <
              area.position.dy + area.size.height) {
      } else {
        // 枠内に収まるように補正
        piecePos = adjustInsideArea(piecePos, pieceSize, area.position,
            area.size, getOnpuPieceMargin(context, indexes[i], type));
      }
      piecePreStartStates
          .add(OnpuPieceState(index: indexes[i], position: piecePos));
    }
    _isPreStart = true;
    return piecePreStartStates;
  }

  Offset getCorrectPosition(
      BuildContext context, int idx, bool isStart, bool type) {
    if (!isStart) {
      ViewSetting area = getOnpuPuzzleCorrectAreaSetting(context);
      Offset ofs =
          area.position + Offset(area.size.width / 2, area.size.height / 2);
      Offset pos = Offset.zero;
      List<OnpuPieceState> states = getPieceStartStates(context, type);
      for (int i = 0; i < states.length; i++) {
        if (states[i].index == idx) {
          pos = states[i].position;
          break;
        }
      }
      return pos + ofs;
    } else {
      if (_targetCount <= 0) {
        init(context, type);
      }
      return pieceStates[idx].position;
    }
  }

  void reset() {
    _targetCount = 0;
    _completedCount = 0;
    _isStart = false;
    _isPreStart = false;
    _isBGMPlaying = false;

    _onpuStates = List.empty(growable: true);
    piecesInit = List.empty(growable: true);
    pieceStates = List.empty(growable: true);
    _audioPlayer.stop();
    _completeAudioPlayer.stop();
    _bgmAudioPlayer.stop();
    state = OnpuPuzzlePageState(
      isPreStarted: false,
      isStarted: false,
      isCompleted: false,
      isAllCompleted: false,
      level: 0,
    );
  }

  void start(BuildContext context, bool type) {
    if (_isStart) {
      return;
    }
    _isStart = true;
    init(context, type);
    _audioPlayer.setAsset('assets/sounds/car.mp3');
    _audioPlayer.play();
    Future.delayed(Duration(seconds: 3), () {
      state = OnpuPuzzlePageState(
        isPreStarted: true,
        isStarted: true,
        isCompleted: false,
        isAllCompleted: false,
        level: state.level,
      );
    });
  }

  void setPiecePos(
      BuildContext context, int index, Offset position, bool type) {
    if (_targetCount <= 0) {
      init(context, type);
    }

    pieceStates[index].position = position; // ピースの位置を更新
  }

  void judgePiece(BuildContext context, int idx, Offset offset,
      StreamController<OnpuPiecePosition> details, bool type) {
    if (idx >= _targetCount) {
      return;
    }
    if (state.isCompleted || state.isAllCompleted) {
      return;
    }

    List<OnpuPuzzleSetting> puzzleSettings =
        getOnpuPuzzleSetting(context, state.level, type);
    if (_onpuStates[idx].isCompleted) {
      // 正解済みのピースを動かした場合
      if (isCorrectPiece(puzzleSettings, idx)) {
        _onpuStates[idx].isCompleted = false;
        _completedCount--;
        int link = _onpuStates[idx].linkIndex;
        _onpuStates[idx].linkIndex = -1;
        if (link >= 0 &&
            _onpuStates[link].isCompleted &&
            _onpuStates[link].linkIndex < 0) {
          _onpuStates[link].isCompleted = false;
          _completedCount--;
        }
        for (int i = 0; i < _targetCount; i++) {
          if (i == idx) {
            continue;
          }
          if (_onpuStates[i].linkIndex == idx) {
            _onpuStates[i].linkIndex = -1;
            if (_onpuStates[i].isCompleted) {
              _onpuStates[i].isCompleted = false;
              _completedCount--;
            }
          }
        }
        if (!isPieceCorrectArea(context, idx, offset, type)) {
          _isPieceCorrectArea[idx] = false;
          return; //動かして正解エリアから出たならreturn。それ以外は↓で再チェックする
        }
      } else {
        if (!isPieceOutsideArea(context, idx, offset, type)) {
          // 使わないピースを正解エリア内に動かした場合
          _onpuStates[idx].isCompleted = false;
          _completedCount--;
        }
        return; // 正解済みだった使わないピースは↓のチェック不要なのでreturn
      }
    }
    bool correctPiece = isCorrectPiece(puzzleSettings, idx);
    if ((correctPiece && !isPieceCorrectArea(context, idx, offset, type)) ||
        (!correctPiece && isPieceCorrectArea(context, idx, offset, type))) {
      _isPieceCorrectArea[idx] = false;
      return; // 正解のピースを不正解の場所に動かした場合、使わないピースを正解の場所に動かした場合はreturn
    } else if (!correctPiece) {
      if (isPieceOutsideArea(context, idx, offset, type)) {
        // 完全に枠外に出た場合
        _onpuStates[idx].isCompleted = true;
        _completedCount++; // 不正解のピースを不正解の場所に動かした場合
        int index0 = puzzleSettings[0].index;
        if (_completedCount >= _targetCount - 1 &&
            puzzleSettings.length == 1 &&
            !_onpuStates[index0].isCompleted &&
            isPieceCorrectArea(
                context, index0, pieceStates[index0].position, type)) {
          _onpuStates[index0].isCompleted = true;
          _completedCount++;
        }
      }
    } else {
      _isPieceCorrectArea[idx] = true;
      // 動かしたのが正解のピースなら、他ピースとの位置をチェック
      if (puzzleSettings.length == 1) {
        _onpuStates[idx].isCompleted = true;
        _completedCount++; // 全音符の場合は位置補正不要
      } else {
        Offset pieceOfs = Offset.zero;
        double scale = getScreenScale(context);
        for (int i = 0; i < puzzleSettings.length; i++) {
          if (puzzleSettings[i].index == idx) {
            pieceOfs = puzzleSettings[i].offset * scale;
            break;
          }
        }
        for (int i = 0; i < puzzleSettings.length; i++) {
          if (puzzleSettings[i].index == idx) {
            continue; // 自分自身なら無視
          }
          if (!isPieceCorrectArea(context, puzzleSettings[i].index,
              pieceStates[puzzleSettings[i].index].position, type)) {
            continue; // チェックするピースが枠外なら無視
          }
          ViewSetting area = getOnpuPuzzleCorrectAreaSetting(context);
          Offset center =
              area.position + Offset(area.size.width / 2, area.size.height / 2);
          Offset targetOfs = puzzleSettings[i].offset * scale;
          Offset targetPos = center +
              targetOfs -
              pieceStates[puzzleSettings[i].index].position;
          Offset newPos = pieceStates[puzzleSettings[i].index].position -
              targetOfs +
              pieceOfs;

          if (!isPieceCorrectArea(context, idx, newPos, type)) {
            continue; // 補正で枠外に行くなら無視
          }
          Offset piecePos = center + pieceOfs - offset;
          double range = getOnpuPuzzleCheckSize(context); // どのくらいの範囲で合っているとするか
          if (targetPos.dx < piecePos.dx + range &&
              piecePos.dx - range < targetPos.dx &&
              targetPos.dy < piecePos.dy + range &&
              piecePos.dy - range < targetPos.dy) {
            _onpuStates[idx].isCompleted = true;
            _completedCount++;
            _audioPlayer.setAsset('assets/sounds/success.mp3');
            _audioPlayer.play();
            pieceStates[idx].position = newPos;

            double angle = getPartAngle(
                context, state.level, puzzleSettings[i].index, type);
            // 他のピースに合わせて補正した位置に移動
            details.add(OnpuPiecePosition(
              angle: angle,
              left: pieceStates[idx].position.dx,
              top: pieceStates[idx].position.dy,
              isCompleted: false,
            ));
            if (!_onpuStates[puzzleSettings[i].index].isCompleted) {
              _completedCount++; // はめられたピースも正解済みにする
              _onpuStates[puzzleSettings[i].index].isCompleted = true;
              if (_onpuStates[puzzleSettings[i].index].linkIndex < 0 ||
                  _onpuStates[puzzleSettings[i].index].linkIndex == idx) {
                _onpuStates[idx].linkIndex = puzzleSettings[i].index;
              }
            }
            break;
          }
        }
      }
    }

    if (_completedCount >= _targetCount) {
      _completeAudioPlayer.setAsset('assets/sounds/complete.mp3');
      _completeAudioPlayer.play();
      state = OnpuPuzzlePageState(
        isPreStarted: true,
        isStarted: state.isStarted,
        isCompleted: true,
        isAllCompleted: false,
        level: state.level,
      );
    }
  }

  bool isPieceCorrectArea(
      BuildContext context, int index, Offset offset, bool type) {
    ViewSetting correctArea = getOnpuPuzzleCorrectAreaSetting(context);
    Size pieceSize = getOnpuPuzzlePieceSize(context, index, type);
    OnpuPieceMargin margin = getOnpuPieceMargin(context, index, type);

    if (correctArea.position.dx <= offset.dx + margin.left &&
        offset.dx + pieceSize.width - margin.right <=
            correctArea.position.dx + correctArea.size.width &&
        correctArea.position.dy <= offset.dy + margin.top &&
        offset.dy + pieceSize.height - margin.bottom <=
            correctArea.position.dy + correctArea.size.height) {
      return true;
    }
    return false;
  }

  // 枠外に完全に出ているかチェック
  bool isPieceOutsideArea(
      BuildContext context, int index, Offset offset, bool type) {
    ViewSetting correctArea = getOnpuPuzzleCorrectAreaSetting(context);
    Size pieceSize = getOnpuPuzzlePieceSize(context, index, type);

    if (offset.dx < correctArea.position.dx - pieceSize.width ||
        correctArea.position.dx + correctArea.size.width < offset.dx ||
        offset.dy < correctArea.position.dy - pieceSize.height ||
        correctArea.position.dy + correctArea.size.height < offset.dy) {
      return true;
    }
    return false;
  }

  // 使用するピースかどうか
  bool isCorrectPiece(List<OnpuPuzzleSetting> setting, int index) {
    for (int i = 0; i < setting.length; i++) {
      if (setting[i].index == index) {
        return true;
      }
    }
    return false;
  }

  void next(bool type) {
    int level = state.level;
    level++;
    if (level >= getOnpuPuzzleNum(type)) {
      end();
      return;
    }
    _targetCount = 0;
    _completedCount = 0;
    _onpuStates = List.empty(growable: true);
    piecesInit = List.empty(growable: true);
    pieceStates = List.empty(growable: true);
    _isStart = false;
    _audioPlayer.setAsset('assets/sounds/next.mp3');
    _audioPlayer.play();
    state = OnpuPuzzlePageState(
      isPreStarted: true,
      isStarted: false,
      isCompleted: false,
      isAllCompleted: false,
      level: level,
    );
  }

  void titleStart() {
    _audioPlayer.setAsset('assets/sounds/next.mp3');
    _audioPlayer.play();
    bgmPlay();
    state = OnpuPuzzlePageState(
      isPreStarted: true,
      isStarted: false,
      isCompleted: false,
      isAllCompleted: false,
      level: 0,
    );
  }

  void adjustPiecePositions(BuildContext context, int index,
      StreamController<OnpuPiecePosition> details, bool type) {
    Size oldSize = oldScreenSize;
    Size currentScreenSize = getScreenSize(context);
    int oldIndex = getScreenSizeIndex(oldScreenSize);
    int currentIndex = getScreenSizeIndex(currentScreenSize);
    double oldScale = getScreenScaleFromSize(oldScreenSize);
    double currentScale = getScreenScaleFromSize(currentScreenSize);
    double scaleX = currentScreenSize.width / oldScreenSize.width;
    double scaleY = currentScreenSize.height / oldScreenSize.height;
    oldScreenSize = currentScreenSize;
    if (oldSize.width < 0 || oldSize.height < 0) {
      return;
    }
    if (_targetCount <= 0) {
      return;
    }

    if (oldSize == currentScreenSize) {
      details.add(OnpuPiecePosition(
        angle: 0,
        left: pieceStates[index].position.dx,
        top: pieceStates[index].position.dy,
        isCompleted: false,
      ));
      return;
    }

    if (oldIndex == currentIndex) {
      for (int i = 0; i < _targetCount; i++) {
        pieceStates[i].position = Offset(
          pieceStates[i].position.dx * scaleX,
          pieceStates[i].position.dy * scaleY,
        );
        Size pieceSize = getOnpuPuzzlePieceSize(context, i, type);
        pieceStates[i].position = adjustInsideArea(
            pieceStates[i].position,
            pieceSize,
            Offset.zero,
            currentScreenSize,
            getOnpuPieceMargin(context, i, type)); // 画面外に出ないように補正
      }
      details.add(OnpuPiecePosition(
        angle: 0,
        left: pieceStates[index].position.dx,
        top: pieceStates[index].position.dy,
        isCompleted: false,
      ));
      return; // スケール変わっただけならこれ以上の補正は不要なはず
    }

    List<OnpuPuzzleSetting> puzzleSettings =
        getOnpuPuzzleSetting(context, state.level, type);
    List<ViewSetting> viewSettings = getOnpuPuzzleCorrectAreaSettings();
    Offset currentCenterPos = (viewSettings[currentIndex].position +
            Offset(viewSettings[currentIndex].size.width / 2,
                viewSettings[currentIndex].size.height / 2)) *
        currentScale;
    Size currentAreaSize = viewSettings[currentIndex].size * currentScale;
    Offset oldCenterPos = (viewSettings[oldIndex].position +
            Offset(viewSettings[oldIndex].size.width / 2,
                viewSettings[oldIndex].size.height / 2)) *
        oldScale;

    // ピース座標を補正
    for (int i = 0; i < _targetCount; i++) {
      Offset center = currentCenterPos -
          Offset(currentAreaSize.width / 2, currentAreaSize.height / 2);

      Size pieceSize = getOnpuPuzzlePieceSize(context, i, type);
      Offset ofs = pieceStates[i].position - oldCenterPos;
      double ofsScaleX = currentAreaSize.width /
          (viewSettings[oldIndex].size.width * oldScale);
      double ofsScaleY = currentAreaSize.height /
          (viewSettings[oldIndex].size.height * oldScale);
      pieceStates[i].position = currentCenterPos +
          Offset(ofs.dx * ofsScaleX, ofs.dy * ofsScaleY); // 補正
      pieceStates[i].position = adjustInsideArea(
          pieceStates[i].position,
          pieceSize,
          Offset.zero,
          currentScreenSize,
          getOnpuPieceMargin(context, i, type)); // 補正後に画面外に出た場合は再補正

      if (isCorrectPiece(puzzleSettings, i)) {
        adjustUsePiece(context, i, center, currentAreaSize, currentScreenSize,
            pieceSize, puzzleSettings, type);
      } else {
        adjustUnusedPiece(context, i, center, currentAreaSize,
            currentScreenSize, pieceSize, type);
      }
    }

    details.add(OnpuPiecePosition(
      angle: 0,
      left: pieceStates[index].position.dx,
      top: pieceStates[index].position.dy,
      isCompleted: false,
    ));
  }

  // 指定範囲外に出ないように補正する
  Offset adjustInsideArea(Offset pos, Size pieceSize, Offset minPos,
      Size areaSize, OnpuPieceMargin margin) {
    if (pos.dx + margin.left < minPos.dx) {
      pos = Offset(minPos.dx - margin.left, pos.dy);
    } else if (pos.dx + pieceSize.width - margin.right >
        minPos.dx + areaSize.width) {
      pos = Offset(
          minPos.dx + areaSize.width - pieceSize.width + margin.right, pos.dy);
    }
    if (pos.dy + margin.top < minPos.dy) {
      pos = Offset(pos.dx, minPos.dy);
    } else if (pos.dy + pieceSize.height - margin.bottom >
        minPos.dy + areaSize.height) {
      pos = Offset(pos.dx,
          minPos.dy + areaSize.height - pieceSize.height + margin.bottom);
    }
    return pos;
  }

  // 必要ピースの補正
  void adjustUsePiece(
      BuildContext context,
      int index,
      Offset center,
      Size currentAreaSize,
      Size currentScreenSize,
      Size pieceSize,
      List<OnpuPuzzleSetting> puzzleSettings,
      bool type) {
    Offset currentCenterPos =
        center + Offset(currentAreaSize.width / 2, currentAreaSize.height / 2);
    if (_onpuStates[index].isCompleted) {
      // 正解済みなら開始時の位置に戻してしまう
      for (int j = 0; j < puzzleSettings.length; j++) {
        if (puzzleSettings[j].index == index) {
          pieceStates[index].position = currentCenterPos +
              getOnpuCorrectPositions(context, state.level, type)[j];
          break;
        }
      }
      return;
    }

    bool isCorrectArea =
        isPieceCorrectArea(context, index, pieceStates[index].position, type);
    if (_isPieceCorrectArea[index] && !isCorrectArea) {
      // 正解エリア内にあるはずのピースが枠外に出ていたら補正
      Offset newPos =
          forceAdjustInside(index, center, currentAreaSize, pieceSize); // 枠内に移動
      newPos = adjustInsideArea(
          newPos,
          pieceSize,
          Offset.zero,
          currentScreenSize,
          getOnpuPieceMargin(context, index, type)); // 補正後に画面外に出た場合は再補正

      if (!isPieceCorrectArea(context, index, newPos, type)) {
        // どっちを補正してもダメなら中心位置に移動してしまう
        newPos = currentCenterPos -
            Offset(pieceSize.width / 2, pieceSize.height / 2);
      }

      pieceStates[index].position = newPos;
    } else if (!_isPieceCorrectArea[index] && isCorrectArea) {
      // 枠外にあるはずのピースが正解エリア内に入っていた場合
      Offset newPos = forceAdjustOutside(
          index, center, currentAreaSize, pieceSize); // 枠外に移動
      newPos = adjustInsideArea(
          newPos,
          pieceSize,
          Offset.zero,
          currentScreenSize,
          getOnpuPieceMargin(context, index, type)); // 補正後に画面外に出た場合は再補正

      if (isPieceCorrectArea(context, index, newPos, type)) {
        // どっちを補正してもダメならX=0座標に移動してしまう
        newPos = Offset(0, newPos.dy);
      }

      pieceStates[index].position = newPos;
    }
  }

  // 不要ピースの補正
  void adjustUnusedPiece(BuildContext context, int index, Offset center,
      Size currentAreaSize, Size currentScreenSize, Size pieceSize, bool type) {
    Offset currentCenterPos =
        center + Offset(currentAreaSize.width / 2, currentAreaSize.height / 2);
    if (_onpuStates[index].isCompleted) {
      // 正解済みの不要ピースが枠内に入っていれば補正
      if (!isPieceOutsideArea(
          context, index, pieceStates[index].position, type)) {
        Offset newPos = forceAdjustOutside(
            index, center, currentAreaSize, pieceSize); // 枠外に移動
        newPos = adjustInsideArea(
            newPos,
            pieceSize,
            Offset.zero,
            currentScreenSize,
            getOnpuPieceMargin(context, index, type)); // 補正後に画面外に出た場合は再補正

        if (!isPieceOutsideArea(context, index, newPos, type)) {
          // どっちを補正してもダメならX=0位置に移動
          newPos = Offset(0, newPos.dy);
        }
        pieceStates[index].position = newPos;
      }
    } else {
      // 枠内にあるはずの不要ピースが枠外に出ていたら補正
      if (isPieceOutsideArea(
          context, index, pieceStates[index].position, type)) {
        Offset newPos = forceAdjustInside(
            index, center, currentAreaSize, pieceSize); // 枠内に移動
        newPos = adjustInsideArea(
            newPos,
            pieceSize,
            Offset.zero,
            currentScreenSize,
            getOnpuPieceMargin(context, index, type)); // 補正後に画面外に出た場合は再補正
        if (!isPieceCorrectArea(context, index, newPos, type)) {
          // どっちを補正してもダメなら中心位置に移動してしまう
          newPos = Offset(currentCenterPos.dx - pieceSize.width / 2,
              currentCenterPos.dy - pieceSize.height / 2);
        }
        pieceStates[index].position = newPos;
      }
    }
  }

  // 枠内に移動
  Offset forceAdjustInside(
      int index, Offset center, Size currentAreaSize, Size pieceSize) {
    Offset currentCenterPos =
        center + Offset(currentAreaSize.width / 2, currentAreaSize.height / 2);
    double newX = pieceStates[index].position.dx;
    double newY = pieceStates[index].position.dy;
    if (pieceStates[index].position.dx - pieceSize.width < center.dx ||
        center.dx + currentAreaSize.width <
            pieceStates[index].position.dx + pieceSize.width) {
      if (pieceStates[index].position.dx + pieceSize.width / 2 <
          currentCenterPos.dx) {
        newX = center.dx + 1;
      } else {
        newX = currentCenterPos.dx +
            (currentAreaSize.width / 2) -
            pieceSize.width -
            1;
      }
    }
    if (pieceStates[index].position.dy - pieceSize.height < center.dy ||
        center.dy + currentAreaSize.height <
            pieceStates[index].position.dy + pieceSize.height) {
      if (pieceStates[index].position.dy + pieceSize.height / 2 <
          currentCenterPos.dy) {
        newY = center.dy + 1;
      } else {
        newY = currentCenterPos.dy +
            (currentAreaSize.height / 2) -
            pieceSize.height -
            1;
      }
    }

    return Offset(newX, newY);
  }

  // 枠外に移動
  Offset forceAdjustOutside(
      int index, Offset center, Size currentAreaSize, Size pieceSize) {
    Offset currentCenterPos =
        center + Offset(currentAreaSize.width / 2, currentAreaSize.height / 2);
    double newX = pieceStates[index].position.dx;
    double newY = pieceStates[index].position.dy;
    if (pieceStates[index].position.dx >= center.dx &&
        pieceStates[index].position.dx + pieceSize.width <=
            center.dx + currentAreaSize.width) {
      if (pieceStates[index].position.dx + pieceSize.width / 2 <
          currentCenterPos.dx) {
        newX = center.dx - pieceSize.width - 1;
      } else {
        newX = center.dx + currentAreaSize.width + 1;
      }
    }
    if (pieceStates[index].position.dy >= center.dy &&
        pieceStates[index].position.dy + pieceSize.height <=
            center.dy + currentAreaSize.height) {
      if (pieceStates[index].position.dy + pieceSize.height / 2 <
          currentCenterPos.dy) {
        newY = center.dy - pieceSize.height - 1;
      } else {
        newY = center.dy + currentAreaSize.height + 1;
      }
    }

    return Offset(newX, newY);
  }

  // 正解位置にあるピース
  bool isCorrect(int index) {
    if (_targetCount <= 0) {
      return false;
    }
    return _onpuStates[index].isCompleted;
  }

  void end() {
    _audioPlayer.setAsset('assets/sounds/next.mp3');
    _audioPlayer.play();
    _bgmAudioPlayer.stop();
    _isBGMPlaying = false;
    state = OnpuPuzzlePageState(
      isPreStarted: true,
      isStarted: state.isStarted,
      isCompleted: true,
      isAllCompleted: true,
      level: state.level,
    );
  }
}

final onpuPuzzlePageNotifierProvider =
    StateNotifierProvider<OnpuPuzzlePageStateNotifier, OnpuPuzzlePageState>(
  (ref) => OnpuPuzzlePageStateNotifier(),
);
