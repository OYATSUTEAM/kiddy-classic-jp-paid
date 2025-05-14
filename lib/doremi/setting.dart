import 'global.dart';
import 'package:flutter/material.dart';
import 'config/flavor_config.dart';

//////////////////////////////////////////////////////////////////////
/// 共通
//////////////////////////////////////////////////////////////////////
Settings selectEnv() {
  //const env = String.fromEnvironment('BUILD_ENV');
  int target = getEnvSoundIndex();
  //target = 1; // 確認用

  return Settings(
    soundNo: target,
    learnImageName: _getLearnBGImageName(target),
    animationImageName: _getAnimationImageName(target),
    stickerImageName: _getStickerImageName(target),
    stickerBackImageName: _getStickerBGName(target, 0),
    stickerBackImageName2: _getStickerBGName(target, 1),
    drawImageName: _getDrawImageName(target),
  );
}

class Settings {
  final int soundNo;
  final String learnImageName; // 覚えましょう画面の背景画像
  final String animationImageName; // アニメーション画像
  final String stickerImageName; // シール画像
  final String stickerBackImageName; // シール貼り画面の背景画像
  final String stickerBackImageName2; // シール貼り画面の背景画像(2ページ目)
  final String drawImageName; // かきましょう画面の背景画像

  Settings({
    required this.soundNo,
    required this.learnImageName,
    required this.animationImageName,
    required this.stickerImageName,
    required this.stickerBackImageName,
    required this.stickerBackImageName2,
    required this.drawImageName,
  });
}

int getEnvSoundIndex() {
  // String? env = Uri.base.queryParameters["env"];
  // env ??= 'Do';
  String? env = globalData.globalEnv;

  int target = 0;
  switch (env) {
    case 'Do':
      break;
    case 'Re':
      target = 1;
      break;
    case 'Mi':
      target = 2;
      break;
    case 'Fa':
      target = 3;
      break;
    case 'So':
      target = 4;
      break;
    case 'Ra':
      target = 5;
      break;
    case 'Si':
      target = 6;
      break;
    case 'Do2':
      target = 7;
      break;
    default:
      break;
  }

  return target;
}

final List<String> _soundNames = [
  'Do',
  'Re',
  'Mi',
  'Fa',
  'So',
  'Ra',
  'Si',
  'Do2',
];

String getSoundName(int index) {
  return _soundNames[index];
}

Size getScreenSize(BuildContext context) {
  final Size size = MediaQuery.of(context).size;
  int index = getScreenSizeIndex(size);
  double scale = getScreenScaleFromSize(size);
  debugPrint('size: $size, index: $index, scale: $scale');
  return _imageSizes[index] * scale;
}

int getScreenSizeIndex(Size targetSize) {
  final double targetRate = targetSize.width / targetSize.height;
  double rate = _imageSizes[0].width / _imageSizes[0].height;
  int index = 0;
  double diff = (rate - targetRate).abs();
  if (_imageSizes.length > 1) {
    for (int i = 1; i < _imageSizes.length; i++) {
      rate = _imageSizes[i].width / _imageSizes[i].height;
      if ((rate - targetRate).abs() < diff) {
        diff = (rate - targetRate).abs();
        index = i;
      }
    }
  }
  return index;
}

double getScreenScale(BuildContext context) {
  final Size size = MediaQuery.of(context).size;
  int index = getScreenSizeIndex(size);
  double scale = size.width / (_imageSizes[index].width);
  if (scale > size.height / (_imageSizes[index].height)) {
    scale = size.height / (_imageSizes[index].height);
  }
  return scale;
}

double getScreenScaleFromSize(Size size) {
  int index = getScreenSizeIndex(size);
  double scale = size.width / (_imageSizes[index].width);
  if (scale > size.height / (_imageSizes[index].height)) {
    scale = size.height / (_imageSizes[index].height);
  }
  return scale;
}

class ViewSetting {
  final Offset position;
  final Size size;

  ViewSetting({
    required this.position,
    required this.size,
  });
}

final List<Size> _imageSizes = [
  // タブレットサイズ
  Size(2266, 1488),
  Size(2732, 2048),
  // スマホサイズ
  Size(2796, 1290),
  Size(1334, 750),
];

final List<String> _folderNames = [
  '2266x1488',
  '2732x2048',
  '2796x1290',
  '1334x750',
];

String getSizeFolderName(BuildContext context) {
  final Size size = MediaQuery.of(context).size;
  return getSizeFolderNameFromSize(size);
}

String getSizeFolderNameFromSize(Size size) {
  int index = getScreenSizeIndex(size);
  return _folderNames[index];
}

ViewSetting _getViewSetting(
    List<ViewSetting> viewSettings, BuildContext context) {
  final Size size = MediaQuery.of(context).size;
  double scale = getScreenScale(context);
  int index = getScreenSizeIndex(size);
  if (viewSettings.length <= index) {
    index = viewSettings.length - 1;
  }
  ViewSetting viewSetting = viewSettings[index];
  return ViewSetting(
    position: viewSetting.position * scale,
    size: viewSetting.size * scale,
  );
}

//////////////////////////////////////////////////////////////////////
/// 覚えましょう画面
//////////////////////////////////////////////////////////////////////

String _getLearnBGImageName(int no) {
  if (no < 0 || no >= _soundNames.length) {
    no = 0;
  }
  return '${_soundNames[no]}/learnBG.png';
}

String _getAnimationImageName(int no) {
  if (no < 0 || no >= _soundNames.length) {
    no = 0;
  }
  return '${_soundNames[no]}.gif';
}

List<ViewSetting> _learnButtonSettings = [
  ViewSetting(
      position: const Offset(1630, 1225),
      size: const Size(450, 150)), //2266x1488
  ViewSetting(
      position: const Offset(1970, 1720),
      size: const Size(560, 190)), //2732x2048
  ViewSetting(
      position: const Offset(2215, 1030),
      size: const Size(440, 150)), //2796x1290
  ViewSetting(
      position: const Offset(1017, 611), size: const Size(220, 75)), //1334x750
];

ViewSetting getLearnButtonViewSetting(BuildContext context) {
  return _getViewSetting(_learnButtonSettings, context);
}

