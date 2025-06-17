import 'package:flutter/material.dart';
import 'package:kiddy_classic/setting.dart';

/////////////////////////////////////////////////////////////////////////////////////////////////
// 共通
/////////////////////////////////////////////////////////////////////////////////////////////////
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
  for (int i = 1; i < _imageSizes.length; i++) {
    rate = _imageSizes[i].width / _imageSizes[i].height;
    if ((rate - targetRate).abs() < diff) {
      diff = (rate - targetRate).abs();
      index = i;
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

String getSizeFolderName(BuildContext context) {
  final Size size = MediaQuery.of(context).size;
  return getSizeFolderNameFromSize(size);
}

String getSizeFolderNameFromSize(Size size) {
  int index = getScreenSizeIndex(size);
  return _folderNames[index];
}

final List<Size> _imageSizes = [
  // タブレットサイズ
  const Size(2266, 1488),
  const Size(2732, 2048),
  // スマホサイズ
  const Size(2796, 1290),
  const Size(1334, 750),
];

final List<String> _folderNames = [
  '2266x1488',
  '2732x2048',
  '2796x1290',
  '1334x750',
];

class ViewSetting {
  Offset position;
  Size size;

  ViewSetting({required this.position, required this.size});
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

/////////////////////////////////////////////////////////////////////////////////////////////////
// パズル
/////////////////////////////////////////////////////////////////////////////////////////////////
List<String> _puzzleImageNames = [
  'pazzle1.png',
  'pazzle2.png',
  'pazzle3.png',
  'pazzle4.png',
];

List<String> _puzzleFolderNames = [
  'To',
  'He',
];

String getPuzzleImageName(String folderName, int index, int level) {
  return 'assets/images/$folderName/${_puzzleFolderNames[level]}/${_puzzleImageNames[index]}';
}

String getPuzzleFolderName(int level) {
  if (level < 0 || level >= _puzzleFolderNames.length) {
    level = 0;
  }
  return _puzzleFolderNames[level];
}

List<ViewSetting> piecesViewSettings = [
  ViewSetting(
      position: const Offset(956, 106), size: const Size(476, 642)), //2266x1488
  ViewSetting(
      position: const Offset(1085, 170),
      size: const Size(649, 877)), //2732x2048
  ViewSetting(
      position: const Offset(1395, 95), size: const Size(410, 554)), //2796x1290
  ViewSetting(
      position: const Offset(695, 65), size: const Size(238, 322)), //1334x750
];

List<int> pieceNums = [4, 4];

ViewSetting getPieceViewSetting(BuildContext context, int index) {
  ViewSetting viewSetting = _getViewSetting(piecesViewSettings, context);
  double ofsX = 0;
  double ofsY = 0;
  switch (index) {
    case 1:
      ofsX = viewSetting.size.width;
      break;
    case 2:
      ofsY = viewSetting.size.height;
      break;
    case 3:
      ofsX = viewSetting.size.width;
      ofsY = viewSetting.size.height;
      break;
  }

  return ViewSetting(
    position: viewSetting.position + Offset(ofsX, ofsY),
    size: viewSetting.size,
  );
}

List<ViewSetting> _puzzleStartButtonViewSettings = [
  ViewSetting(
    //2266x1488
    position: const Offset(200, 1050),
    size: const Size(539, 231),
  ),
  ViewSetting(
    //2732x2048
    position: const Offset(100, 1400),
    size: const Size(778, 302),
  ),
  ViewSetting(
    //2796x1290
    position: const Offset(400, 850),
    size: const Size(471, 218),
  ),
  ViewSetting(
    //1334x750
    position: const Offset(100, 520),
    size: const Size(272, 116),
  ),
];

ViewSetting getPuzzleStartButtonViewSetting(BuildContext context) {
  return _getViewSetting(_puzzleStartButtonViewSettings, context);
}

List<ViewSetting> _puzzleNextButtonViewSettings = [
  ViewSetting(
    //2266x1488
    position: const Offset(200, 1250),
    size: const Size(539, 197),
  ),
  ViewSetting(
    //2732x2048
    position: const Offset(100, 1650),
    size: const Size(778, 303),
  ),
  ViewSetting(
    //2796x1290
    position: const Offset(400, 1080),
    size: const Size(461, 141),
  ),
  ViewSetting(
    //1334x750
    position: const Offset(100, 620),
    size: const Size(272, 107),
  ),
];

ViewSetting getPuzzleNextButtonViewSetting(BuildContext context) {
  return _getViewSetting(_puzzleNextButtonViewSettings, context);
}

/////////////////////////////////////////////////////////////////////////////////////////////////
// パズル(おんぷ)
/////////////////////////////////////////////////////////////////////////////////////////////////

List<String> _onpuPuzzlePartNames = [
  'parts1.png',
  'parts2.png',
  'parts3.png',
  'parts4.png',
  'parts5.png',
];

List<String> _kyufuPuzzlePartNames = [
  'parts1.png',
  'parts2.png',
  'parts3.png',
  'parts4.png',
  'parts5.png',
  'parts6.png',
  'parts7.png',
];

int getOnpuPuzzlePartNum(bool type) {
  return type ? _onpuPuzzlePartNames.length : _kyufuPuzzlePartNames.length;
}

List<List<Size>> _onpuPuzzlePartSizes = [
  [
    // 2266x1488
    const Size(110, 680), // parts1
    const Size(320, 220), // parts2
    const Size(300, 220), // parts3
    const Size(80, 70), // parts4
    const Size(240, 680), // parts5
  ],
  [
    // 2732x2048
    const Size(160, 1100), // parts1
    const Size(440, 320), // parts2
    const Size(440, 350), // parts3
    const Size(140, 140), // parts4
    const Size(420, 1268), // parts5
  ],
  [
    // 2796x1290
    const Size(81, 739), // parts1
    const Size(350, 255), // parts2
    const Size(358, 313), // parts3
    const Size(104, 102), // parts4
    const Size(327, 707), // parts5
  ],
  [
    // 1334x750
    const Size(49, 445), // parts1
    const Size(211, 185), // parts2
    const Size(216, 191), // parts3
    const Size(70, 66), // parts4
    const Size(187, 415), // parts5
  ],
];
List<List<Size>> _kyufuPuzzlePartSizes = [
  [
    // 2266x1488
    const Size(400, 180), // parts1
    const Size(600, 260), // parts2
    const Size(160, 650), // parts3
    const Size(380, 300), // parts4
    const Size(300, 360), // parts5
    const Size(300, 800), // parts6
    const Size(120, 130), // parts7
  ],
  [
    // 2732x2048
    const Size(650, 340), // parts1
    const Size(980, 110), // parts2
    const Size(400, 1000), // parts3
    const Size(600, 390), // parts4
    const Size(400, 480), // parts5
    const Size(422, 1130), // parts6
    const Size(234, 254), // parts7
    // Size(873, 403), // parts1
    // Size(1244, 286), // parts2
    // Size(629, 1220), // parts3
    // Size(780, 507), // parts4
    // Size(581, 633), // parts5
    // Size(633, 1428), // parts6
    // Size(234, 254), // parts7
  ],
  [
    // 2796x1290
    const Size(506, 199), // parts1
    const Size(683, 295), // parts2
    const Size(225, 739), // parts3
    const Size(416, 366), // parts4
    const Size(331, 390), // parts5
    const Size(309, 835), // parts6
    const Size(129, 118), // parts7
    // Size(506, 199), // parts1
    // Size(683, 295), // parts2
    // Size(320, 739), // parts3
    // Size(416, 366), // parts4
    // Size(331, 390), // parts5
    // Size(309, 835), // parts6
    // Size(129, 118), // parts7
  ],
  [
    // 1334x750
    const Size(263, 122), // parts1
    const Size(377, 172), // parts2
    const Size(106, 451), // parts3
    const Size(217, 192), // parts4
    const Size(170, 214), // parts5
    const Size(176, 521), // parts6
    const Size(45, 48), // parts7
    // Size(288, 178), // parts1
    // Size(445, 178), // parts2
    // Size(224, 451), // parts3
    // Size(271, 267), // parts4
    // Size(225, 275), // parts5
    // Size(260, 521), // parts6
    // Size(72, 66), // parts7
  ],
];

String getOnpuPuzzleImageName(String folderName, int index, bool type) {
  String typeName = type ? 'Onpu' : 'Kyufu';
  String imageName =
      type ? _onpuPuzzlePartNames[index] : _kyufuPuzzlePartNames[index];
  return 'assets/images/$folderName/$typeName/$imageName';
}

Size getOnpuPuzzlePieceSize(BuildContext context, int index, bool type) {
  int sizeIndex = getScreenSizeIndex(MediaQuery.of(context).size);
  double scale = getScreenScale(context);
  return (type
          ? _onpuPuzzlePartSizes[sizeIndex][index]
          : _kyufuPuzzlePartSizes[sizeIndex][index]) *
      scale;
}

List<String> _onpuPuzzleBGNames = [
  'zenonpu_bg.png',
  '2bun_onpu_bg.png',
  '4bun_onpu_bg.png',
  '8bun_onpu_bg.png',
  'huten2bun_onpu_bg.png',
  'huten4bun_onpu_bg.png',
];

List<String> _kyufuPuzzleBGNames = [
  'zen_kyufu_bg.png',
  '8bun_kyufu_bg.png',
  'huten4bun_kyufu_bg.png',
];
String getOnpuPuzzleBGName(String folderName, int level, bool type) {
  int max = type ? _onpuPuzzleBGNames.length : _kyufuPuzzleBGNames.length;
  if (level < 0 || level >= max) {
    level = 0;
  }
  String typeName = type ? 'Onpu' : 'Kyufu';
  String imageName =
      type ? _onpuPuzzleBGNames[level] : _kyufuPuzzleBGNames[level];
  return 'assets/images/$folderName/$typeName/$imageName';
}

String getOnpuPuzzleTitleBGName(String folderName, bool type) {
  String typeName = type ? 'Onpu' : 'Kyufu';
  return 'assets/images/$folderName/$typeName/puzzle_bg.png';
}

class OnpuPuzzleSetting {
  final int index;
  final Offset offset;

  OnpuPuzzleSetting({required this.index, required this.offset});
}

List<List<List<OnpuPuzzleSetting>>> _onpuPuzzleSettings = [
  [
    // 2266x1488
    [
      // 全音符
      OnpuPuzzleSetting(index: 1, offset: const Offset(-180, -120)),
    ],
    [
      // 2分音符
      OnpuPuzzleSetting(index: 0, offset: const Offset(-20, -460)),
      OnpuPuzzleSetting(index: 1, offset: const Offset(-210, 180)),
    ],
    [
      // 4分音符
      OnpuPuzzleSetting(index: 0, offset: const Offset(-50, -450)),
      OnpuPuzzleSetting(index: 2, offset: const Offset(-240, 170)),
    ],
    [
      // 8分音符
      OnpuPuzzleSetting(index: 0, offset: const Offset(-50, -450)),
      OnpuPuzzleSetting(index: 2, offset: const Offset(-240, 170)),
      OnpuPuzzleSetting(index: 4, offset: const Offset(35, -460)),
    ],
    [
      // 付点2分音符
      OnpuPuzzleSetting(index: 0, offset: const Offset(-20, -450)),
      OnpuPuzzleSetting(index: 1, offset: const Offset(-210, 180)),
      OnpuPuzzleSetting(index: 3, offset: const Offset(120, 180)),
    ],
    [
      // 付点4分音符
      OnpuPuzzleSetting(index: 0, offset: const Offset(-50, -450)),
      OnpuPuzzleSetting(index: 2, offset: const Offset(-240, 170)),
      OnpuPuzzleSetting(index: 3, offset: const Offset(110, 180)),
    ]
  ],
  [
    // 2732x2048
    [
      // 全音符
      OnpuPuzzleSetting(index: 1, offset: const Offset(-280.5, -200.5)),
    ],
    [
      // 2分音符
      OnpuPuzzleSetting(index: 0, offset: const Offset(0, -760)),
      OnpuPuzzleSetting(index: 1, offset: const Offset(-290, 200)),
    ],
    [
      // 4分音符
      OnpuPuzzleSetting(index: 0, offset: const Offset(-0, -760)),
      OnpuPuzzleSetting(index: 2, offset: const Offset(-310, 200)),
    ],
    [
      // 8分音符
      OnpuPuzzleSetting(index: 0, offset: const Offset(-20, -800)),
      OnpuPuzzleSetting(index: 2, offset: const Offset(-330, 160)),
      OnpuPuzzleSetting(index: 4, offset: const Offset(35, -830)),
    ],
    [
      // 付点2分音符
      OnpuPuzzleSetting(index: 0, offset: const Offset(0, -790)),
      OnpuPuzzleSetting(index: 1, offset: const Offset(-295, 190)),
      OnpuPuzzleSetting(index: 3, offset: const Offset(160, 190)),
    ],
    [
      // 付点4分音符
      OnpuPuzzleSetting(index: 0, offset: const Offset(-20, -770)),
      OnpuPuzzleSetting(index: 2, offset: const Offset(-330, 190)),
      OnpuPuzzleSetting(index: 3, offset: const Offset(160, 200)),
    ]
  ],
  [
    // 2796x1290
    [
      // 全音符
      OnpuPuzzleSetting(index: 1, offset: const Offset(-175, -127.5)),
    ],
    [
      // 2分音符
      OnpuPuzzleSetting(index: 0, offset: const Offset(0, -470)),
      OnpuPuzzleSetting(index: 1, offset: const Offset(-230, 200)),
    ],
    [
      // 4分音符
      OnpuPuzzleSetting(index: 0, offset: const Offset(0, -470)),
      OnpuPuzzleSetting(index: 2, offset: const Offset(-240, 160)),
    ],
    [
      // 8分音符
      OnpuPuzzleSetting(index: 0, offset: const Offset(-40, -470)),
      OnpuPuzzleSetting(index: 2, offset: const Offset(-280, 160)),
      OnpuPuzzleSetting(index: 4, offset: const Offset(-20, -470)),
    ],
    [
      // 付点2分音符
      OnpuPuzzleSetting(index: 0, offset: const Offset(-10, -470)),
      OnpuPuzzleSetting(index: 1, offset: const Offset(-240, 200)),
      OnpuPuzzleSetting(index: 3, offset: const Offset(110, 200)),
    ],
    [
      // 付点4分音符
      OnpuPuzzleSetting(index: 0, offset: const Offset(0, -470)),
      OnpuPuzzleSetting(index: 2, offset: const Offset(-240, 160)),
      OnpuPuzzleSetting(index: 3, offset: const Offset(110, 180)),
    ]
  ],
  [
    // 1334x750
    [
      // 全音符
      OnpuPuzzleSetting(index: 1, offset: const Offset(-105.5, -92.5)),
      // OnpuPuzzleSetting(index: 1, offset: const Offset(-50.5, -92.5)),
    ],
    [
      // 2分音符
      OnpuPuzzleSetting(index: 0, offset: const Offset(0, -290)),
      OnpuPuzzleSetting(index: 1, offset: const Offset(-140, 100)),
    ],
    [
      // 4分音符
      OnpuPuzzleSetting(index: 0, offset: const Offset(0, -290)),
      OnpuPuzzleSetting(index: 2, offset: const Offset(-155, 90)),
    ],
    [
      // 8分音符
      OnpuPuzzleSetting(index: 0, offset: const Offset(-15, -290)),
      OnpuPuzzleSetting(index: 2, offset: const Offset(-170, 90)),
      OnpuPuzzleSetting(index: 4, offset: const Offset(0, -275)),
    ],
    [
      // 付点2分音符
      OnpuPuzzleSetting(index: 0, offset: const Offset(0, -290)),
      OnpuPuzzleSetting(index: 1, offset: const Offset(-140, 100)),
      OnpuPuzzleSetting(index: 3, offset: const Offset(50, 100)),
    ],
    [
      // 付点4分音符
      OnpuPuzzleSetting(index: 0, offset: const Offset(-15, -290)),
      OnpuPuzzleSetting(index: 2, offset: const Offset(-170, 90)),
      OnpuPuzzleSetting(index: 3, offset: const Offset(40, 100)),
    ]
  ]
];

List<List<List<OnpuPuzzleSetting>>> _kyufuPuzzleSettings = [
  [
    // 2266x1488
    [
      // 全休符
      OnpuPuzzleSetting(index: 0, offset: const Offset(-100, -100)),
      OnpuPuzzleSetting(index: 1, offset: const Offset(-200, -200)),
    ],
    [
      // 8分休符
      OnpuPuzzleSetting(index: 2, offset: const Offset(-120, -300)),
      OnpuPuzzleSetting(index: 3, offset: const Offset(-305, -445)),
    ],
    [
      // 付点4分休符
      OnpuPuzzleSetting(index: 4, offset: const Offset(-250, 136)),
      OnpuPuzzleSetting(index: 5, offset: const Offset(-240, -510)),
      OnpuPuzzleSetting(index: 6, offset: const Offset(20, -180)),
    ]
  ],
  [
    // 2732x2048
    [
      // 全休符
      OnpuPuzzleSetting(index: 0, offset: const Offset(-320, -140)),
      OnpuPuzzleSetting(index: 1, offset: const Offset(-500, -130)),
    ],
    [
      // 8分休符
      OnpuPuzzleSetting(index: 2, offset: const Offset(-200, -400)),
      OnpuPuzzleSetting(index: 3, offset: const Offset(-460, -420)),
    ],
    [
      // 付点4分休符
      OnpuPuzzleSetting(index: 4, offset: const Offset(-240, 140)),
      OnpuPuzzleSetting(index: 5, offset: const Offset(-300, -800)),
      OnpuPuzzleSetting(index: 6, offset: const Offset(80, -340)),
    ]
  ],
  [
    // 2796x1290
    [
      // 全休符
      OnpuPuzzleSetting(index: 0, offset: const Offset(-250, -42)),
      OnpuPuzzleSetting(index: 1, offset: const Offset(-340, -172)),
    ],
    [
      // 8分休符
      OnpuPuzzleSetting(index: 2, offset: const Offset(-70, -300)),
      OnpuPuzzleSetting(index: 3, offset: const Offset(-225, -405)),
    ],
    [
      // 付点4分休符
      OnpuPuzzleSetting(index: 4, offset: const Offset(-250, 123)),
      OnpuPuzzleSetting(index: 5, offset: const Offset(-150, -500)),
      OnpuPuzzleSetting(index: 6, offset: const Offset(100, -150)),
    ]
  ],
  [
    // 1334x750
    [
      // 全休符
      OnpuPuzzleSetting(index: 0, offset: const Offset(-140, -52)),
      OnpuPuzzleSetting(index: 1, offset: const Offset(-210, -120)),
    ],
    [
      // 8分休符
      OnpuPuzzleSetting(index: 2, offset: const Offset(-70, -150)),
      OnpuPuzzleSetting(index: 3, offset: const Offset(-170, -220)),
    ],
    [
      // 付点4分休符
      OnpuPuzzleSetting(index: 4, offset: const Offset(-135, 43)),
      OnpuPuzzleSetting(index: 5, offset: const Offset(-100, -340)),
      OnpuPuzzleSetting(index: 6, offset: const Offset(80, -100)),
    ]
  ]
];

int getOnpuPuzzleNum(bool type) {
  return type ? _onpuPuzzleBGNames.length : _kyufuPuzzleBGNames.length;
}

List<OnpuPuzzleSetting> getOnpuPuzzleSetting(
    BuildContext context, int level, bool type) {
  final Size size = MediaQuery.of(context).size;
  int index = getScreenSizeIndex(size);
  int max = type ? _onpuPuzzleSettings.length : _kyufuPuzzleSettings.length;
  if (index >= max) {
    index = max - 1;
  }
  max = type
      ? _onpuPuzzleSettings[index].length
      : _kyufuPuzzleSettings[index].length;
  if (level >= max) {
    level = max - 1;
  }
  return type
      ? _onpuPuzzleSettings[index][level]
      : _kyufuPuzzleSettings[index][level];
}

List<ViewSetting> _onpuPuzzleCorrectAreaSettings = [
  ViewSetting(
      position: const Offset(957, 85),
      size: const Size(975, 1320)), // 2266x1488
  ViewSetting(
      position: const Offset(1095, 122),
      size: const Size(1340, 1805)), // 2732x2048
  ViewSetting(
      position: const Offset(1408, 100),
      size: const Size(806, 1092)), // 2796x1290
  ViewSetting(
      // position: const Offset(703, 45), size: const Size(495, 660)), // 1334x750
      position: const Offset(703, 45),
      size: const Size(495, 660)), // 1334x750
];

ViewSetting getOnpuPuzzleCorrectAreaSetting(BuildContext context) {
  return _getViewSetting(_onpuPuzzleCorrectAreaSettings, context);
}

List<ViewSetting> getOnpuPuzzleCorrectAreaSettings() {
  return _onpuPuzzleCorrectAreaSettings;
}

List<List<Offset>> _onpuStartPositions = [
  [
    // 2266x1488
    const Offset(-300, -400),
    const Offset(300, -400),
    const Offset(0, 0),
    const Offset(-300, 400),
    const Offset(300, 400),
  ],
  [
    // 2732x2048
    const Offset(-350, -600),
    const Offset(350, -600),
    const Offset(0, 0),
    const Offset(-350, 600),
    const Offset(350, 600),
  ],
  [
    // 2796x1290
    const Offset(-250, -400),
    const Offset(250, -400),
    const Offset(0, 0),
    const Offset(-250, 400),
    const Offset(250, 400),
  ],
  [
    // 1334x750
    const Offset(-200, -200),
    const Offset(200, -200),
    const Offset(0, 0),
    const Offset(-200, 200),
    const Offset(200, 200),
  ],
];

List<List<Offset>> _kyufuStartPositions = [
  [
    // 2266x1488
    const Offset(-300, -400),
    const Offset(-100, -400),
    const Offset(300, -400),
    const Offset(0, 0),
    const Offset(-300, 400),
    const Offset(0, 400),
    const Offset(300, 400),
  ],
  [
    // 2732x2048
    const Offset(-350, -300),
    const Offset(-200, -300),
    const Offset(350, -600),
    const Offset(0, 0),
    const Offset(-350, 600),
    const Offset(0, 600),
    const Offset(350, 600),
  ],
  [
    // 2796x1290
    const Offset(-250, -400),
    const Offset(0, -400),
    const Offset(250, -400),
    const Offset(0, 0),
    const Offset(-250, 400),
    const Offset(0, 400),
    const Offset(250, 400),
  ],
  [
    // 1334x750
    const Offset(-200, -200),
    const Offset(0, -200),
    const Offset(200, -200),
    const Offset(0, 0),
    const Offset(-200, 200),
    const Offset(0, 200),
    const Offset(200, 200),
  ],
];
List<Offset> getOnpuStartPositions(BuildContext context, bool type) {
  final Size size = MediaQuery.of(context).size;
  int index = getScreenSizeIndex(size);
  double scale = getScreenScaleFromSize(size);
  List<List<Offset>> positions =
      type ? _onpuStartPositions : _kyufuStartPositions;
  return positions[index].map((offset) => offset * scale).toList();
}

List<Offset> getOnpuCorrectPositions(
    BuildContext context, int level, bool type) {
  double scale = getScreenScale(context);
  List<OnpuPuzzleSetting> setting = getOnpuPuzzleSetting(context, level, type);
  List<Offset> positions = [];
  for (int i = 0; i < setting.length; i++) {
    positions.add(setting[i].offset * scale);
  }
  return positions;
}

class OnpuPieceMargin {
  final double left;
  final double top;
  final double right;
  final double bottom;

  OnpuPieceMargin({
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
  });
}

List<List<OnpuPieceMargin>> _onpuPartsMargin = [
  [
    // 2266x1488
    OnpuPieceMargin(left: 65, top: 45, right: 0, bottom: 0), // parts1
    OnpuPieceMargin(left: 70, top: 55, right: 50, bottom: 30), // parts2
    OnpuPieceMargin(left: 65, top: 30, right: 50, bottom: 35), // parts3
    OnpuPieceMargin(left: 50, top: 45, right: 50, bottom: 35), // parts4
    OnpuPieceMargin(left: 55, top: 60, right: 60, bottom: 60), // parts5
  ],
  [
    // 2732x2048
    OnpuPieceMargin(left: 65, top: 60, right: 70, bottom: 60), // parts1
    OnpuPieceMargin(left: 110, top: 60, right: 65, bottom: 70), // parts2
    OnpuPieceMargin(left: 120, top: 65, right: 70, bottom: 75), // parts3
    OnpuPieceMargin(left: 35, top: 40, right: 40, bottom: 30), // parts4
    OnpuPieceMargin(left: 60, top: 80, right: 60, bottom: 120), // parts5
  ],
  [
    // 2796x1290
    OnpuPieceMargin(left: 55, top: 35, right: 0, bottom: 0), // parts1
    OnpuPieceMargin(left: 30, top: 25, right: 25, bottom: 30), // parts2
    OnpuPieceMargin(left: 35, top: 35, right: 35, bottom: 30), // parts3
    OnpuPieceMargin(left: 20, top: 15, right: 15, bottom: 20), // parts4
    OnpuPieceMargin(left: 55, top: 35, right: 30, bottom: 35), // parts5
  ],
  [
    // 1334x750
    OnpuPieceMargin(left: 24, top: 22, right: 10, bottom: 0), // parts1
    OnpuPieceMargin(left: 10, top: 20, right: 20, bottom: 40), // parts2
    OnpuPieceMargin(left: 22, top: 22, right: 22, bottom: 20), // parts3
    OnpuPieceMargin(left: 17, top: 10, right: 12, bottom: 15), // parts4
    OnpuPieceMargin(left: 20, top: 10, right: 22, bottom: 25), // parts5
  ]
];

List<List<OnpuPieceMargin>> _kyufuPartsMargin = [
  [
    // 2266x1488
    OnpuPieceMargin(left: 80, top: 60, right: 55, bottom: 50), // parts1
    OnpuPieceMargin(left: 40, top: 40, right: 95, bottom: 85), // parts2
    OnpuPieceMargin(left: 65, top: 30, right: 95, bottom: 30), // parts3
    OnpuPieceMargin(left: 30, top: 45, right: 40, bottom: 30), // parts4
    OnpuPieceMargin(left: 40, top: 30, right: 40, bottom: 50), // parts5
    OnpuPieceMargin(left: 65, top: 35, right: 85, bottom: 40), // parts6
    OnpuPieceMargin(left: 30, top: 35, right: 65, bottom: 30), // parts7
  ],
  [
    // 2732x2048
    OnpuPieceMargin(left: 145, top: 110, right: 105, bottom: 80), // parts1
    OnpuPieceMargin(left: 215, top: 110, right: 20, bottom: 100), // parts2
    OnpuPieceMargin(left: 40, top: 90, right: 155, bottom: 45), // parts3
    OnpuPieceMargin(left: 95, top: 50, right: 70, bottom: 90), // parts4
    OnpuPieceMargin(left: 70, top: 45, right: 100, bottom: 50), // parts5
    OnpuPieceMargin(left: 180, top: 70, right: 45, bottom: 95), // parts6
    OnpuPieceMargin(left: 100, top: 50, right: 25, bottom: 95), // parts7
  ],
  [
    // 2796x1290
    OnpuPieceMargin(left: 60, top: 30, right: 67, bottom: 40), // parts1
    OnpuPieceMargin(left: 50, top: 15, right: 40, bottom: 20), // parts2
    OnpuPieceMargin(left: 52, top: 30, right: 120, bottom: 22), // parts3
    OnpuPieceMargin(left: 45, top: 25, right: 30, bottom: 60), // parts4
    OnpuPieceMargin(left: 60, top: 25, right: 20, bottom: 40), // parts5
    OnpuPieceMargin(left: 40, top: 30, right: 22, bottom: 35), // parts6
    OnpuPieceMargin(left: 27, top: 30, right: 33, bottom: 20), // parts7
  ],
  [
    // 1334x750

    OnpuPieceMargin(left: 30, top: 42, right: 30, bottom: 57), // parts1
    OnpuPieceMargin(left: 35, top: 17, right: 55, bottom: 5), // parts2
    OnpuPieceMargin(left: 47, top: 13, right: 87, bottom: 25), // parts3
    OnpuPieceMargin(left: 55, top: 30, right: 10, bottom: 68), // parts4
    OnpuPieceMargin(left: 43, top: 25, right: 33, bottom: 53), // parts5
    OnpuPieceMargin(left: 55, top: 35, right: 55, bottom: 20), // parts6
    OnpuPieceMargin(left: 17, top: 10, right: 12, bottom: 13), // parts7
  ]
];
OnpuPieceMargin getOnpuPieceMargin(BuildContext context, int index, bool type) {
  final Size size = MediaQuery.of(context).size;
  int sizeIndex = getScreenSizeIndex(size);
  double scale = getScreenScaleFromSize(size);
  List<List<OnpuPieceMargin>> margins =
      type ? _onpuPartsMargin : _kyufuPartsMargin;
  return OnpuPieceMargin(
    left: margins[sizeIndex][index].left * scale,
    top: margins[sizeIndex][index].top * scale,
    right: margins[sizeIndex][index].right * scale,
    bottom: margins[sizeIndex][index].bottom * scale,
  );
}

List<double> _onpuPuzzleCheckSizes = [96, 175, 81, 49];
double getOnpuPuzzleCheckSize(BuildContext context) {
  final Size size = MediaQuery.of(context).size;
  int index = getScreenSizeIndex(size);
  double scale = getScreenScaleFromSize(size);
  return _onpuPuzzleCheckSizes[index] * scale;
}

double getPartAngle(BuildContext context, int level, int index, bool type) {
  final Size size = MediaQuery.of(context).size;
  int screenIndex = getScreenSizeIndex(size);
  double angle = 0;
  if (type) {
    if (level != 0 && index == 1) {
      angle = -20; // 全音符の時以外は白丸の角度を変える
    }
  } else {
    if (screenIndex == 1) {
      console([screenIndex]);
      if (level != 0 && index == 1) {
        angle = 20.5; // 全休符以外の時は線の角度を変える
      } else if (level != 1 && index == 3) {
        angle = 25; // 8分休符以外の時は黒丸の角度を変える
      } else if (level != 1 && index == 2) {
        angle = 0; // 8分休符以外の時は斜め線の角度を変える
        // angle = -10; // 8分休符以外の時は斜め線の角度を変える
      }

      if (level != 2 && index == 5) {
        angle = 0;
      }
    } else {
      if (level == 0 && index == 1) {
        angle = -20.5; // 全休符の時は線の角度を変える
      } else if (level == 1 && index == 3) {
        angle = -35; // 8分休符の時は黒丸の角度を変える
      } else if (level == 1 && index == 2) {
        angle = 10; // 8分休符の時は斜め線の角度を変える
      }
    }
  }
  return angle;
}

/////////////////////////////////////////////////////////////////////////////////////////////////
// クイズ
/////////////////////////////////////////////////////////////////////////////////////////////////
List<ViewSetting> _quizButtonViewSetting = [
  ViewSetting(
    //2266x1488
    position: const Offset(250, 350),
    size: const Size(519, 860),
  ),
  ViewSetting(
    //2732x2048
    position: const Offset(200, 500),
    size: const Size(712, 1183),
  ),
  ViewSetting(
    //2796x1290
    position: const Offset(300, 300),
    size: const Size(529, 880),
  ),
  ViewSetting(
    //1334x750
    position: const Offset(50, 200),
    size: const Size(291, 483),
  ),
];
final List<double> quizButtonSpaces = [600, 800, 600, 300];

ViewSetting getQuizButtonViewSetting(BuildContext context) {
  return _getViewSetting(_quizButtonViewSetting, context);
}

List<Offset> getQuizButtonPositions(BuildContext context) {
  ViewSetting viewSetting = _getViewSetting(_quizButtonViewSetting, context);
  int index = getScreenSizeIndex(MediaQuery.of(context).size);
  double scale = getScreenScale(context);
  List<Offset> positions = [];
  for (int i = 0; i < 3; i++) {
    positions.add(
        viewSetting.position + Offset(quizButtonSpaces[index] * i * scale, 0));
  }
  return positions;
}

const int quizNum = 3;
List<String> soundButtonNames = [
  'part1',
  'part2',
  'part3',
];

String getSoundButtonName(String folderName, int index, int level) {
  return 'assets/images/$folderName/${soundButtonNames[index]}_${level + 1}.png';
}

List<List<String>> soundSettings = [
  [
    // 第1画面
    'assets/sounds/quiz/004_Ob.mp3', // オーボエ
    'assets/sounds/quiz/003_Fl.mp3', // フルート
    'assets/sounds/quiz/002_Cl.mp3', // クラリネット
  ],
  [
    // 第2画面
    'assets/sounds/quiz/005_Tp.mp3', // トランペット
    'assets/sounds/quiz/Sax.mp3', // サックス
    'assets/sounds/quiz/Tb.mp3', // トロンボーン
  ],
  [
    // 第3画面
    'assets/sounds/quiz/EGt.mp3', // エレキギター
    'assets/sounds/quiz/Gt.mp3', // ギター
    'assets/sounds/quiz/006_Dr.mp3', // ドラム
  ],
  [
    // 第4画面
    'assets/sounds/quiz/001_Vl_b.mp3', // バイオリン
    'assets/sounds/quiz/Cb.mp3', // コントラバス
    'assets/sounds/quiz/007_Vc.mp3', // チェロ
  ],
  [
    // 第5画面
    'assets/sounds/quiz/Cast.mp3', // カスタネット
    'assets/sounds/quiz/Tri.mp3', // トライアングル
    'assets/sounds/quiz/Tamb.mp3', // タンバリン
  ],
  [
    // 第6画面
    'assets/sounds/quiz/009_Glock.mp3', // グロッケン
    'assets/sounds/quiz/Vib.mp3', // ヴィブラフォン
    'assets/sounds/quiz/Mar.mp3', // マリンバ
  ],
  [
    // 第7画面
    'assets/sounds/quiz/011_Agogo.mp3', // アゴゴ
    'assets/sounds/quiz/Conga.mp3', // コンガ
    'assets/sounds/quiz/013_Claves.mp3', // クラベス
  ],
  [
    // 第8画面
    'assets/sounds/quiz/015_Maracas.mp3', // マラカス
    'assets/sounds/quiz/012_Guiro.mp3', // ギロ
    'assets/sounds/quiz/014_Cowbell.mp3', // カウベル
  ],
  [
    // 第9画面
    'assets/sounds/quiz/008_Pf.mp3', // ピアノ
    'assets/sounds/quiz/Org.mp3', // パイプオルガン
    'assets/sounds/quiz/010_Koto.mp3', // 琴
  ],
];

List<ViewSetting> _quizStartButtonViewSettings = [
  ViewSetting(
    //2266x1488
    position: const Offset(700, 1280),
    size: const Size(342, 126),
  ),
  ViewSetting(
    //2732x2048
    position: const Offset(800, 1770),
    size: const Size(471, 173),
  ),
  ViewSetting(
    //2796x1290
    position: const Offset(2200, 800),
    size: const Size(399, 146),
  ),
  ViewSetting(
    //1334x750
    position: const Offset(1000, 440),
    size: const Size(232, 86),
  ),
];

ViewSetting getStartButtonViewSetting(BuildContext context) {
  return _getViewSetting(_quizStartButtonViewSettings, context);
}

List<ViewSetting> _quizNextButtonViewSettings = [
  ViewSetting(
    //2266x1488
    position: const Offset(1200, 1292),
    size: const Size(340, 114),
  ),
  ViewSetting(
    //2732x2048
    position: const Offset(1500, 1786),
    size: const Size(468, 157),
  ),
  ViewSetting(
    //2796x1290
    position: const Offset(2200, 1000),
    size: const Size(397, 133),
  ),
  ViewSetting(
    //1334x750
    position: const Offset(1000, 550),
    size: const Size(231, 77),
  ),
];

ViewSetting getNextButtonViewSetting(BuildContext context) {
  return _getViewSetting(_quizNextButtonViewSettings, context);
}
