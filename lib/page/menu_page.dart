import 'dart:math';
import 'dart:ui';
import 'package:kiddy_classic/doremi/global.dart';
import 'package:flutter/material.dart';
import 'package:kiddy_classic/doremi/page_state/line_draw_page_state.dart';
import 'package:kiddy_classic/doremi/page_state/sticker_page_state.dart';
import 'package:kiddy_classic/onpu/page_state/line_space_a_page_state.dart';
import 'package:kiddy_classic/onpu/page_state/line_space_b_page_state.dart';
import 'package:kiddy_classic/onpu/page_state/onpu1_page_state.dart';
import 'package:kiddy_classic/onpu/page_state/onpu2_page_state.dart';
import 'package:kiddy_classic/puzzle_quiz/page_state/onpu_puzzle_he_page_state.dart';
import 'package:kiddy_classic/puzzle_quiz/page_state/onpu_puzzle_page_state.dart';
import 'package:kiddy_classic/puzzle_quiz/page_state/puzzle_page_state.dart';
import 'package:kiddy_classic/puzzle_quiz/page_state/quiz_page_state.dart';
import '/setting.dart';
import '/widget/background.dart';
import '/widget/menu_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuPage extends ConsumerStatefulWidget {
  const MenuPage({super.key, required this.part});
  final int part;
  @override
  ConsumerState<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends ConsumerState<MenuPage> {
  final ScrollController _scrollController = ScrollController();

  // Define global keys for each menu part
  final GlobalKey _menuPart1Key = GlobalKey();
  final GlobalKey _menuPart2Key = GlobalKey();
  final GlobalKey _menuPart3Key = GlobalKey();
  final GlobalKey _menuPart4Key = GlobalKey();
  final GlobalKey _menuPart5Key = GlobalKey();
  final GlobalKey _menuPart6Key = GlobalKey();
  final GlobalKey _menuPart7Key = GlobalKey();
  @override
  void initState() {
    _scrollToPart(widget.part);
    ref.read(stickerPageStateNotifierProvider.notifier).reset();
    ref.read(lineDrawPageStateNotifierProvider.notifier).reset();
    ref.read(onpuPuzzleHePageNotifierProvider.notifier).reset();
    ref.read(onpuPuzzlePageNotifierProvider.notifier).reset();
    ref.read(puzzlePageNotifierProvider.notifier).reset();
    ref.read(onpu1PageNotifierProvider.notifier).reset();
    ref.read(onpu2PageNotifierProvider.notifier).reset();
    ref.read(quizPageNotifierProvider.notifier).reset();
  }

  void _scrollToPart(int part) {
    GlobalKey targetKey;

    switch (part) {
      case 1:
        targetKey = _menuPart1Key;
        break;
      case 2:
        targetKey = _menuPart2Key;
        break;
      case 3:
        targetKey = _menuPart3Key;
        break;
      case 4:
        targetKey = _menuPart4Key;
        break;
      case 5:
        targetKey = _menuPart5Key;
        break;
      default:
        return; // Do nothing if part is invalid
    }

    final context = targetKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = getScreenSize(context);
    return
        // Padding(
        //     padding: EdgeInsets.all(35),
        //     child:
        Container(
      // padding: EdgeInsets.all(35),
      color: Colors.white,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                _MenuParts1(widgetKey: _menuPart1Key),
                _MenuParts2(widgetKey: _menuPart2Key),
                _MenuParts3(widgetKey: _menuPart3Key),
                _MenuParts4(widgetKey: _menuPart4Key),
                _MenuParts5(widgetKey: _menuPart5Key),
                // _MenuParts6(widgetKey: _menuPart6Key),
                // _MenuParts7(widgetKey: _menuPart7Key),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class _MenuParts1 extends ConsumerWidget {
  final GlobalKey widgetKey;
  const _MenuParts1({
    Key? key,
    required this.widgetKey,
  }) : super(key: widgetKey);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = getScreenSize(context);
    String folder = getSizeFolderNameFromSize(size);
    String imageName = getBackGroundImageName(folder, 1);
    ViewSetting doremiToButton1Setting =
        getDoremiToButtonViewSetting(context, 0);
    ViewSetting doremiToButton2Setting =
        getDoremiToButtonViewSetting(context, 1);
    ViewSetting doremiToButton3Setting =
        getDoremiToButtonViewSetting(context, 2);
    ViewSetting doremiToButton4Setting =
        getDoremiToButtonViewSetting(context, 3);
    ViewSetting doremiToButton5Setting =
        getDoremiToButtonViewSetting(context, 4);
    ViewSetting doremiToButton6Setting =
        getDoremiToButtonViewSetting(context, 5);
    ViewSetting doremiToButton7Setting =
        getDoremiToButtonViewSetting(context, 6);
    ViewSetting doremiToButton8Setting =
        getDoremiToButtonViewSetting(context, 7);
// doremi he
    ViewSetting doremiHeButton1Setting =
        getDoremiHeButtonViewSetting(context, 0);
    ViewSetting doremiHeButton2Setting =
        getDoremiHeButtonViewSetting(context, 1);
    ViewSetting doremiHeButton3Setting =
        getDoremiHeButtonViewSetting(context, 2);
    ViewSetting doremiHeButton4Setting =
        getDoremiHeButtonViewSetting(context, 3);
    ViewSetting doremiHeButton5Setting =
        getDoremiHeButtonViewSetting(context, 4);
    ViewSetting doremiHeButton6Setting =
        getDoremiHeButtonViewSetting(context, 5);
    ViewSetting doremiHeButton7Setting =
        getDoremiHeButtonViewSetting(context, 6);
    ViewSetting doremiHeButton8Setting =
        getDoremiHeButtonViewSetting(context, 7);
    return SizedBox(
      width: size.width,
      height: size.height * 1,
      child: Stack(
        children: [
          Background(
            name: imageName,
            width: size.width,
            height: size.height * 1,
          ),
          MenuButton(
            onTap: () async {
              await globalData.setEnv('Do');
              await globalData.setToHe('jaToon');
              Navigator.of(context).pushNamed('/doremi');
              ref.read(stickerPageStateNotifierProvider.notifier).reset();
              ref.read(lineDrawPageStateNotifierProvider.notifier).reset();
            },
            position: doremiToButton1Setting.position,
            buttonSize: doremiToButton1Setting.size,
          ),
          MenuButton(
            onTap: () async {
              await globalData.setEnv('Re');
              await globalData.setToHe('jaToon');
              Navigator.of(context).pushNamed('/doremi');
              ref.read(stickerPageStateNotifierProvider.notifier).reset();
              ref.read(lineDrawPageStateNotifierProvider.notifier).reset();
            },
            position: doremiToButton2Setting.position,
            buttonSize: doremiToButton2Setting.size,
          ),
          MenuButton(
            onTap: () async {
              await globalData.setEnv('Mi');
              await globalData.setToHe('jaToon');

              Navigator.of(context).pushNamed('/doremi');
              ref.read(stickerPageStateNotifierProvider.notifier).reset();
              ref.read(lineDrawPageStateNotifierProvider.notifier).reset();
            },
            position: doremiToButton3Setting.position,
            buttonSize: doremiToButton3Setting.size,
          ),
          MenuButton(
            onTap: () async {
              await globalData.setEnv('Fa');
              await globalData.setToHe('jaToon');
              Navigator.of(context).pushNamed('/doremi');
              ref.read(stickerPageStateNotifierProvider.notifier).reset();
              ref.read(lineDrawPageStateNotifierProvider.notifier).reset();
            },
            position: doremiToButton4Setting.position,
            buttonSize: doremiToButton4Setting.size,
          ),
          MenuButton(
            onTap: () async {
              await globalData.setEnv('So');
              await globalData.setToHe('jaToon');
              Navigator.of(context).pushNamed('/doremi');
              ref.read(stickerPageStateNotifierProvider.notifier).reset();
              ref.read(lineDrawPageStateNotifierProvider.notifier).reset();
            },
            position: doremiToButton5Setting.position,
            buttonSize: doremiToButton5Setting.size,
          ),
          MenuButton(
            onTap: () async {
              await globalData.setEnv('Ra');
              await globalData.setToHe('jaToon');
              Navigator.of(context).pushNamed('/doremi');
              ref.read(stickerPageStateNotifierProvider.notifier).reset();
              ref.read(lineDrawPageStateNotifierProvider.notifier).reset();
            },
            position: doremiToButton6Setting.position,
            buttonSize: doremiToButton6Setting.size,
          ),
          MenuButton(
            onTap: () async {
              await globalData.setEnv('Si');
              await globalData.setToHe('jaToon');

              Navigator.of(context).pushNamed('/doremi');
              ref.read(stickerPageStateNotifierProvider.notifier).reset();
              ref.read(lineDrawPageStateNotifierProvider.notifier).reset();
            },
            position: doremiToButton7Setting.position,
            buttonSize: doremiToButton7Setting.size,
          ),
          MenuButton(
            onTap: () async {
              await globalData.setEnv('Do2');
              await globalData.setToHe('jaToon');
              Navigator.of(context).pushNamed('/doremi');
              ref.read(stickerPageStateNotifierProvider.notifier).reset();
              ref.read(lineDrawPageStateNotifierProvider.notifier).reset();
            },
            position: doremiToButton8Setting.position,
            buttonSize: doremiToButton8Setting.size,
          ),
// ==================================================================            doremi to
// ==================================================================            doremi to
// ==================================================================            doremi to
// ==================================================================            doremi to
          MenuButton(
            onTap: () async {
              await globalData.setEnv('Do');
              await globalData.setToHe('jaHeon');
              Navigator.of(context).pushNamed('/doremi');
              ref.read(stickerPageStateNotifierProvider.notifier).reset();
              ref.read(lineDrawPageStateNotifierProvider.notifier).reset();
            },
            position: doremiHeButton1Setting.position,
            buttonSize: doremiHeButton1Setting.size,
          ),
          MenuButton(
            onTap: () async {
              await globalData.setEnv('Re');
              await globalData.setToHe('jaHeon');
              Navigator.of(context).pushNamed('/doremi');
              ref.read(stickerPageStateNotifierProvider.notifier).reset();
              ref.read(lineDrawPageStateNotifierProvider.notifier).reset();
            },
            position: doremiHeButton2Setting.position,
            buttonSize: doremiHeButton2Setting.size,
          ),
          MenuButton(
            onTap: () async {
              await globalData.setEnv('Mi');
              await globalData.setToHe('jaHeon');

              Navigator.of(context).pushNamed('/doremi');
              ref.read(stickerPageStateNotifierProvider.notifier).reset();
              ref.read(lineDrawPageStateNotifierProvider.notifier).reset();
            },
            position: doremiHeButton3Setting.position,
            buttonSize: doremiHeButton3Setting.size,
          ),
          MenuButton(
            onTap: () async {
              await globalData.setEnv('Fa');
              await globalData.setToHe('jaHeon');
              Navigator.of(context).pushNamed('/doremi');
              ref.read(stickerPageStateNotifierProvider.notifier).reset();
              ref.read(lineDrawPageStateNotifierProvider.notifier).reset();
            },
            position: doremiHeButton4Setting.position,
            buttonSize: doremiHeButton4Setting.size,
          ),
          MenuButton(
            onTap: () async {
              await globalData.setEnv('So');
              await globalData.setToHe('jaHeon');
              Navigator.of(context).pushNamed('/doremi');
              ref.read(stickerPageStateNotifierProvider.notifier).reset();
              ref.read(lineDrawPageStateNotifierProvider.notifier).reset();
            },
            position: doremiHeButton5Setting.position,
            buttonSize: doremiHeButton5Setting.size,
          ),
          MenuButton(
            onTap: () async {
              await globalData.setEnv('Ra');
              await globalData.setToHe('jaHeon');
              Navigator.of(context).pushNamed('/doremi');
              ref.read(stickerPageStateNotifierProvider.notifier).reset();
              ref.read(lineDrawPageStateNotifierProvider.notifier).reset();
            },
            position: doremiHeButton6Setting.position,
            buttonSize: doremiHeButton6Setting.size,
          ),
          MenuButton(
            onTap: () async {
              await globalData.setEnv('Si');
              await globalData.setToHe('jaHeon');

              Navigator.of(context).pushNamed('/doremi');
              ref.read(stickerPageStateNotifierProvider.notifier).reset();
              ref.read(lineDrawPageStateNotifierProvider.notifier).reset();
            },
            position: doremiHeButton7Setting.position,
            buttonSize: doremiHeButton7Setting.size,
          ),
          MenuButton(
            onTap: () async {
              await globalData.setEnv('Do2');
              await globalData.setToHe('jaHeon');
              Navigator.of(context).pushNamed('/doremi');
              ref.read(stickerPageStateNotifierProvider.notifier).reset();
              ref.read(lineDrawPageStateNotifierProvider.notifier).reset();
            },
            position: doremiHeButton8Setting.position,
            buttonSize: doremiHeButton8Setting.size,
          ),
        ],
      ),
    );
  }
}

class _MenuParts2 extends ConsumerWidget {
  final GlobalKey widgetKey;
  const _MenuParts2({
    Key? key,
    required this.widgetKey,
  }) : super(key: widgetKey);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = getScreenSize(context);
    String folder = getSizeFolderNameFromSize(size);
    String imageName = getBackGroundImageName(folder, 2);
    ViewSetting menu2Button1Setting = getMenu2ButtonViewSetting(context, 0);
    ViewSetting menu2Button2Setting = getMenu2ButtonViewSetting(context, 1);
    ViewSetting menu2Button3Setting = getMenu2ButtonViewSetting(context, 2);
    ViewSetting menu2Button4Setting = getMenu2ButtonViewSetting(context, 3);
    ViewSetting menu2Button5Setting = getMenu2ButtonViewSetting(context, 4);
    ViewSetting menu2Button6Setting = getMenu2ButtonViewSetting(context, 5);
    ViewSetting menu2Button7Setting = getMenu2ButtonViewSetting(context, 6);
    ViewSetting menu2Button8Setting = getMenu2ButtonViewSetting(context, 7);

    return SizedBox(
      width: size.width,
      height: size.height * 1.1,
      child: Stack(
        children: [
          Background(
            name: imageName,
            width: size.width,
            height: size.height * 1.1,
          ),
          MenuButton(
            onTap: () {
              Navigator.of(context).pushNamed('/puzzle');
              ref.read(onpuPuzzleHePageNotifierProvider.notifier).reset();
              ref.read(onpuPuzzlePageNotifierProvider.notifier).reset();
              ref.read(puzzlePageNotifierProvider.notifier).reset();
            },
            position: menu2Button1Setting.position,
            buttonSize: menu2Button1Setting.size,
          ),
          MenuButton(
            onTap: () {
              ref.read(onpuPuzzleHePageNotifierProvider.notifier).reset();
              ref.read(onpuPuzzlePageNotifierProvider.notifier).reset();
              ref.read(puzzlePageNotifierProvider.notifier).reset();
              Navigator.of(context).pushNamed('/puzzle_he');
            },
            position: menu2Button2Setting.position,
            buttonSize: menu2Button2Setting.size,
          ),
          MenuButton(
            onTap: () {
              ref.read(onpuPuzzleHePageNotifierProvider.notifier).reset();
              ref.read(onpuPuzzlePageNotifierProvider.notifier).reset();
              ref.read(puzzlePageNotifierProvider.notifier).reset();
              Navigator.of(context).pushNamed('/puzzle_onpu');
            },
            position: menu2Button3Setting.position,
            buttonSize: menu2Button3Setting.size,
          ),
          MenuButton(
            onTap: () {
              ref.read(onpuPuzzleHePageNotifierProvider.notifier).reset();
              ref.read(onpuPuzzlePageNotifierProvider.notifier).reset();
              ref.read(puzzlePageNotifierProvider.notifier).reset();
              Navigator.of(context).pushNamed('/puzzle_kyufu');
            },
            position: menu2Button4Setting.position,
            buttonSize: menu2Button4Setting.size,
          ),
          MenuButton(
            onTap: () {
              String nextPageRoute = '/onpuA';
              ref.read(lineSpaceAPageNotifierProvider.notifier).reset();
              Navigator.of(context).pushNamed(nextPageRoute);
            },
            position: menu2Button5Setting.position,
            buttonSize: menu2Button5Setting.size,
          ),
          MenuButton(
            onTap: () {
              String nextPageRoute = '/onpuA_space';
              ref.read(lineSpaceAPageNotifierProvider.notifier).reset();
              Navigator.of(context).pushNamed(nextPageRoute);
            },
            position: menu2Button6Setting.position,
            buttonSize: menu2Button6Setting.size,
          ),
          MenuButton(
            onTap: () {
              String nextPageRoute = '/onpuB';
              ref.read(lineSpaceBPageNotifierProvider.notifier).reset();
              int rand = Random().nextInt(2);
              Navigator.of(context).pushNamed(nextPageRoute);
            },
            position: menu2Button7Setting.position,
            buttonSize: menu2Button7Setting.size,
          ),
          MenuButton(
            onTap: () {
              String nextPageRoute = '/onpuB_space';
              ref.read(lineSpaceBPageNotifierProvider.notifier).reset();
              Navigator.of(context).pushNamed(nextPageRoute);
            },
            position: menu2Button8Setting.position,
            buttonSize: menu2Button8Setting.size,
          ),
        ],
      ),
    );
  }
}