List<ViewSetting> _learnCharacterSettings = [
  ViewSetting(
      position: const Offset(1459 - 224 * 0.5, 265 - 112 * 0.5 + 148),
      size: const Size(1120 * 0.8, 1120 * 0.8)), //2266x1488
  ViewSetting(
      position: const Offset(1738 - 316 * 0.5, 398 - 158 * 0.5 + 205),
      size: const Size(1580 * 0.8, 1580 * 0.8)), //2732x2048
  ViewSetting(
      position: const Offset(1825 - 229 * 0.5, 178 - 114 * 0.5 + 129 * 1.5),
      size: const Size(1145 * 0.8, 1145 * 0.8)), //2796x1290
  ViewSetting(
      position: const Offset(848 - 126 * 0.5, 160 - 63 * 0.5 + 75 * 1.5),
      size: const Size(630 * 0.8, 630 * 0.8)), //1334x750
];
/*List<ViewSetting> _learnCharacterSettings = [
  ViewSetting(
      position: const Offset(1459, 265),
      size: const Size(672, 896)), //2266x1488
  ViewSetting(
      position: const Offset(1738, 398),
      size: const Size(948, 1264)), //2732x2048
  ViewSetting(
      position: const Offset(1825, 178),
      size: const Size(687, 916)), //2796x1290
  ViewSetting(
      position: const Offset(848, 160), size: const Size(378, 504)), //1334x750
];*/

ViewSetting getLearnCharacterViewSetting(BuildContext context) {
  return _getViewSetting(_learnCharacterSettings, context);
}

//////////////////////////////////////////////////////////////////////
/// シールを貼りましょう画面
//////////////////////////////////////////////////////////////////////
class StickerViewSetting {
  final List<Offset> positions;
  final Size size;

  StickerViewSetting({
    required this.positions,
    required this.size,
  });
}

String _getStickerImageName(int no) {
  if (no < 0 || no >= _soundNames.length) {
    no = 0;
  }
  return '${_soundNames[no]}/seal.png';
}

String _getStickerBGName(int no, int level) {
  if (no < 0 || no >= _soundNames.length) {
    no = 0;
  }
  String bgName = (level <= 0) ? 'stickerBG' : 'sticker2BG';
  return '${_soundNames[no]}/$bgName.png';
}

final List<Size> stickerSizes = [
  Size(131, 131), //2266x1488
  Size(181, 181), //2732x2048
  Size(141, 141), //2796x1290
  Size(78, 78), //1334x750
];

