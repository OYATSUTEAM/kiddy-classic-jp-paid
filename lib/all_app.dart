import 'package:kiddy_classic/doremi/global.dart';
import 'page/menu_page.dart';
import 'package:kiddy_classic/doremi_app/doremi.dart';
import 'package:flutter/material.dart';
import 'package:kiddy_classic/onpu/page/onpu1_page.dart';
import 'package:kiddy_classic/onpu/page/onpu2_page.dart';
import 'package:kiddy_classic/onpu/page/line_space_a_page.dart';
import 'package:kiddy_classic/onpu/page/line_space_b_page.dart';
import 'package:kiddy_classic/puzzle_quiz/page/puzzle_page.dart';
import 'package:kiddy_classic/puzzle_quiz/page/quiz_page.dart';
import 'package:kiddy_classic/puzzle_quiz/page/onpu_puzzle_page.dart';
import 'package:kiddy_classic/puzzle_quiz/page/onpu_puzzle_he_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kiddy_classic/doremi/setting.dart';

class AllApp extends ConsumerWidget {
  const AllApp({super.key, required this.audioPlayer});
  final AudioPlayer? audioPlayer;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Settings setting = selectEnv();

    globalData.setS_Size(MediaQuery.of(context).size);
    return MaterialApp(
      title: 'どれみとあそぼ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const MenuPage(part: 1),
        '/doremi': (context) => Doremi(
              setting: setting,
              audioPlayer: audioPlayer,
            ),
        '/onpu1': (context) => const Onpu1Page(soundType: true),
        '/onpu1_he': (context) => const Onpu1Page(soundType: false),
        '/onpu2_ken': (context) => const Onpu2Page(keyType: 0, soundType: true),
        '/onpu2_ken_he': (context) =>
            const Onpu2Page(keyType: 0, soundType: false),
        '/onpu2': (context) => const Onpu2Page(keyType: 1, soundType: true),
        '/onpu2_he': (context) => const Onpu2Page(keyType: 1, soundType: false),
        '/onpuA': (context) => const LineSpaceAPage(type: true),
        '/onpuA_space': (context) => const LineSpaceAPage(type: false),
        '/onpuB': (context) => const LineSpaceBPage(type: true),
        '/onpuB_space': (context) => const LineSpaceBPage(type: false),
        '/onpuC': (context) => const Onpu2Page(keyType: 2, soundType: true),
        '/onpuC_he': (context) => const Onpu2Page(keyType: 2, soundType: false),
        '/onpuC_space': (context) =>
            const Onpu2Page(keyType: 3, soundType: true),
        '/onpuC_space_he': (context) =>
            const Onpu2Page(keyType: 3, soundType: false),
        '/puzzle': (context) => const PuzzlePage(type: true),
        '/puzzle_he': (context) => const PuzzlePage(type: false),
        '/puzzle_onpu': (context) => const OnpuPuzzlePage(type: true),
        '/puzzle_kyufu': (context) => const OnpuPuzzleHePage(type: false),
        '/quiz': (context) => const QuizPage(),
      },
    );
  }
}