class _MenuParts3 extends ConsumerWidget {
  final GlobalKey widgetKey;
  const _MenuParts3({Key? key, required this.widgetKey})
      : super(key: widgetKey);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = getScreenSize(context);
    String folder = getSizeFolderNameFromSize(size);
    String imageName = getBackGroundImageName(folder, 3);
    ViewSetting menu3Button1Setting = getMenu3ButtonViewSetting(context, 0);
    ViewSetting menu3Button2Setting = getMenu3ButtonViewSetting(context, 1);
    ViewSetting menu3Button3Setting = getMenu3ButtonViewSetting(context, 2);
    ViewSetting menu3Button4Setting = getMenu3ButtonViewSetting(context, 3);
    return SizedBox(
      width: size.width,
      height: size.height * 0.89,
      child: Stack(
        children: [
          Background(
            name: imageName,
            width: size.width,
            height: size.height * 0.89,
          ),
          MenuButton(
            onTap: () {
              String nextPageRoute = '/onpuC_space';
              ref.read(onpu2PageNotifierProvider.notifier).reset();
              Navigator.of(context).pushNamed(nextPageRoute);
            },
            position: menu3Button1Setting.position,
            buttonSize: menu3Button1Setting.size,
          ),
          MenuButton(
            onTap: () {
              String nextPageRoute = '/onpuC';
              ref.read(onpu2PageNotifierProvider.notifier).reset();
              Navigator.of(context).pushNamed(nextPageRoute);
            },
            position: menu3Button2Setting.position,
            buttonSize: menu3Button2Setting.size,
          ),
          MenuButton(
            onTap: () {
              String nextPageRoute = '/onpuC_space_he';
              ref.read(onpu2PageNotifierProvider.notifier).reset();
              Navigator.of(context).pushNamed(nextPageRoute);
            },
            position: menu3Button3Setting.position,
            buttonSize: menu3Button3Setting.size,
          ),
          MenuButton(
            onTap: () {
              String nextPageRoute = '/onpuC_he';
              ref.read(onpu1PageNotifierProvider.notifier).reset();
              Navigator.of(context).pushNamed(nextPageRoute);
            },
            position: menu3Button4Setting.position,
            buttonSize: menu3Button4Setting.size,
          ),
        ],
      ),
    );
  }
}

