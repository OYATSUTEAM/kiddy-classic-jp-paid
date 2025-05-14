import 'package:kiddy_classic/all_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
import './doremi/setting.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Settings setting = selectEnv();
  AudioPlayer audioPlayer = AudioPlayer();
  // audioPlayer.setPlayerMode(PlayerMode.lowLatency);
  
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(ProviderScope(child: AllApp(audioPlayer: audioPlayer)));
  });
}