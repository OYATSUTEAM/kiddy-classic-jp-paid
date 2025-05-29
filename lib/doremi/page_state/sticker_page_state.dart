//import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/flavor_config.dart';

/// シールをはりましょう 画面の状態
///
/// 一旦、シールをすべて貼り終わったかどうかのみを管理する
class StickerPageState {
  /// シールがすべて貼り終わったかどうか
  final bool isCompleted;

  StickerPageState({
    required this.isCompleted,
  });
}

class StickerPageSetting {
  final String nextPageRoute;
  late final String stickerImageName;
  late final String backgroundImageName;
  late final String completedImageName;
  late final String nextButtonImageName;
  final String correctSoundName;
  final String incorrectSoundName;
  final String completedSoundName;
  final int targetNum;
  // final AudioPlayer? audioPlayer;

  StickerPageSetting({
    required this.nextPageRoute,
    required this.targetNum,
    String? stickerImageName,
    String? backgroundImageName,
    String? completedImageName,
    String? nextButtonImageName,
    this.correctSoundName = 'assets/sounds/002.mp3',
    this.incorrectSoundName = 'assets/sounds/005_e.mp3',
    this.completedSoundName = 'assets/sounds/003_g.mp3',
    // this.audioPlayer,
  }) {
    this.stickerImageName =
        stickerImageName ?? '${FlavorConfig.assetPath}/images/Do/Seal.png';
    this.backgroundImageName = backgroundImageName ??
        '${FlavorConfig.assetPath}/images/Do/Tablet02_2266x1488.png';
    this.completedImageName = completedImageName ??
        '${FlavorConfig.assetPath}/images/Tablet_Completed.png';
    this.nextButtonImageName =
        nextButtonImageName ?? '${FlavorConfig.assetPath}/images/Next.png';
  }

  static StickerPageSetting defaultSetting() => StickerPageSetting(
        nextPageRoute: '/sticker2',
        targetNum: 5,
      );
}

class StickerPageStateNotifier extends StateNotifier<StickerPageState> {
  int _completedCount = 0;
  AudioPlayer drawAudioPlayer = AudioPlayer();
  final _audioPlayer = AudioPlayer();
  StickerPageSetting setting = StickerPageSetting.defaultSetting();

  StickerPageStateNotifier()
      : super(
          StickerPageState(isCompleted: false),
        );

  void increment() {
    _completedCount++;
    if (_completedCount >= setting.targetNum) {
      Future.delayed(
        const Duration(milliseconds: 500),
        () async {
          state = StickerPageState(isCompleted: true);

          _audioPlayer.setAsset(setting.completedSoundName);
          _audioPlayer.play();
        },
      );
    }
  }

  void bgmPlay() {
    drawAudioPlayer.stop(); // Stop any existing playback
    drawAudioPlayer.setAsset('assets/sounds/bgm4.mp3');
    drawAudioPlayer.setVolume(1.0); // Reset volume to full
    drawAudioPlayer.play();
  }

  void bgmStop() {
    const fadeDuration = Duration(seconds: 3);
    final int steps = 50; // number of volume steps
    final double initialVolume = 1.0; // assuming starting volume is max
    final double stepDurationSeconds = fadeDuration.inSeconds / steps;

    for (int i = 0; i <= steps; i++) {
      final double volume = initialVolume * (1 - i / steps);
      Future.delayed(
          Duration(milliseconds: (stepDurationSeconds * 1000).toInt()));
      drawAudioPlayer.setVolume(volume);
    }

    // Stop the player after fade out
    drawAudioPlayer.stop();
  }

  void reset() {
    _completedCount = 0;
    state = StickerPageState(isCompleted: false);
    drawAudioPlayer.stop(); // Stop any playing audio
    drawAudioPlayer.setVolume(1.0); // Reset volume
  }
}

final stickerPageStateNotifierProvider =
    StateNotifierProvider<StickerPageStateNotifier, StickerPageState>(
  (ref) => StickerPageStateNotifier(),
);
