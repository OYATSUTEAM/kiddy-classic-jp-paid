import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../puzzle_quiz/page/puzzle_page.dart';
import '../puzzle_quiz/page/onpu_puzzle_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(const ProviderScope(child: MyApp()));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'どれみとあそぼ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const PuzzlePage(type: true),
        '/he': (context) => const PuzzlePage(type: false),
        '/2': (context) => const OnpuPuzzlePage(type: true),
        '/2_k': (context) => const OnpuPuzzlePage(type: false),
      },
    );
  }
}