const List<List<List<Offset>>> stickerPositionsToon = [
  [
    // 2266x1488
    [
      // ド
      Offset(652, 922),
      Offset(652 + (1420 - 652) / 4 * 1, 922),
      Offset(652 + (1420 - 652) / 4 * 2, 922),
      Offset(652 + (1420 - 652) / 4 * 3, 922),
      Offset(1420, 922),
    ],
    [
      // レ
      Offset(654, 870),
      Offset(654 + (1408 - 654) / 4 * 1, 870),
      Offset(654 + (1408 - 654) / 4 * 2, 870),
      Offset(654 + (1408 - 654) / 4 * 3, 870),
      Offset(1408, 870),
    ],
    [
      // ミ
      Offset(652, 824),
      Offset(652 + (1420 - 652) / 4 * 1, 824),
      Offset(652 + (1420 - 652) / 4 * 2, 824),
      Offset(652 + (1420 - 652) / 4 * 3, 824),
      Offset(1420, 824),
    ],
    [
      // ファ
      Offset(652, 792),
      Offset(652 + (1420 - 652) / 4 * 1, 792),
      Offset(652 + (1420 - 652) / 4 * 2, 792),
      Offset(652 + (1420 - 652) / 4 * 3, 792),
      Offset(1420, 792),
    ],
    [
      // ソ
      Offset(652, 742),
      Offset(652 + (1420 - 652) / 4 * 1, 742),
      Offset(652 + (1420 - 652) / 4 * 2, 742),
      Offset(652 + (1420 - 652) / 4 * 3, 742),
      Offset(1420, 742),
    ],
    [
      // ラ
      Offset(652, 672),
      Offset(652 + (1420 - 652) / 4 * 1, 672),
      Offset(652 + (1420 - 652) / 4 * 2, 672),
      Offset(652 + (1420 - 652) / 4 * 3, 672),
      Offset(1420, 672),
    ],
    [
      // シ
      Offset(652, 624),
      Offset(652 + (1420 - 652) / 4 * 1, 624),
      Offset(652 + (1420 - 652) / 4 * 2, 624),
      Offset(652 + (1420 - 652) / 4 * 3, 624),
      Offset(1420, 624),
    ],
    [
      // 高いド
      Offset(642, 566),
      Offset(642 + (1378 - 642) / 4 * 1, 566),
      Offset(642 + (1378 - 642) / 4 * 2, 566),
      Offset(642 + (1378 - 642) / 4 * 3, 566),
      Offset(1378, 566),
    ],
  ],
  [
    // 2732x2048
    [
      // ド
      Offset(750, 1270),
      Offset(750 + (1800 - 750) / 4 * 1, 1270),
      Offset(750 + (1800 - 750) / 4 * 2, 1270),
      Offset(750 + (1800 - 750) / 4 * 3, 1270),
      Offset(1800, 1270),
    ],
    [
      // レ
      Offset(750, 1185),
      Offset(750 + (1800 - 750) / 4 * 1, 1185),
      Offset(750 + (1800 - 750) / 4 * 2, 1185),
      Offset(750 + (1800 - 750) / 4 * 3, 1185),
      Offset(1800, 1185),
    ],
    [
      // ミ
      Offset(750, 1125),
      Offset(750 + (1800 - 750) / 4 * 1, 1125),
      Offset(750 + (1800 - 750) / 4 * 2, 1125),
      Offset(750 + (1800 - 750) / 4 * 3, 1125),
      Offset(1800, 1125),
    ],
    [
      // ファ
      Offset(750, 1065),
      Offset(750 + (1800 - 750) / 4 * 1, 1065),
      Offset(750 + (1800 - 750) / 4 * 2, 1065),
      Offset(750 + (1800 - 750) / 4 * 3, 1065),
      Offset(1800, 1065),
    ],
    [
      // ソ
      Offset(750, 1005),
      Offset(750 + (1800 - 750) / 4 * 1, 1005),
      Offset(750 + (1800 - 750) / 4 * 2, 1005),
      Offset(750 + (1800 - 750) / 4 * 3, 1005),
      Offset(1800, 1005),
    ],
    [
      // ラ
      Offset(750, 915),
      Offset(750 + (1800 - 750) / 4 * 1, 915),
      Offset(750 + (1800 - 750) / 4 * 2, 915),
      Offset(750 + (1800 - 750) / 4 * 3, 915),
      Offset(1800, 915),
    ],
    [
      // シ
      Offset(750, 870),
      Offset(750 + (1800 - 750) / 4 * 1, 870),
      Offset(750 + (1800 - 750) / 4 * 2, 870),
      Offset(750 + (1800 - 750) / 4 * 3, 870),
      Offset(1800, 870),
    ],
    [
      // 高いド
      Offset(729, 795),
      Offset(729 + (1803 - 729) / 4 * 1, 795),
      Offset(729 + (1803 - 729) / 4 * 2, 795),
      Offset(729 + (1803 - 729) / 4 * 3, 795),
      Offset(1803, 795),
    ],
  ],
  [
    // 2796x1290
    [
      // ド
      Offset(740, 1074 - 66 * 0),
      Offset(740 + (1686 - 740) / 4 * 1, 1074 - 66 * 0),
      Offset(740 + (1686 - 740) / 4 * 2, 1074 - 66 * 0),
      Offset(740 + (1686 - 740) / 4 * 3, 1074 - 66 * 0),
      Offset(1686, 1074 - 66 * 0),
    ],
    [
      // レ
      Offset(740, 1074 - 66 * 1),
      Offset(740 + (1686 - 740) / 4 * 1, 1074 - 66 * 1),
      Offset(740 + (1686 - 740) / 4 * 2, 1074 - 66 * 1),
      Offset(740 + (1686 - 740) / 4 * 3, 1074 - 66 * 1),
      Offset(1686, 1074 - 66 * 1),
    ],
    [
      // ミ
      Offset(740, 1074 - 66 * 2),
      Offset(740 + (1686 - 740) / 4 * 1, 1074 - 66 * 2),
      Offset(740 + (1686 - 740) / 4 * 2, 1074 - 66 * 2),
      Offset(740 + (1686 - 740) / 4 * 3, 1074 - 66 * 2),
      Offset(1686, 1074 - 66 * 2),
    ],
    [
      // ファ
      Offset(740, 1074 - 66 * 3),
      Offset(740 + (1686 - 740) / 4 * 1, 1074 - 66 * 3),
      Offset(740 + (1686 - 740) / 4 * 2, 1074 - 66 * 3),
      Offset(740 + (1686 - 740) / 4 * 3, 1074 - 66 * 3),
      Offset(1686, 1074 - 66 * 3),
    ],
    [
      // ソ
      Offset(740, 1074 - 66 * 4),
      Offset(740 + (1686 - 740) / 4 * 1, 1074 - 66 * 4),
      Offset(740 + (1686 - 740) / 4 * 2, 1074 - 66 * 4),
      Offset(740 + (1686 - 740) / 4 * 3, 1074 - 66 * 4),
      Offset(1686, 1074 - 66 * 4),
    ],
    [
      // ラ
      Offset(740, 1074 - 66 * 5),
      Offset(740 + (1686 - 740) / 4 * 1, 1074 - 66 * 5),
      Offset(740 + (1686 - 740) / 4 * 2, 1074 - 66 * 5),
      Offset(740 + (1686 - 740) / 4 * 3, 1074 - 66 * 5),
      Offset(1686, 1074 - 66 * 5),
    ],
    [
      // シ
      Offset(740, 1074 - 66 * 6),
      Offset(740 + (1686 - 740) / 4 * 1, 1074 - 66 * 6),
      Offset(740 + (1686 - 740) / 4 * 2, 1074 - 66 * 6),
      Offset(740 + (1686 - 740) / 4 * 3, 1074 - 66 * 6),
      Offset(1686, 1074 - 66 * 6),
    ],
    [
      // 高いド
      Offset(740, 1074 - 66 * 7),
      Offset(740 + (1686 - 740) / 4 * 1, 1074 - 66 * 7),
      Offset(740 + (1686 - 740) / 4 * 2, 1074 - 66 * 7),
      Offset(740 + (1686 - 740) / 4 * 3, 1074 - 66 * 7),
      Offset(1686, 1074 - 66 * 7),
    ],
  ],
  [
    // 1334x750
    [
      // ド
      Offset(334, 614 - 38 * 0),
      Offset(334 + (868 - 334) / 4 * 1, 614 - 38 * 0),
      Offset(334 + (868 - 334) / 4 * 2, 614 - 38 * 0),
      Offset(334 + (868 - 334) / 4 * 3, 614 - 38 * 0),
      Offset(868, 614 - 38 * 0),
    ],
    [
      // レ
      Offset(334, 614 - 38 * 1),
      Offset(334 + (868 - 334) / 4 * 1, 614 - 38 * 1),
      Offset(334 + (868 - 334) / 4 * 2, 614 - 38 * 1),
      Offset(334 + (868 - 334) / 4 * 3, 614 - 38 * 1),
      Offset(868, 614 - 38 * 1),
    ],
    [
      // ミ
      Offset(334, 614 - 38 * 2),
      Offset(334 + (868 - 334) / 4 * 1, 614 - 38 * 2),
      Offset(334 + (868 - 334) / 4 * 2, 614 - 38 * 2),
      Offset(334 + (868 - 334) / 4 * 3, 614 - 38 * 2),
      Offset(868, 614 - 38 * 2),
    ],
    [
      // ファ
      Offset(334, 614 - 38 * 3),
      Offset(334 + (868 - 334) / 4 * 1, 614 - 38 * 3),
      Offset(334 + (868 - 334) / 4 * 2, 614 - 38 * 3),
      Offset(334 + (868 - 334) / 4 * 3, 614 - 38 * 3),
      Offset(868, 614 - 38 * 3),
    ],
    [
      // ソ
      Offset(334, 614 - 38 * 4),
      Offset(334 + (868 - 334) / 4 * 1, 614 - 38 * 4),
      Offset(334 + (868 - 334) / 4 * 2, 614 - 38 * 4),
      Offset(334 + (868 - 334) / 4 * 3, 614 - 38 * 4),
      Offset(868, 614 - 38 * 4),
    ],
    [
      // ラ
      Offset(334, 614 - 38 * 5),
      Offset(334 + (868 - 334) / 4 * 1, 614 - 38 * 5),
      Offset(334 + (868 - 334) / 4 * 2, 614 - 38 * 5),
      Offset(334 + (868 - 334) / 4 * 3, 614 - 38 * 5),
      Offset(868, 614 - 38 * 5),
    ],
    [
      // シ
      Offset(334, 614 - 38 * 6),
      Offset(334 + (868 - 334) / 4 * 1, 614 - 38 * 6),
      Offset(334 + (868 - 334) / 4 * 2, 614 - 38 * 6),
      Offset(334 + (868 - 334) / 4 * 3, 614 - 38 * 6),
      Offset(868, 614 - 38 * 6),
    ],
    [
      // 高いド
      Offset(334, 614 - 38 * 7),
      Offset(334 + (868 - 334) / 4 * 1, 614 - 38 * 7),
      Offset(334 + (868 - 334) / 4 * 2, 614 - 38 * 7),
      Offset(334 + (868 - 334) / 4 * 3, 614 - 38 * 7),
      Offset(868, 614 - 38 * 7),
    ],
  ],
];

