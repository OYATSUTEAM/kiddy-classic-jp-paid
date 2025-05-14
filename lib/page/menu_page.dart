import 'dart:math';
import 'dart:ui';
import 'package:kiddy_classic/doremi/global.dart';
import 'package:flutter/material.dart';
import '/setting.dart';
import '/widget/background.dart';
import '/widget/menu_button.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key, required this.part});
  final int part;
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
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
  Widget build(
    BuildContext context,
  ) {
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
                _MenuParts6(widgetKey: _menuPart6Key),
                _MenuParts7(widgetKey: _menuPart7Key),
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

class _MenuParts1 extends StatelessWidget {
  final GlobalKey widgetKey;
  const _MenuParts1({
    Key? key,
    required this.widgetKey,
  }) : super(key: widgetKey);

  @override
  Widget build(BuildContext context) {
    Size size = getScreenSize(context);
    String folder = getSizeFolderNameFromSize(size);
    String imageName = getBackGroundImageName(folder, 1);
    ViewSetting doremiButton1Setting = getDoremiButtonViewSetting(context, 0);
    ViewSetting doremiButton2Setting = getDoremiButtonViewSetting(context, 1);
    ViewSetting doremiButton3Setting = getDoremiButtonViewSetting(context, 2);
    ViewSetting doremiButton4Setting = getDoremiButtonViewSetting(context, 3);
    ViewSetting doremiButton5Setting = getDoremiButtonViewSetting(context, 4);
    ViewSetting doremiButton6Setting = getDoremiButtonViewSetting(context, 5);
    ViewSetting doremiButton7Setting = getDoremiButtonViewSetting(context, 6);
    ViewSetting doremiButton8Setting = getDoremiButtonViewSetting(context, 7);
    // ViewSetting puzzleButton1Setting = getPuzzleButtonViewSetting(context, 0);
    // ViewSetting puzzleButton2Setting = getPuzzleButtonViewSetting(context, 1);
    // ViewSetting puzzleButton3Setting = getPuzzleButtonViewSetting(context, 2);
    // ViewSetting puzzleButton4Setting = getPuzzleButtonViewSetting(context, 3);
    return SizedBox(
      width: size.width,
      height: size.height * 0.7,
      child: Stack(
        children: [
          Background(
            name: imageName,
            width: size.width,
            height: size.height * 0.7,
          ),
          MenuButton(
            onTap: () async {
              await globalData.setEnv('Do');
              await globalData.setToHe('jaToon');
              Navigator.of(context).pushNamed('/doremi');
            },
            position: doremiButton1Setting.position,
            buttonSize: doremiButton1Setting.size,
          ),
          MenuButton(
            onTap: () async {
              await globalData.setEnv('Re');
              await globalData.setToHe('jaToon');
              Navigator.of(context).pushNamed('/doremi');
            },
            position: doremiButton2Setting.position,
            buttonSize: doremiButton2Setting.size,
          ),
          MenuButton(
            onTap: () async {
              await globalData.setEnv('Mi');
              await globalData.setToHe('jaToon');

              Navigator.of(context).pushNamed('/doremi');
            },
            position: doremiButton3Setting.position,
            buttonSize: doremiButton3Setting.size,
          ),
          MenuButton(
            onTap: () async {
              await globalData.setEnv('Fa');
              await globalData.setToHe('jaToon');
              Navigator.of(context).pushNamed('/doremi');
            },
            position: doremiButton4Setting.position,
            buttonSize: doremiButton4Setting.size,
          ),
          MenuButton(
            onTap: () async {
              await globalData.setEnv('So');
              await globalData.setToHe('jaToon');
              Navigator.of(context).pushNamed('/doremi');
            },
            position: doremiButton5Setting.position,
            buttonSize: doremiButton5Setting.size,
          ),
          MenuButton(
            onTap: () async {
              await globalData.setEnv('Ra');
              await globalData.setToHe('jaToon');
              Navigator.of(context).pushNamed('/doremi');
            },
            position: doremiButton6Setting.position,
            buttonSize: doremiButton6Setting.size,
          ),
          MenuButton(
            onTap: () async {
              await globalData.setEnv('Si');
              await globalData.setToHe('jaToon');

              Navigator.of(context).pushNamed('/doremi');
            },
            position: doremiButton7Setting.position,
            buttonSize: doremiButton7Setting.size,
          ),
          MenuButton(
            onTap: () async {
              await globalData.setEnv('Do2');
              await globalData.setToHe('jaToon');
              Navigator.of(context).pushNamed('/doremi');
            },
            position: doremiButton8Setting.position,
            buttonSize: doremiButton8Setting.size,
          ),
        ],
      ),
    );
  }
}

class _MenuParts2 extends StatelessWidget {
  final GlobalKey widgetKey;
  const _MenuParts2({
    Key? key,
    required this.widgetKey,
  }) : super(key: widgetKey);
  @override
  Widget build(BuildContext context) {
    Size size = getScreenSize(context);
    String folder = getSizeFolderNameFromSize(size);
    String imageName = getBackGroundImageName(folder, 2);
    ViewSetting menu2Button1Setting = getMenu2ButtonViewSetting(context, 0);
    ViewSetting menu2Button2Setting = getMenu2ButtonViewSetting(context, 1);
    ViewSetting menu2Button3Setting = getMenu2ButtonViewSetting(context, 2);
    ViewSetting menu2Button4Setting = getMenu2ButtonViewSetting(context, 3);

    return SizedBox(
      width: size.width,
      height: size.height * 0.7,
      child: Stack(
        children: [
          Background(
            name: imageName,
            width: size.width,
            height: size.height * 0.7,
          ),
          MenuButton(
            onTap: () {
              Navigator.of(context).pushNamed('/puzzle');
            },
            position: menu2Button1Setting.position,
            buttonSize: menu2Button1Setting.size,
          ),
          MenuButton(
            onTap: () {
              Navigator.of(context).pushNamed('/puzzle_he');
            },
            position: menu2Button2Setting.position,
            buttonSize: menu2Button2Setting.size,
          ),
          MenuButton(
            onTap: () {
              Navigator.of(context).pushNamed('/puzzle_onpu');
            },
            position: menu2Button3Setting.position,
            buttonSize: menu2Button3Setting.size,
          ),
          MenuButton(
            onTap: () {
              Navigator.of(context).pushNamed('/puzzle_kyufu');
            },
            position: menu2Button4Setting.position,
            buttonSize: menu2Button4Setting.size,
          ),
        ],
      ),
    );
  }
}

class _MenuParts3 extends StatelessWidget {
  final GlobalKey widgetKey;
  const _MenuParts3({Key? key, required this.widgetKey})
      : super(key: widgetKey);
  @override
  Widget build(BuildContext context) {
    Size size = getScreenSize(context);
    String folder = getSizeFolderNameFromSize(size);
    String imageName = getBackGroundImageName(folder, 3);
    ViewSetting menu3Button1Setting = getMenu3ButtonViewSetting(context, 0);
    ViewSetting menu3Button2Setting = getMenu3ButtonViewSetting(context, 1);
    ViewSetting menu3Button3Setting = getMenu3ButtonViewSetting(context, 2);
    ViewSetting menu3Button4Setting = getMenu3ButtonViewSetting(context, 3);
    return SizedBox(
      width: size.width,
      height: size.height * 0.7,
      child: Stack(
        children: [
          Background(
            name: imageName,
            width: size.width,
            height: size.height * 0.7,
          ),
          MenuButton(
            onTap: () {
              String nextPageRoute = '/onpuA';
              // int rand = Random().nextInt(2);
              // if (rand == 1) {
              //   nextPageRoute = '/onpu2_ken_he';
              // }
              Navigator.of(context).pushNamed(nextPageRoute);
            },
            position: menu3Button1Setting.position,
            buttonSize: menu3Button1Setting.size,
          ),
          MenuButton(
            onTap: () {
              String nextPageRoute = '/onpuA_space';
              // int rand = Random().nextInt(2);
              // if (rand == 1) {
              //   nextPageRoute = '/onpu1_he';
              // }
              Navigator.of(context).pushNamed(nextPageRoute);
            },
            position: menu3Button2Setting.position,
            buttonSize: menu3Button2Setting.size,
          ),
          MenuButton(
            onTap: () {
              String nextPageRoute = '/onpuB';
              int rand = Random().nextInt(2);
              // if (rand == 1) {
              //   nextPageRoute = '/onpu2_he';
              // }
              Navigator.of(context).pushNamed(nextPageRoute);
            },
            position: menu3Button3Setting.position,
            buttonSize: menu3Button3Setting.size,
          ),
          MenuButton(
            onTap: () {
              Navigator.of(context).pushNamed('/onpuB_space');
            },
            position: menu3Button4Setting.position,
            buttonSize: menu3Button4Setting.size,
          ),
        ],
      ),
    );
  }
}

class _MenuParts4 extends StatelessWidget {
  final GlobalKey widgetKey;
  const _MenuParts4({
    Key? key,
    required this.widgetKey,
  }) : super(key: widgetKey);
  @override
  Widget build(BuildContext context) {
    Size size = getScreenSize(context);
    String folder = getSizeFolderNameFromSize(size);
    String imageName = getBackGroundImageName(folder, 4);
    ViewSetting menu4Button1Setting = getMenu4ButtonViewSetting(context, 0);
    ViewSetting menu4Button2Setting = getMenu4ButtonViewSetting(context, 1);
    return SizedBox(
      width: size.width,
      height: size.height * 0.6,
      child: Stack(
        children: [
          Background(
            name: imageName,
            width: size.width,
            height: size.height * 0.6,
          ),
          MenuButton(
            onTap: () {
              String nextPageRoute = '/onpuC_space';
              // int rand = Random().nextInt(2);
              // if (rand == 1) {
              //   nextPageRoute = '/onpu2_ken_he';
              // }
              Navigator.of(context).pushNamed(nextPageRoute);
            },
            position: menu4Button1Setting.position,
            buttonSize: menu4Button1Setting.size,
          ),
          MenuButton(
            onTap: () {
              String nextPageRoute = '/onpuC';
              // int rand = Random().nextInt(2);
              // if (rand == 1) {
              //   nextPageRoute = '/onpu1_he';
              // }
              Navigator.of(context).pushNamed(nextPageRoute);
            },
            position: menu4Button2Setting.position,
            buttonSize: menu4Button2Setting.size,
          ),
        ],
      ),
    );
  }
}

class _MenuParts5 extends StatelessWidget {
  final GlobalKey widgetKey;
  const _MenuParts5({
    Key? key,
    required this.widgetKey,
  }) : super(key: widgetKey);
  @override
  Widget build(BuildContext context) {
    Size size = getScreenSize(context);
    String folder = getSizeFolderNameFromSize(size);
    String imageName = getBackGroundImageName(folder, 5);
    ViewSetting menu5Button1Setting = getMenu5ButtonViewSetting(context, 0);
    ViewSetting menu5Button2Setting = getMenu5ButtonViewSetting(context, 1);
    return SizedBox(
      width: size.width,
      height: size.height * 0.6,
      child: Stack(
        children: [
          Background(
            name: imageName,
            width: size.width,
            height: size.height * 0.6,
          ),
          MenuButton(
            onTap: () {
              String nextPageRoute = '/onpu2_ken';
              // int rand = Random().nextInt(2);
              // if (rand == 1) {
              //   nextPageRoute = '/onpu2_ken_he';
              // }
              Navigator.of(context).pushNamed(nextPageRoute);
            },
            position: menu5Button1Setting.position,
            buttonSize: menu5Button1Setting.size,
          ),
          MenuButton(
            onTap: () {
              String nextPageRoute = '/onpu1';
              // int rand = Random().nextInt(2);
              // if (rand == 1) {
              //   nextPageRoute = '/onpu1_he';
              // }
              Navigator.of(context).pushNamed(nextPageRoute);
            },
            position: menu5Button2Setting.position,
            buttonSize: menu5Button2Setting.size,
          ),
        ],
      ),
    );
  }
}

class _MenuParts6 extends StatelessWidget {
  final GlobalKey widgetKey;
  const _MenuParts6({
    Key? key,
    required this.widgetKey,
  }) : super(key: widgetKey);
  @override
  Widget build(BuildContext context) {
    Size size = getScreenSize(context);
    String folder = getSizeFolderNameFromSize(size);
    String imageName = getBackGroundImageName(folder, 6);
    ViewSetting menu6Button1Setting = getMenu6ButtonViewSetting(context, 0);
    ViewSetting menu6Button2Setting = getMenu6ButtonViewSetting(context, 1);
    return SizedBox(
      width: size.width,
      height: size.height * 0.6,
      child: Stack(
        children: [
          Background(
            name: imageName,
            width: size.width,
            height: size.height * 0.6,
          ),
          MenuButton(
            onTap: () {
              String nextPageRoute = '/onpu2';
              // int rand = Random().nextInt(2);
              // if (rand == 1) {
              //   nextPageRoute = '/onpu2_ken_he';
              // }
              Navigator.of(context).pushNamed(nextPageRoute);
            },
            position: menu6Button1Setting.position,
            buttonSize: menu6Button1Setting.size,
          ),
          MenuButton(
            onTap: () {},
            position: menu6Button2Setting.position,
            buttonSize: menu6Button2Setting.size,
          ),
        ],
      ),
    );
  }
}

class _MenuParts7 extends StatelessWidget {
  final GlobalKey widgetKey;
  const _MenuParts7({
    Key? key,
    required this.widgetKey,
  }) : super(key: widgetKey);
  @override
  Widget build(BuildContext context) {
    Size size = getScreenSize(context);
    String folder = getSizeFolderNameFromSize(size);
    String imageName = getBackGroundImageName(folder, 7);
    ViewSetting menu7Button1Setting = getMenu7ButtonViewSetting(context, 0);
    ViewSetting menu7Button2Setting = getMenu7ButtonViewSetting(context, 1);
    return SizedBox(
      width: size.width,
      height: size.height * 0.6,
      child: Stack(
        children: [
          Background(
            name: imageName,
            width: size.width,
            height: size.height * 0.6,
          ),
          MenuButton(
            onTap: () {
              String nextPageRoute = '/quiz';
              // int rand = Random().nextInt(2);
              // if (rand == 1) {
              //   nextPageRoute = '/onpu2_ken_he';
              // }
              Navigator.of(context).pushNamed(nextPageRoute);
            },
            position: menu7Button1Setting.position,
            buttonSize: menu7Button1Setting.size,
          ),
          MenuButton(
            onTap: () {},
            position: menu7Button2Setting.position,
            buttonSize: menu7Button2Setting.size,
          ),
        ],
      ),
    );
  }
}