class _MenuParts4 extends ConsumerWidget {
  final GlobalKey widgetKey;
  const _MenuParts4({
    Key? key,
    required this.widgetKey,
  }) : super(key: widgetKey);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = getScreenSize(context);
    String folder = getSizeFolderNameFromSize(size);
    String imageName = getBackGroundImageName(folder, 4);
    ViewSetting menu4Button1Setting = getMenu4ButtonViewSetting(context, 0);
    ViewSetting menu4Button2Setting = getMenu4ButtonViewSetting(context, 1);
    ViewSetting menu4Button3Setting = getMenu4ButtonViewSetting(context, 2);
    ViewSetting menu4Button4Setting = getMenu4ButtonViewSetting(context, 3);
    ViewSetting menu4Button5Setting = getMenu4ButtonViewSetting(context, 4);
    ViewSetting menu4Button6Setting = getMenu4ButtonViewSetting(context, 5);
    return SizedBox(
      width: size.width,
      height: size.height * 1.21,
      child: Stack(
        children: [
          Background(
            name: imageName,
            width: size.width,
            height: size.height * 1.21,
          ),
          MenuButton(
            onTap: () {
              String nextPageRoute = '/onpu2_ken';
              ref.read(onpu2PageNotifierProvider.notifier).reset();
              Navigator.of(context).pushNamed(nextPageRoute);
            },
            position: menu4Button1Setting.position,
            buttonSize: menu4Button1Setting.size,
          ),
          MenuButton(
            onTap: () {
              String nextPageRoute = '/onpu2_ken_he';
              ref.read(onpu2PageNotifierProvider.notifier).reset();
              Navigator.of(context).pushNamed(nextPageRoute);
            },
            position: menu4Button2Setting.position,
            buttonSize: menu4Button2Setting.size,
          ),
          MenuButton(
            onTap: () {
              String nextPageRoute = '/onpu1';
              ref.read(onpu1PageNotifierProvider.notifier).reset();
              Navigator.of(context).pushNamed(nextPageRoute);
            },
            position: menu4Button3Setting.position,
            buttonSize: menu4Button3Setting.size,
          ),
          MenuButton(
            onTap: () {
              String nextPageRoute = '/onpu1_he';
              ref.read(onpu1PageNotifierProvider.notifier).reset();
              Navigator.of(context).pushNamed(nextPageRoute);
            },
            position: menu4Button4Setting.position,
            buttonSize: menu4Button4Setting.size,
          ),
          MenuButton(
            onTap: () {
              String nextPageRoute = '/onpu2';
              ref.read(onpu2PageNotifierProvider.notifier).reset();
              Navigator.of(context).pushNamed(nextPageRoute);
            },
            position: menu4Button5Setting.position,
            buttonSize: menu4Button5Setting.size,
          ),
          MenuButton(
            onTap: () {
              String nextPageRoute = '/onpu2_he';
              ref.read(onpu2PageNotifierProvider.notifier).reset();
              Navigator.of(context).pushNamed(nextPageRoute);
            },
            position: menu4Button6Setting.position,
            buttonSize: menu4Button6Setting.size,
          ),
        ],
      ),
    );
  }
}