const List<List<List<Offset>>> stickerPositionsHeon = [
  [
    // 2266x1488
    [
      // ド
      Offset(698, 646),
      Offset(896, 646),
      Offset(1090, 646),
      Offset(1286, 646),
      Offset(1482, 646),
    ],
    [
      // レ
      Offset(674, 590),
      Offset(866, 590),
      Offset(1060, 590),
      Offset(1252, 590),
      Offset(1444, 590),
    ],
    [
      // ミ
      Offset(672, 534),
      Offset(864, 534),
      Offset(1058, 534),
      Offset(1250, 534),
      Offset(1440, 534),
    ],
    [
      // ファ
      Offset(676, 480),
      Offset(872, 480),
      Offset(1062, 480),
      Offset(1256, 480),
      Offset(1448, 480),
    ],
    [
      // ソ
      Offset(672, 426),
      Offset(862, 426),
      Offset(1056, 426),
      Offset(1248, 426),
      Offset(1442, 426),
    ],
    [
      // ラ
      Offset(662, 370),
      Offset(852, 370),
      Offset(1042, 370),
      Offset(1232, 370),
      Offset(1422, 370),
    ],
    [
      // シ
      Offset(678, 314),
      Offset(868, 314),
      Offset(1056, 314),
      Offset(1246, 314),
      Offset(1436, 314),
    ],
    [
      // 高いド
      Offset(682, 332),
      Offset(878, 332),
      Offset(1074, 332),
      Offset(1270, 332),
      Offset(1468, 332),
    ],
  ],
  [
    // 2732x2048
    [
      // ド
      Offset(819, 897),
      Offset(1086, 897),
      Offset(1349, 897),
      Offset(1610, 897),
      Offset(1878, 897),
    ],
    [
      // レ
      Offset(797, 815),
      Offset(1061, 815),
      Offset(1324, 815),
      Offset(1586, 815),
      Offset(1850, 815),
    ],
    [
      // ミ
      Offset(797, 742),
      Offset(1059, 742),
      Offset(1321, 742),
      Offset(1583, 742),
      Offset(1845, 742),
    ],
    [
      // ファ
      Offset(797, 670),
      Offset(1059, 670),
      Offset(1320, 670),
      Offset(1581, 670),
      Offset(1842, 670),
    ],
    [
      // ソ
      Offset(797, 594),
      Offset(1058, 594),
      Offset(1319, 594),
      Offset(1581, 594),
      Offset(1841, 594),
    ],
    [
      // ラ
      Offset(795, 520),
      Offset(1054, 520),
      Offset(1313, 520),
      Offset(1571, 520),
      Offset(1829, 520),
    ],
    [
      // シ
      Offset(789, 448),
      Offset(1049, 448),
      Offset(1309, 448),
      Offset(1570, 448),
      Offset(1829, 448),
    ],
    [
      // 高いド
      Offset(795, 420),
      Offset(1056, 420),
      Offset(1319, 420),
      Offset(1582, 420),
      Offset(1844, 420),
    ],
  ],
  [
    // 2796x1290
    [
      // ド
      Offset(903, 743),
      Offset(1137, 743),
      Offset(1369, 743),
      Offset(1602, 743),
      Offset(1834, 743),
    ],
    [
      // レ
      Offset(873, 681),
      Offset(1102, 681),
      Offset(1331, 681),
      Offset(1561, 681),
      Offset(1788, 681),
    ],
    [
      // ミ
      Offset(872, 615),
      Offset(1100, 615),
      Offset(1328, 615),
      Offset(1556, 615),
      Offset(1784, 615),
    ],
    [
      // ファ
      Offset(869, 551),
      Offset(1097, 551),
      Offset(1325, 551),
      Offset(1553, 551),
      Offset(1781, 551),
    ],
    [
      // ソ
      Offset(863, 488),
      Offset(1093, 488),
      Offset(1322, 488),
      Offset(1552, 488),
      Offset(1782, 488),
    ],
    [
      // ラ
      Offset(866, 419),
      Offset(1098, 419),
      Offset(1330, 419),
      Offset(1563, 419),
      Offset(1796, 419),
    ],
    [
      // シ
      Offset(881, 384),
      Offset(1113, 384),
      Offset(1344, 384),
      Offset(1576, 384),
      Offset(1808, 384),
    ],
    [
      // 高いド
      Offset(867, 396),
      Offset(1095, 396),
      Offset(1325, 396),
      Offset(1555, 396),
      Offset(1784, 396),
    ],
  ],
  [
    // 1334x750
    [
      // ド
      Offset(396, 429),
      Offset(521, 429),
      Offset(646, 429),
      Offset(771, 429),
      Offset(896, 429),
    ],
    [
      // レ
      Offset(379, 394),
      Offset(503, 394),
      Offset(627, 394),
      Offset(751, 394),
      Offset(875, 394),
    ],
    [
      // ミ
      Offset(379, 359),
      Offset(503, 359),
      Offset(627, 359),
      Offset(751, 359),
      Offset(875, 359),
    ],
    [
      // ファ
      Offset(386, 319),
      Offset(512, 319),
      Offset(638, 319),
      Offset(764, 319),
      Offset(890, 319),
    ],
    [
      // ソ
      Offset(374, 290),
      Offset(498, 290),
      Offset(620, 290),
      Offset(743, 290),
      Offset(866, 290),
    ],
    [
      // ラ
      Offset(375, 256),
      Offset(498, 256),
      Offset(620, 256),
      Offset(742, 256),
      Offset(864, 256),
    ],
    [
      // シ
      Offset(375, 248),
      Offset(499, 248),
      Offset(624, 248),
      Offset(748, 248),
      Offset(873, 248),
    ],
    [
      // 高いド
      Offset(389, 238),
      Offset(514, 238),
      Offset(639, 238),
      Offset(764, 238),
      Offset(889, 238),
    ],
  ],
];

int getStickerNum() {
  return 5;
}

int getStickerCorrectNum(int level, int soundNo) {
  GameFlavor flavor = FlavorConfig.flavor;
  if (flavor == GameFlavor.jaToon || flavor == GameFlavor.enToon) {
    return level <= 0
        ? stickerPositionsToon[0][soundNo].length
        : stickerPositions2Toon[0][soundNo].length;
  } else {
    return level <= 0
        ? stickerPositionsHeon[0][soundNo].length
        : stickerPositions2Heon[0][soundNo].length;
  }
}

List<ViewSetting> _stickerInitSettings = [
  ViewSetting(
    position: Offset(1900, 300),
    size: Size(0, 150), //2266x1488
  ),
  ViewSetting(
    position: Offset(2400, 450),
    size: Size(0, 200), //2732x2048
  ),
  ViewSetting(
    position: Offset(2300, 430),
    size: Size(200, 200), //2796x1290
  ),
  ViewSetting(
    position: Offset(1120, 260),
    size: Size(105, 105), //1334x750
  ),
];

StickerViewSetting _getStickerViewSetting(
    BuildContext context, List<Offset> positions) {
  final Size size = MediaQuery.of(context).size;
  double scale = getScreenScale(context);
  int index = getScreenSizeIndex(size);
  if (stickerSizes.length <= index) {
    index = stickerSizes.length - 1;
  }

  return StickerViewSetting(
    positions: positions.map((offset) => offset * scale).toList(),
    size: stickerSizes[index] * scale,
  );
}

