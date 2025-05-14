import 'package:flutter/services.dart';
import 'package:kiddy_classic/onpu/page/line_space_a_page.dart';
import 'package:kiddy_classic/onpu/page/line_space_b_page.dart';
//import 'package:onpu/page/line_space_c_page.dart';
import 'package:kiddy_classic/onpu/page/onpu1_page.dart';
import 'package:kiddy_classic/onpu/page/onpu2_page.dart';
import 'package:flutter/material.dart';
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
        '/': (context) => const Onpu1Page(soundType: true),
        '/he': (context) => const Onpu1Page(soundType: false),
        '/2_k': (context) => const Onpu2Page(keyType: 0, soundType: true),
        '/2_k_he': (context) => const Onpu2Page(keyType: 0, soundType: false),
        '/2': (context) => const Onpu2Page(keyType: 1, soundType: true),
        '/2_he': (context) => const Onpu2Page(keyType: 1, soundType: false),
        '/A': (context) => const LineSpaceAPage(type: true),
        '/A_s': (context) => const LineSpaceAPage(type: false),
        '/B': (context) => const LineSpaceBPage(type: true),
        '/B_s': (context) => const LineSpaceBPage(type: false),
        '/C': (context) => const Onpu2Page(keyType: 2, soundType: true),
        '/C_he': (context) => const Onpu2Page(keyType: 2, soundType: false),
        '/C_s': (context) => const Onpu2Page(keyType: 3, soundType: true),
        '/C_s_he': (context) => const Onpu2Page(keyType: 3, soundType: false),
      },
    );
  }
}