class _MenuParts5 extends ConsumerWidget {
  final GlobalKey widgetKey;
  const _MenuParts5({
    Key? key,
    required this.widgetKey,
  }) : super(key: widgetKey);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = getScreenSize(context);
    String folder = getSizeFolderNameFromSize(size);
    String imageName = getBackGroundImageName(folder, 5);
    ViewSetting menu5Button1Setting = getMenu5ButtonViewSetting(context, 0);
    ViewSetting menu5Button2Setting = getMenu5ButtonViewSetting(context, 1);
    return SizedBox(
      width: size.width,
      height: size.height * 0.54,
      child: Stack(
        children: [
          Background(
            name: imageName,
            width: size.width,
            height: size.height * 0.54,
          ),
          MenuButton(
            onTap: () {
              String nextPageRoute = '/quiz';
              // ref.read(onpu2PageNotifierProvider.notifier).reset();
              ref.read(quizPageNotifierProvider.notifier).reset();
              // ref.read(onpu1PageNotifierProvider.notifier).reset();
              Navigator.of(context).pushNamed(nextPageRoute);
            },
            position: menu5Button1Setting.position,
            buttonSize: menu5Button1Setting.size,
          ),
          MenuButton(
            onTap: () {},
            position: menu5Button2Setting.position,
            buttonSize: menu5Button2Setting.size,
          ),
        ],
      ),
    );
  }
}