StickerViewSetting getStickerTargetViewSetting(
    BuildContext context, int soundNo, int level) {
  int index = getScreenSizeIndex(MediaQuery.of(context).size);
  GameFlavor flavor = FlavorConfig.flavor;
  if (flavor == GameFlavor.jaToon || flavor == GameFlavor.enToon) {
    List<Offset> positions = level <= 0
        ? stickerPositionsToon[index][soundNo]
        : stickerPositions2Toon[index][soundNo];
    return _getStickerViewSetting(context, positions);
  } else {
    List<Offset> positions = level <= 0
        ? stickerPositionsHeon[index][soundNo]
        : stickerPositions2Heon[index][soundNo];
    return _getStickerViewSetting(context, positions);
  }
}

List<Offset> getStickerInitSetting(BuildContext context, int num) {
  int index = getScreenSizeIndex(MediaQuery.of(context).size);
  ViewSetting setting = _getViewSetting(_stickerInitSettings, context);
  List<Offset> initPositions = [];
  for (int i = 0; i < num; i++) {
    Offset ofs = setting.position;
    if (i > 2 && index >= 2) {
      ofs += Offset(setting.size.width, setting.size.height * (i - 3));
    } else {
      ofs += Offset(0, setting.size.height * i);
    }
    initPositions.add(ofs);
  }

  return initPositions;
}

List<Size> _nextButtonViewSizes = [
  Size(618, 252),
  Size(618, 252),
  Size(618, 252),
  Size(618, 252),
];

Size getStickerNextButtonSize(BuildContext context) {
  final Size size = MediaQuery.of(context).size;
  double scale = getScreenScale(context);
  int index = getScreenSizeIndex(size);
  if (_nextButtonViewSizes.length <= index) {
    index = _nextButtonViewSizes.length - 1;
  }
  if (index > 0) {
    double imageScale = _imageSizes[index].width / _imageSizes[0].width;
    if (imageScale > _imageSizes[index].height / _imageSizes[0].height) {
      imageScale = _imageSizes[index].height / _imageSizes[0].height;
    }
    debugPrint('imageScale: $imageScale');
    scale *= imageScale;
  }
  return _nextButtonViewSizes[index] * scale;
}

List<Size> _completeViewSizes = [
  Size(1612 * 0.6, 624 * 0.6),
  Size(1612 * 0.6, 624 * 0.6),
  Size(1612 * 0.6, 624 * 0.6),
  Size(1612 * 0.6, 624 * 0.6),
];

Size getStickerCompleteSize(BuildContext context) {
  final Size size = MediaQuery.of(context).size;
  double scale = getScreenScale(context);
  int index = getScreenSizeIndex(size);
  if (_completeViewSizes.length <= index) {
    index = _completeViewSizes.length - 1;
  }
  if (index > 0) {
    double imageScale = _imageSizes[index].width / _imageSizes[0].width;
    if (imageScale < _imageSizes[index].height / _imageSizes[0].height) {
      imageScale = _imageSizes[index].height / _imageSizes[0].height;
    }
    debugPrint('imageScale: $imageScale');
    scale *= imageScale;
  }
  return _completeViewSizes[index] * scale;
}

//////////////////////////////////////////////////////////////////////
/// シールを貼りましょう画面 2ページ目
//////////////////////////////////////////////////////////////////////
const List<List<List<Offset>>> stickerPositions2Toon = [
  [
    // 2266x1488
    [
      // ド
      Offset(652, 908),
      Offset(1038, 908),
      Offset(1424, 908),
    ],
    [
      // レ
      Offset(854, 856),
      Offset(1240, 856),
    ],
    [
      // ミ
      Offset(660, 828),
      Offset(1042, 828),
      Offset(1422, 828),
    ],
    [
      // ファ
      Offset(658, 770),
      Offset(1238, 770),
    ],
    [
      // ソ
      Offset(660, 704),
      Offset(1046, 704),
      Offset(1236, 704),
    ],
    [
      // ラ
      Offset(650, 680),
      Offset(1038, 680),
      Offset(1424, 680),
    ],
    [
      // シ
      Offset(654, 592),
      Offset(1042, 592),
      Offset(1430, 592),
    ],
    [
      // 高いド
      Offset(648, 536),
      Offset(1040, 536),
      Offset(1424, 536),
    ],
  ],
  [
    // 2732x2048
    [
      // ド
      Offset(760, 1248),
      Offset(1284, 1248),
      Offset(1816, 1248),
    ],
    [
      // レ
      Offset(1017, 1170),
      Offset(1554, 1170),
    ],
    [
      // ミ
      Offset(765, 1146),
      Offset(1290, 1146),
      Offset(1818, 1146),
    ],
    [
      // ファ
      Offset(768, 1056),
      Offset(1560, 1056),
    ],
    [
      // ソ
      Offset(762, 966),
      Offset(1287, 966),
      Offset(1554, 966),
    ],
    [
      // ラ
      Offset(744, 930),
      Offset(1280, 930),
      Offset(1818, 930),
    ],
    [
      // シ
      Offset(738, 816),
      Offset(1269, 816),
      Offset(1806, 816),
    ],
    [
      // 高いド
      Offset(750, 732),
      Offset(1284, 732),
      Offset(1818, 732),
    ],
  ],
  [
    // 2796x1290
    [
      // ド
      Offset(876, 1100),
      Offset(1416, 1100),
      Offset(1960, 1100),
    ],
    [
      // レ
      Offset(1008, 988),
      Offset(1556, 988),
    ],
    [
      // ミ
      Offset(688, 892),
      Offset(1228, 892),
      Offset(1764, 892),
    ],
    [
      // ファ
      Offset(728, 848),
      Offset(1456, 848),
    ],
    [
      // ソ
      Offset(788, 768),
      Offset(1288, 768),
      Offset(1536, 768),
    ],
    [
      // ラ
      Offset(724, 708),
      Offset(1264, 708),
      Offset(1812, 708),
    ],
    [
      // シ
      Offset(800, 636),
      Offset(1300, 636),
      Offset(1804, 636),
    ],
    [
      // 高いド
      Offset(644, 552),
      Offset(1144, 552),
      Offset(1656, 552),
    ],
  ],
  [
    // 1334x750
    [
      // ド
      Offset(384, 636),
      Offset(692, 636),
      Offset(1002, 636),
    ],
    [
      // レ
      Offset(538, 598),
      Offset(848, 598),
    ],
    [
      // ミ
      Offset(366, 506),
      Offset(650, 506),
      Offset(936, 506),
    ],
    [
      // ファ
      Offset(340, 478),
      Offset(740, 478),
    ],
    [
      // ソ
      Offset(356, 434),
      Offset(630, 434),
      Offset(764, 434),
    ],
    [
      // ラ
      Offset(386, 386),
      Offset(688, 386),
      Offset(994, 386),
    ],
    [
      // シ
      Offset(362, 382),
      Offset(640, 382),
      Offset(914, 382),
    ],
    [
      // 高いド
      Offset(336, 344),
      Offset(614, 344),
      Offset(890, 344),
    ],
  ]
];

const List<List<List<Offset>>> stickerPositions2Heon = [
  [
    // 2266x1488
    [
      // ド
      Offset(1518, 640),
    ],
    [
      // レ
      Offset(898, 570),
      Offset(1506, 570),
    ],
    [
      // ミ
      Offset(1098, 512),
      Offset(1498, 512),
    ],
    [
      // ファ
      Offset(696, 454),
      Offset(1096, 454),
    ],
    [
      // ソ
      Offset(912, 396),
      Offset(1316, 396),
    ],
    [
      // ラ
      Offset(914, 340),
      Offset(1316, 340),
      Offset(1518, 340),
    ],
    [
      // シ
      Offset(688, 288),
      Offset(1296, 288),
    ],
    [
      // 高いド
      Offset(902, 318),
      Offset(1310, 318),
    ],
  ],
  [
    // 2732x2048
    [
      // ド
      Offset(1840, 872),
    ],
    [
      // レ
      Offset(1068, 800),
      Offset(1831, 800),
    ],
    [
      // ミ
      Offset(1332, 726),
      Offset(1841, 726),
    ],
    [
      // ファ
      Offset(818, 648),
      Offset(1325, 648),
    ],
    [
      // ソ
      Offset(1074, 580),
      Offset(1582, 580),
    ],
    [
      // ラ
      Offset(1081, 510),
      Offset(1588, 510),
      Offset(1840, 510),
    ],
    [
      // シ
      Offset(817, 440),
      Offset(1583, 440),
    ],
    [
      // 高いド
      Offset(1071, 510),
      Offset(1580, 510),
    ],
  ],
  [
    // 2796x1290
    [
      // ド
      Offset(1830, 719),
    ],
    [
      // レ
      Offset(1129, 650),
      Offset(1830, 650),
    ],
    [
      // ミ
      Offset(1365, 584),
      Offset(1831, 584),
    ],
    [
      // ファ
      Offset(892, 518),
      Offset(1359, 518),
    ],
    [
      // ソ
      Offset(1134, 452),
      Offset(1602, 452),
    ],
    [
      // ラ
      Offset(1135, 387),
      Offset(1600, 387),
      Offset(1832, 387),
    ],
    [
      // シ
      Offset(904, 374),
      Offset(1604, 374),
    ],
    [
      // 高いド
      Offset(1129, 350),
      Offset(1593, 350),
    ],
  ],
  [
    // 1334x750
    [
      // ド
      Offset(889, 433),
    ],
    [
      // レ
      Offset(513, 398),
      Offset(889, 398),
    ],
    [
      // ミ
      Offset(644, 360),
      Offset(897, 360),
    ],
    [
      // ファ
      Offset(397, 323),
      Offset(652, 323),
    ],
    [
      // ソ
      Offset(515, 290),
      Offset(767, 290),
    ],
    [
      // ラ
      Offset(512, 256),
      Offset(761, 256),
      Offset(885, 256),
    ],
    [
      // シ
      Offset(399, 239),
      Offset(783, 239),
    ],
    [
      // 高いド
      Offset(515, 229),
      Offset(769, 229),
    ],
  ]
];

//////////////////////////////////////////////////////////////////////
/// 描きましょう画面
//////////////////////////////////////////////////////////////////////
String _getDrawImageName(int no) {
  if (no < 0 || no >= _soundNames.length) {
    no = 0;
  }
  return '${_soundNames[no]}/drawBG.png';
}

const List<List<List<Offset>>> drawPositionsToon = [
  [
    // 2266x1488
    [
      // ド
      Offset(768, 950 - 54 * 0),
      Offset(768 + (1584 - 768) / 4 * 1, 950 - 54 * 0),
      Offset(768 + (1584 - 768) / 4 * 2, 950 - 54 * 0),
      Offset(768 + (1584 - 768) / 4 * 3, 950 - 54 * 0),
      Offset(1584, 950 - 54 * 0),
    ],
    [
      // レ
      Offset(768, 950 - 54 * 1),
      Offset(768 + (1584 - 768) / 4 * 1, 950 - 54 * 1),
      Offset(768 + (1584 - 768) / 4 * 2, 950 - 54 * 1),
      Offset(768 + (1584 - 768) / 4 * 3, 950 - 54 * 1),
      Offset(1584, 950 - 54 * 1),
    ],
    [
      // ミ
      Offset(768, 950 - 54 * 2),
      Offset(768 + (1584 - 768) / 4 * 1, 950 - 54 * 2),
      Offset(768 + (1584 - 768) / 4 * 2, 950 - 54 * 2),
      Offset(768 + (1584 - 768) / 4 * 3, 950 - 54 * 2),
      Offset(1584, 950 - 54 * 2),
    ],
    [
      // ファ
      Offset(768, 950 - 54 * 3),
      Offset(768 + (1584 - 768) / 4 * 1, 950 - 54 * 3),
      Offset(768 + (1584 - 768) / 4 * 2, 950 - 54 * 3),
      Offset(768 + (1584 - 768) / 4 * 3, 950 - 54 * 3),
      Offset(1584, 950 - 54 * 3),
    ],
    [
      // ソ
      Offset(768, 950 - 54 * 4),
      Offset(768 + (1584 - 768) / 4 * 1, 950 - 54 * 4),
      Offset(768 + (1584 - 768) / 4 * 2, 950 - 54 * 4),
      Offset(768 + (1584 - 768) / 4 * 3, 950 - 54 * 4),
      Offset(1584, 950 - 54 * 4),
    ],
    [
      // ラ
      Offset(768, 950 - 54 * 5),
      Offset(768 + (1584 - 768) / 4 * 1, 950 - 54 * 5),
      Offset(768 + (1584 - 768) / 4 * 2, 950 - 54 * 5),
      Offset(768 + (1584 - 768) / 4 * 3, 950 - 54 * 5),
      Offset(1584, 950 - 54 * 5),
    ],
    [
      // シ
      Offset(768, 950 - 54 * 6),
      Offset(768 + (1584 - 768) / 4 * 1, 950 - 54 * 6),
      Offset(768 + (1584 - 768) / 4 * 2, 950 - 54 * 6),
      Offset(768 + (1584 - 768) / 4 * 3, 950 - 54 * 6),
      Offset(1584, 950 - 54 * 6),
    ],
    [
      // 高いド
      Offset(768, 950 - 54 * 7),
      Offset(768 + (1584 - 768) / 4 * 1, 950 - 54 * 7),
      Offset(768 + (1584 - 768) / 4 * 2, 950 - 54 * 7),
      Offset(768 + (1584 - 768) / 4 * 3, 950 - 54 * 7),
      Offset(1584, 950 - 54 * 7),
    ],
  ],
  [
    // 2732x2048
    [
      // ド
      Offset(830, 1290 - 75 * 0),
      Offset(830 + (1944 - 830) / 4 * 1, 1290 - 75 * 0),
      Offset(830 + (1944 - 830) / 4 * 2, 1290 - 75 * 0),
      Offset(830 + (1944 - 830) / 4 * 3, 1290 - 75 * 0),
      Offset(1944, 1290 - 75 * 0),
    ],
    [
      // レ
      Offset(830, 1290 - 75 * 1),
      Offset(830 + (1944 - 830) / 4 * 1, 1290 - 75 * 1),
      Offset(830 + (1944 - 830) / 4 * 2, 1290 - 75 * 1),
      Offset(830 + (1944 - 830) / 4 * 3, 1290 - 75 * 1),
      Offset(1944, 1290 - 75 * 1),
    ],
    [
      // ミ
      Offset(830, 1290 - 75 * 2),
      Offset(830 + (1944 - 830) / 4 * 1, 1290 - 75 * 2),
      Offset(830 + (1944 - 830) / 4 * 2, 1290 - 75 * 2),
      Offset(830 + (1944 - 830) / 4 * 3, 1290 - 75 * 2),
      Offset(1944, 1290 - 75 * 2),
    ],
    [
      // ファ
      Offset(830, 1290 - 75 * 3),
      Offset(830 + (1944 - 830) / 4 * 1, 1290 - 75 * 3),
      Offset(830 + (1944 - 830) / 4 * 2, 1290 - 75 * 3),
      Offset(830 + (1944 - 830) / 4 * 3, 1290 - 75 * 3),
      Offset(1944, 1290 - 75 * 3),
    ],
    [
      // ソ
      Offset(830, 1290 - 75 * 4),
      Offset(830 + (1944 - 830) / 4 * 1, 1290 - 75 * 4),
      Offset(830 + (1944 - 830) / 4 * 2, 1290 - 75 * 4),
      Offset(830 + (1944 - 830) / 4 * 3, 1290 - 75 * 4),
      Offset(1944, 1290 - 75 * 4),
    ],
    [
      // ラ
      Offset(830, 1290 - 75 * 5),
      Offset(830 + (1944 - 830) / 4 * 1, 1290 - 75 * 5),
      Offset(830 + (1944 - 830) / 4 * 2, 1290 - 75 * 5),
      Offset(830 + (1944 - 830) / 4 * 3, 1290 - 75 * 5),
      Offset(1944, 1290 - 75 * 5),
    ],
    [
      // シ
      Offset(830, 1290 - 75 * 6),
      Offset(830 + (1944 - 830) / 4 * 1, 1290 - 75 * 6),
      Offset(830 + (1944 - 830) / 4 * 2, 1290 - 75 * 6),
      Offset(830 + (1944 - 830) / 4 * 3, 1290 - 75 * 6),
      Offset(1944, 1290 - 75 * 6),
    ],
    [
      // 高いド
      Offset(830, 1290 - 75 * 7),
      Offset(830 + (1944 - 830) / 4 * 1, 1290 - 75 * 7),
      Offset(830 + (1944 - 830) / 4 * 2, 1290 - 75 * 7),
      Offset(830 + (1944 - 830) / 4 * 3, 1290 - 75 * 7),
      Offset(1944, 1290 - 75 * 7),
    ],
  ],
  [
    // 2796x1290
    [
      // ド
      Offset(1720, 1044 - 85 * 0),
      Offset(2116, 1004 - 85 * 0),
    ],
    [
      // レ
      Offset(1720, 1044 - 85 * 1),
      Offset(2116, 1004 - 85 * 1),
    ],
    [
      // ミ
      Offset(1720, 1044 - 85 * 2),
      Offset(2116, 1004 - 85 * 2),
    ],
    [
      // ファ
      Offset(1720, 1044 - 85 * 3),
      Offset(2116, 1004 - 85 * 3),
    ],
    [
      // ソ
      Offset(1720, 1044 - 85 * 4),
      Offset(2116, 1004 - 85 * 4),
    ],
    [
      // ラ
      Offset(1720, 1044 - 85 * 5),
      Offset(2116, 1004 - 85 * 5),
    ],
    [
      // シ
      Offset(1720, 1044 - 85 * 6),
      Offset(2116, 1004 - 85 * 6),
    ],
    [
      // 高いド
      Offset(1720, 1044 - 85 * 7),
      Offset(2116, 1004 - 85 * 7),
    ]
  ],
  [
    // 1334x750
    [
      // ド
      Offset(818, 616 - 50 * 0),
      Offset(1050, 616 - 50 * 0),
    ],
    [
      // レ
      Offset(818, 616 - 50 * 1),
      Offset(1050, 616 - 50 * 1),
    ],
    [
      // ミ
      Offset(818, 616 - 50 * 2),
      Offset(1050, 616 - 50 * 2),
    ],
    [
      // ファ
      Offset(818, 616 - 50 * 3),
      Offset(1050, 616 - 50 * 3),
    ],
    [
      // ソ
      Offset(818, 616 - 50 * 4),
      Offset(1050, 616 - 50 * 4),
    ],
    [
      // ラ
      Offset(818, 616 - 50 * 5),
      Offset(1050, 616 - 50 * 5),
    ],
    [
      // シ
      Offset(818, 616 - 50 * 6),
      Offset(1050, 616 - 50 * 6),
    ],
    [
      // 高いド
      Offset(818, 616 - 50 * 7),
      Offset(1050, 616 - 50 * 7),
    ],
  ]
];

const List<List<List<Offset>>> drawPositionsHeon = [
  [
    // 2266x1488
    [
      // ド
      Offset(812, 678),
      Offset(1018, 678),
      Offset(1224, 678),
      Offset(1432, 678),
      Offset(1638, 678),
    ],
    [
      // レ
      Offset(776, 618),
      Offset(986, 618),
      Offset(1198, 618),
      Offset(1408, 618),
      Offset(1618, 618),
    ],
    [
      // ミ
      Offset(778, 558),
      Offset(988, 558),
      Offset(1200, 558),
      Offset(1412, 558),
      Offset(1622, 558),
    ],
    [
      // ファ
      Offset(786, 500),
      Offset(998, 500),
      Offset(1208, 500),
      Offset(1418, 500),
      Offset(1630, 500),
    ],
    [
      // ソ
      Offset(784, 442),
      Offset(994, 442),
      Offset(1204, 442),
      Offset(1416, 442),
      Offset(1626, 442),
    ],
    [
      // ラ
      Offset(776, 396),
      Offset(982, 396),
      Offset(1190, 396),
      Offset(1396, 396),
      Offset(1604, 396),
    ],
    [
      // シ
      Offset(796, 314),
      Offset(1010, 314),
      Offset(1224, 314),
      Offset(1438, 314),
      Offset(1652, 314),
    ],
    [
      // 高いド
      Offset(800, 368),
      Offset(1008, 368),
      Offset(1216, 368),
      Offset(1422, 368),
      Offset(1630, 368),
    ],
  ],
  [
    // 2732x2048
    [
      // ド
      Offset(963, 881),
      Offset(1223, 881),
      Offset(1483, 881),
      Offset(1742, 881),
      Offset(2002, 881),
    ],
    [
      // レ
      Offset(894, 855),
      Offset(1154, 855),
      Offset(1421, 855),
      Offset(1683, 855),
      Offset(1943, 855),
    ],
    [
      // ミ
      Offset(899, 780),
      Offset(1160, 780),
      Offset(1425, 780),
      Offset(1687, 780),
      Offset(1949, 780),
    ],
    [
      // ファ
      Offset(903, 709),
      Offset(1165, 709),
      Offset(1429, 709),
      Offset(1692, 709),
      Offset(1955, 709),
    ],
    [
      // ソ
      Offset(884, 632),
      Offset(1151, 632),
      Offset(1418, 632),
      Offset(1685, 632),
      Offset(1950, 632),
    ],
    [
      // ラ
      Offset(890, 567),
      Offset(1159, 567),
      Offset(1427, 567),
      Offset(1695, 567),
      Offset(1963, 567),
    ],
    [
      // シ
      Offset(892, 489),
      Offset(1155, 489),
      Offset(1419, 489),
      Offset(1683, 489),
      Offset(1948, 489),
    ],
    [
      // 高いド
      Offset(937, 529),
      Offset(1193, 529),
      Offset(1447, 529),
      Offset(1705, 529),
      Offset(1959, 529),
    ],
  ],
  [
    // 2796x1290
    [
      // ド
      Offset(1058, 727),
      Offset(1285, 727),
      Offset(1514, 727),
      Offset(1741, 727),
      Offset(1968, 727),
    ],
    [
      // レ
      Offset(1035, 668),
      Offset(1263, 668),
      Offset(1491, 668),
      Offset(1718, 668),
      Offset(1945, 668),
    ],
    [
      // ミ
      Offset(1038, 605),
      Offset(1266, 605),
      Offset(1494, 605),
      Offset(1721, 605),
      Offset(1948, 605),
    ],
    [
      // ファ
      Offset(1040, 544),
      Offset(1268, 544),
      Offset(1496, 544),
      Offset(1724, 544),
      Offset(1951, 544),
    ],
    [
      // ソ
      Offset(1040, 478),
      Offset(1268, 478),
      Offset(1495, 478),
      Offset(1723, 478),
      Offset(1950, 478),
    ],
    [
      // ラ
      Offset(1051, 414),
      Offset(1282, 414),
      Offset(1514, 414),
      Offset(1744, 414),
      Offset(1976, 414),
    ],
    [
      // シ
      Offset(1043, 418),
      Offset(1272, 418),
      Offset(1501, 418),
      Offset(1731, 418),
      Offset(1960, 418),
    ],
    [
      // 高いド
      Offset(1052, 415),
      Offset(1282, 415),
      Offset(1513, 415),
      Offset(1743, 415),
      Offset(1975, 415),
    ]
  ],
  [
    // 1334x750
    [
      // ド
      Offset(469, 435),
      Offset(597, 435),
      Offset(725, 435),
      Offset(853, 435),
      Offset(981, 435),
    ],
    [
      // レ
      Offset(456, 399),
      Offset(584, 399),
      Offset(711, 399),
      Offset(839, 399),
      Offset(966, 399),
    ],
    [
      // ミ
      Offset(458, 365),
      Offset(586, 365),
      Offset(713, 365),
      Offset(840, 365),
      Offset(967, 365),
    ],
    [
      // ファ
      Offset(460, 328),
      Offset(588, 328),
      Offset(715, 328),
      Offset(842, 328),
      Offset(970, 328),
    ],
    [
      // ソ
      Offset(457, 293),
      Offset(585, 293),
      Offset(712, 293),
      Offset(839, 293),
      Offset(966, 293),
    ],
    [
      // ラ
      Offset(460, 257),
      Offset(589, 257),
      Offset(717, 257),
      Offset(845, 257),
      Offset(974, 257),
    ],
    [
      // シ
      Offset(453, 249),
      Offset(582, 249),
      Offset(710, 249),
      Offset(838, 249),
      Offset(966, 249),
    ],
    [
      // 高いド
      Offset(461, 241),
      Offset(590, 241),
      Offset(718, 241),
      Offset(847, 241),
      Offset(975, 241),
    ],
  ]
];

class LineDrawTargetSettings {
  final Offset position;
  final int idx;

  LineDrawTargetSettings({
    required this.position,
    required this.idx,
  });
}

class LineDrawTargetViewSetting {
  final List<LineDrawTargetSettings> targets;
  final Size size;

  LineDrawTargetViewSetting({
    required this.targets,
    required this.size,
  });
}

List<Size> _lineDrawTargetSizes = [
  Size(125, 125),
  Size(155, 155),
  Size(170, 170),
  Size(100, 100),
];

Size getLineDrawTargetSize(BuildContext context) {
  final Size size = MediaQuery.of(context).size;
  double scale = getScreenScale(context);
  int index = getScreenSizeIndex(size);
  if (_lineDrawTargetSizes.length <= index) {
    index = _lineDrawTargetSizes.length - 1;
  }
  return _lineDrawTargetSizes[index] * scale;
}

LineDrawTargetViewSetting getDrawViewSetting(
    BuildContext context, int soundNo) {
  int index = getScreenSizeIndex(MediaQuery.of(context).size);
  GameFlavor flavor = FlavorConfig.flavor;
  StickerViewSetting targetView;
  int length;
  if (flavor == GameFlavor.jaToon || flavor == GameFlavor.enToon) {
    targetView =
        _getStickerViewSetting(context, drawPositionsToon[index][soundNo]);
    length = drawPositionsToon[index][soundNo].length;
  } else {
    targetView =
        _getStickerViewSetting(context, drawPositionsHeon[index][soundNo]);
    length = drawPositionsHeon[index][soundNo].length;
  }
  List<LineDrawTargetSettings> targetPositions = [];
  for (int i = 0; i < length; i++) {
    targetPositions.add(LineDrawTargetSettings(
      position: targetView.positions[i],
      idx: i,
    ));
  }
  double scale = getScreenScale(context);
  if (index >= _lineDrawTargetSizes.length) {
    index = _lineDrawTargetSizes.length - 1;
  }
  Size targetSize = _lineDrawTargetSizes[index] * scale;

  return LineDrawTargetViewSetting(size: targetSize, targets: targetPositions);
}
