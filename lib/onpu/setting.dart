import 'package:flutter/material.dart';

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

class ViewSetting {
  Offset position;
  Size size;

  ViewSetting({required this.position, required this.size});
}

ViewSetting getViewSetting(
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

List<Size> _completeViewSizes = [
  Size(1612 * 0.6, 624 * 0.6),
  Size(1612 * 0.6, 624 * 0.6),
  Size(1612 * 0.6, 624 * 0.6),
  Size(1612 * 0.6, 624 * 0.6),
];

Size getCompleteSize(BuildContext context) {
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

    scale *= imageScale;
  }
  return _completeViewSizes[index] * scale;
}

/////////////////////////////////////////////////////////////////////////////////////////////////
// OnpuGame1
/////////////////////////////////////////////////////////////////////////////////////////////////

List<String> _onpu1BGImageName = [
  'do.png',
  're.png',
  'mi.png',
  'fa.png',
  'so.png',
  'la.png',
  'ti.png',
];

String getBackGroundImageName(String folderName, int soundIdx) {
  return 'assets/images/$folderName/OnpuGame1/${_onpu1BGImageName[soundIdx]}';
}

class FlashCardSetting {
  int index;
  String imageName;
  int soundIdx;

  FlashCardSetting(
      {required this.index, required this.imageName, required this.soundIdx});
}

List<FlashCardSetting> flashCardSettings = [
  FlashCardSetting(index: 0, imageName: "gakufu_do.png", soundIdx: 0),
  FlashCardSetting(index: 1, imageName: "gakufu_re.png", soundIdx: 1),
  FlashCardSetting(index: 2, imageName: "gakufu_mi.png", soundIdx: 2),
  FlashCardSetting(index: 3, imageName: "gakufu_fa.png", soundIdx: 3),
  FlashCardSetting(index: 4, imageName: "gakufu_so.png", soundIdx: 4),
  FlashCardSetting(index: 5, imageName: "gakufu_la.png", soundIdx: 5),
  FlashCardSetting(index: 6, imageName: "gakufu_ti.png", soundIdx: 6),
  // FlashCardSetting(index: 7, imageName: "gakufu_hdo.png", soundIdx: 0),
  FlashCardSetting(index: 7, imageName: "gakufu_hdo.png", soundIdx: 7),
];

String getFlashCardImageName(String folderName, int soundIdx, bool folderType) {
  String soundFolder = folderType ? 'To' : 'He';
  return 'assets/images/$folderName/OnpuGame1/$soundFolder/${flashCardSettings[soundIdx].imageName}';
}

List<ViewSetting> _flashCardViewSettings = [
  ViewSetting(
      position: const Offset(300, 320),
      size: const Size(1018, 837)), //2266x1488
  ViewSetting(
      position: const Offset(200, 450),
      size: const Size(1324, 1088)), //2732x2048
  ViewSetting(
      position: const Offset(220, 300), size: const Size(967, 795)), //2796x1290
  ViewSetting(
      position: const Offset(90, 170), size: const Size(561, 461)), //1334x750
];

ViewSetting getFlashCardsViewSetting(BuildContext context) {
  return getViewSetting(_flashCardViewSettings, context);
}

List<ViewSetting> _onpu1CharaButtonViewSettings = [
  ViewSetting(
      position: const Offset(1420, 510),
      size: const Size(520, 560)), //2266x1488
  ViewSetting(
      position: const Offset(1760, 700),
      size: const Size(720, 770)), //2732x2048
  ViewSetting(
      position: const Offset(1315, 455),
      size: const Size(540, 580)), //2796x1290
  ViewSetting(
      position: const Offset(665, 270), size: const Size(310, 330)), //1334x750
];

ViewSetting getOnpu1CharaButtonViewSetting(BuildContext context) {
  return getViewSetting(_onpu1CharaButtonViewSettings, context);
}

List<ViewSetting> _onpu1NextButtonViewSettings = [
  ViewSetting(
      position: const Offset(1120, 1192),
      size: const Size(343, 115)), //2266x1488
  ViewSetting(
      position: const Offset(1350, 1614),
      size: const Size(468, 157)), //2732x2048
  ViewSetting(
      position: const Offset(2100, 1000),
      size: const Size(495, 166)), //2796x1290
  ViewSetting(
      position: const Offset(1050, 600), size: const Size(244, 81)), //1334x750
];

ViewSetting getOnpu1NextButtonViewSetting(BuildContext context) {
  return getViewSetting(_onpu1NextButtonViewSettings, context);
}

List<ViewSetting> _onpu1CarButtonViewSettings = [
  ViewSetting(
      position: const Offset(640, 1180),
      size: const Size(343, 127)), //2266x1488
  ViewSetting(
      position: const Offset(700, 1600),
      size: const Size(471, 173)), //2732x2048
  ViewSetting(
      position: const Offset(2100, 700),
      size: const Size(499, 183)), //2796x1290
  ViewSetting(
      position: const Offset(1050, 470), size: const Size(244, 90)), //1334x750
];

ViewSetting getOnpu1CarButtonViewSetting(BuildContext context) {
  return getViewSetting(_onpu1CarButtonViewSettings, context);
}

List<ViewSetting> _onpu1PlaneButtonViewSettings = [
  ViewSetting(
      position: const Offset(1120, 1192),
      size: const Size(343, 115)), //2266x1488
  ViewSetting(
      position: const Offset(1350, 1615),
      size: const Size(471, 158)), //2732x2048
  ViewSetting(
      position: const Offset(2100, 1000),
      size: const Size(499, 167)), //2796x1290
  ViewSetting(
      position: const Offset(1050, 600), size: const Size(244, 82)), //1334x750
];

ViewSetting getOnpu1PlaneButtonViewSetting(BuildContext context) {
  return getViewSetting(_onpu1PlaneButtonViewSettings, context);
}

/////////////////////////////////////////////////////////////////////////////////////////////////
// OnpuGame2
/////////////////////////////////////////////////////////////////////////////////////////////////
class OnpuKeyboardSetting {
  bool image = false;
  String? imageName;
  final int index;
  Offset position = Offset.zero;

  OnpuKeyboardSetting({
    required this.image,
    this.imageName,
    required this.index,
    required this.position,
  });
}

const List<Size> _onpuIconSize = [
  Size(195, 212), // 2266x1488
  Size(269, 289), // 2732x2048
  Size(169, 184), // 2796x1290
  Size(99, 107), // 1334x750
];

List<Offset> _onpuIconStartPos = [
  Offset(280, 1130), // 2266x1488
  Offset(220, 1570), // 2732x2048
  Offset(690, 1000), // 2796x1290
  Offset(245, 570), // 1334x750
];
List<double> _onpuIconSpace = [
  250, // 2266x1488
  340, // 2732x2048
  210, // 2796x1290
  125, // 1334x750
];

const List<List<Size>> _onpuKenbanSize = [
  [
    // 2266x1488
    Size(122, 431), // do
    Size(118, 431), // re
    Size(118, 431), // mi
    Size(119, 431), // fa
    Size(117, 431), // so
    Size(118, 431), // la
    Size(118, 431), // ti
    Size(118, 431), // hdo
    Size(122, 431), // hre
  ],
  [
    // 2732x2048
    Size(167, 592), // do
    Size(161, 592), // re
    Size(161, 592), // mi
    Size(162, 592), // fa
    Size(160, 592), // so
    Size(161, 592), // la
    Size(161, 592), // ti
    Size(161, 592), // hdo
    Size(166, 592), // hre
  ],
  [
    // 2796x1290
    Size(152, 540), // do
    Size(147, 540), // re
    Size(147, 540), // mi
    Size(147, 540), // fa
    Size(146, 540), // so
    Size(147, 540), // la
    Size(147, 540), // ti
    Size(147, 540), // hdo
    Size(151, 540), // hre
  ],
  [
    // 1334x750
    Size(89, 315), // do
    Size(86, 315), // re
    Size(87, 315), // mi
    Size(86, 315), // fa
    Size(86, 315), // so
    Size(86, 315), // la
    Size(87, 315), // ti
    Size(86, 315), // hdo
    Size(89, 315), // hre
  ]
];
List<Offset> _onpuKenbanStartPos = [
  Offset(650, 930), // 2266x1488
  Offset(670, 1270), // 2732x2048
  Offset(1200, 420), // 2796x1290
  Offset(500, 250), // 1334x750
];

List<OnpuKeyboardSetting> getOnpuIconSetting(BuildContext context) {
  final String folderName = getSizeFolderName(context);
  final int index = getScreenSizeIndex(MediaQuery.of(context).size);
  final double scale = getScreenScale(context);
  List<OnpuKeyboardSetting> onpuKeyboardSetting = [];
  for (int i = 0; i < 7; i++) {
    onpuKeyboardSetting.add(OnpuKeyboardSetting(
      image: true,
      imageName:
          'assets/images/$folderName/OnpuGame2/Icon/${_onpu1BGImageName[i]}',
      index: i,
      position: _onpuIconStartPos[index] * scale +
          Offset(_onpuIconSpace[index] * i * scale, 0),
    ));
  }
  return onpuKeyboardSetting;
}

Size getOnpuIconSize(BuildContext context) {
  final int index = getScreenSizeIndex(MediaQuery.of(context).size);
  return _onpuIconSize[index] * getScreenScale(context);
}

Size getKenbanSize(BuildContext context, int soundIdx) {
  final int index = getScreenSizeIndex(MediaQuery.of(context).size);
  return _onpuKenbanSize[index][soundIdx] * getScreenScale(context);
}

List<OnpuKeyboardSetting> getOnpuKenbanSetting(BuildContext context) {
  final String folderName = getSizeFolderName(context);
  final int index = getScreenSizeIndex(MediaQuery.of(context).size);
  final double scale = getScreenScale(context);
  List<OnpuKeyboardSetting> onpuKeyboardSetting = [];
  Offset position = _onpuKenbanStartPos[index] * scale;
  for (int i = 0; i < 7; i++) {
    onpuKeyboardSetting.add(OnpuKeyboardSetting(
      image: true,
      imageName:
          'assets/images/$folderName/OnpuGame2/Kenban/${_onpu1BGImageName[i]}',
      index: i,
      position: position,
    ));
    Size kenbanSize = getKenbanSize(context, i);
    position += Offset(kenbanSize.width - 1 * scale, 0);
  }
  onpuKeyboardSetting.add(OnpuKeyboardSetting(
    image: true,
    imageName: 'assets/images/$folderName/OnpuGame2/Kenban/hdo.png',
    index: 7,
    position: position,
  ));
  Size kenbanSize = getKenbanSize(context, 7);
  position += Offset(kenbanSize.width - 1 * scale, 0);
  onpuKeyboardSetting.add(OnpuKeyboardSetting(
    image: true,
    imageName: 'assets/images/$folderName/OnpuGame2/Kenban/hre.png',
    index: 8,
    position: position,
  ));

  return onpuKeyboardSetting;
}

class OnpuQuestionSetting {
  final int index;
  final int correctIdx;
  final String imageName;

  OnpuQuestionSetting({
    required this.index,
    required this.correctIdx,
    required this.imageName,
  });
}

List<OnpuQuestionSetting> onpuIconQuestions = [
  OnpuQuestionSetting(index: 0, correctIdx: 0, imageName: "gakufu_do.png"),
  OnpuQuestionSetting(index: 1, correctIdx: 1, imageName: "gakufu_re.png"),
  OnpuQuestionSetting(index: 2, correctIdx: 2, imageName: "gakufu_mi.png"),
  OnpuQuestionSetting(index: 3, correctIdx: 3, imageName: "gakufu_fa.png"),
  OnpuQuestionSetting(index: 4, correctIdx: 4, imageName: "gakufu_so.png"),
  OnpuQuestionSetting(index: 5, correctIdx: 5, imageName: "gakufu_la.png"),
  OnpuQuestionSetting(index: 6, correctIdx: 6, imageName: "gakufu_ti.png"),
  OnpuQuestionSetting(index: 7, correctIdx: 0, imageName: "gakufu_hdo.png"),
];

List<OnpuQuestionSetting> onpuKenbanQuestions = [
  OnpuQuestionSetting(index: 0, correctIdx: 0, imageName: "gakufu_do.png"),
  OnpuQuestionSetting(index: 1, correctIdx: 1, imageName: "gakufu_re.png"),
  OnpuQuestionSetting(index: 2, correctIdx: 2, imageName: "gakufu_mi.png"),
  OnpuQuestionSetting(index: 3, correctIdx: 3, imageName: "gakufu_fa.png"),
  OnpuQuestionSetting(index: 4, correctIdx: 4, imageName: "gakufu_so.png"),
  OnpuQuestionSetting(index: 5, correctIdx: 5, imageName: "gakufu_la.png"),
  OnpuQuestionSetting(index: 6, correctIdx: 6, imageName: "gakufu_ti.png"),
  OnpuQuestionSetting(index: 7, correctIdx: 7, imageName: "gakufu_hdo.png"),
];
List<ViewSetting> _onpu2IconGakufuViewSettings = [
  ViewSetting(
    // 2266x1488
    position: const Offset(400, 290),
    size: const Size(1018, 837),
  ),
  ViewSetting(
    // 2732x2048
    position: const Offset(300, 450),
    size: const Size(1324, 1088),
  ),
  ViewSetting(
    // 2796x1290
    position: const Offset(700, 250),
    size: const Size(967, 795),
  ),
  ViewSetting(
    // 1334x750
    position: const Offset(230, 140),
    size: const Size(561, 461),
  ),
];

List<ViewSetting> _onpu2KenbanGakufuViewSettings = [
  ViewSetting(
    // 2266x1488
    position: const Offset(750, 250),
    size: const Size(1018, 837) * 0.8,
  ),
  ViewSetting(
    // 2732x2048
    position: const Offset(750, 350),
    size: const Size(1324, 1088) * 0.85,
  ),
  ViewSetting(
    // 2796x1290
    position: const Offset(200, 300),
    size: const Size(967, 795),
  ),
  ViewSetting(
    // 1334x750
    position: const Offset(10, 200),
    size: const Size(561, 461) * 0.9,
  ),
];

ViewSetting getOnpu2GakufuViewSetting(BuildContext context, bool type) {
  return getViewSetting(
      type ? _onpu2KenbanGakufuViewSettings : _onpu2IconGakufuViewSettings,
      context);
}

String getOnpu2GakufuName(
    String folder, int index, bool soundType, bool folderType) {
  String soundFolder = soundType ? 'To' : 'He';
  return 'assets/images/$folder/OnpuGame2/$soundFolder/${onpuIconQuestions[index].imageName}';
}

List<ViewSetting> _onpu2IconStartButtonViewSettings = [
  ViewSetting(
    // 2266x1488
    position: const Offset(1500, 790),
    size: const Size(343, 127),
  ),
  ViewSetting(
    // 2732x2048
    position: const Offset(1850, 1100),
    size: const Size(471, 173),
  ),
  ViewSetting(
    // 2796x1290
    position: const Offset(1650, 700),
    size: const Size(499, 183),
  ),
  ViewSetting(
    // 1334x750
    position: const Offset(800, 370),
    size: const Size(244, 90),
  ),
];

List<ViewSetting> _onpu2KenbanStartButtonViewSettings = [
  ViewSetting(
    // 2266x1488
    position: const Offset(1600, 750),
    size: const Size(342, 126),
  ),
  ViewSetting(
    // 2732x2048
    position: const Offset(2050, 1050),
    size: const Size(471, 173),
  ),
  ViewSetting(
    // 2796x1290
    position: const Offset(2110, 990),
    size: const Size(429, 158),
  ),
  ViewSetting(
    // 1334x750
    position: const Offset(1030, 570),
    size: const Size(249, 92),
  ),
];
ViewSetting getOnpu2StartButtonViewSetting(BuildContext context, bool type) {
  return getViewSetting(
      type
          ? _onpu2KenbanStartButtonViewSettings
          : _onpu2IconStartButtonViewSettings,
      context);
}

/////////////////////////////////////////////////////////////////////////////////////////////////
// 線と間A
/////////////////////////////////////////////////////////////////////////////////////////////////
class StickerViewSetting {
  final List<Offset> positions;
  final List<Size> size;

  StickerViewSetting({
    required this.positions,
    required this.size,
  });
}

final int spaceStickerPatternNum = 5;
List<List<Offset>> _spaceStickerPositions = [
  [
    // 2266x1488
    Offset(550, 1170),
    Offset(1150, 1170),
    Offset(1450, 1170),
    Offset(1750, 1170),
  ],
  [
    // 2732x2048
    Offset(850, 1570),
    Offset(1550, 1570),
    Offset(1850, 1570),
    Offset(2150, 1570),
  ],
  [
    // 2796x1290
    Offset(800, 980),
    Offset(1350, 980),
    Offset(1650, 980),
    Offset(1950, 980),
  ],
  [
    // 1334x750
    Offset(350, 575),
    Offset(650, 575),
    Offset(800, 575),
    Offset(950, 575),
  ],
];

List<List<Size>> _spaceStickerSizes = [
  [
    // 2266x1488
    const Size(141, 115), // Onigiri
    const Size(141, 113), // Coffee
    const Size(95, 102), // GreenPepper
    const Size(103, 99), // Star
    const Size(165, 119), // Ribbon
  ],
  [
    // 2732x2048
    const Size(188, 163), // Onigiri
    const Size(178, 133), // Coffee
    const Size(188, 163), // GreenPepper
    const Size(139, 131), // Star
    const Size(230, 147), // Ribbon
  ],
  [
    // 2796x1290
    const Size(123, 100), // Onigiri
    const Size(131, 100), // Coffee
    const Size(90, 97), // GreenPepper
    const Size(95, 90), // Star
    const Size(160, 100), // Ribbon
  ],
  [
    // 1334x750
    const Size(77, 63), // Onigiri
    const Size(75, 56), // Coffee
    const Size(63, 67), // GreenPepper
    const Size(63, 63), // Star
    const Size(96, 62), // Ribbon
  ],
];

List<ViewSetting> _lineSpaceASpaceGakufuSettings = [
  ViewSetting(
      position: const Offset(545, 580),
      size: const Size(1490, 122)), //2266x1488
  ViewSetting(
      position: const Offset(755, 815),
      size: const Size(1530, 150)), //2732x2048
  ViewSetting(
      position: const Offset(715, 490),
      size: const Size(1585, 110)), //2796x1290
  ViewSetting(
      position: const Offset(325, 280), size: const Size(880, 65)), //1334x750
];
List<List<Offset>> _lineStickerPositions = [
  [
    // 2266x1488
    Offset(550, 1100),
    Offset(850, 1100),
    Offset(1150, 1100),
    Offset(1450, 1100),
    Offset(1750, 1100),
  ],
  [
    // 2732x2048
    Offset(800, 1570),
    Offset(1100, 1570),
    Offset(1400, 1570),
    Offset(1700, 1570),
    Offset(2000, 1570),
  ],
  [
    // 2796x1290
    Offset(2450, 100),
    Offset(2450, 300),
    Offset(2450, 500),
    Offset(2450, 700),
    Offset(2450, 900),
  ],
  [
    // 1334x750
    Offset(1050, 50),
    Offset(1150, 150),
    Offset(1050, 250),
    Offset(1150, 350),
    Offset(1050, 450),
  ],
];

List<List<List<Size>>> _lineStickerSizes = [
  [
    // 2266x1488
    [
      const Size(122, 159), // Strawberry
    ],
    [
      const Size(222, 108), // Car
      const Size(242, 121),
      const Size(216, 113),
      const Size(235, 133),
    ],
    [
      const Size(268, 200), // Helicopter
    ],
    [
      const Size(162, 162), // Ball
    ],
    [
      const Size(172, 171), // Lease
    ]
  ],
  [
    // 2732x2048
    [
      const Size(161, 210), // Strawberry
    ],
    [
      const Size(269, 161), // Car
    ],
    [
      const Size(356, 265), // Helicopter
    ],
    [
      const Size(213, 213), // Ball
    ],
    [
      const Size(269, 267), // Lease
    ]
  ],
  [
    // 2796x1290
    [
      const Size(135, 178), // Strawberry
    ],
    [
      const Size(292, 142), // Car
      const Size(296, 148),
      const Size(272, 143),
      const Size(295, 167),
    ],
    [
      const Size(309, 230), // Helicopter
    ],
    [
      const Size(171, 171), // Ball
    ],
    [
      const Size(181, 180), // Lease
    ]
  ],
  [
    // 1334x750
    [
      const Size(94, 124), // Strawberry
    ],
    [
      const Size(170, 83), // Car
      const Size(172, 86),
      const Size(158, 83),
      const Size(171, 97),
    ],
    [
      const Size(215, 160), // Helicopter
    ],
    [
      const Size(119, 119), // Ball
    ],
    [
      const Size(126, 125), // Lease
    ]
  ]
];

List<ViewSetting> _lineSpaceALineGakufuSettings = [
  ViewSetting(
      position: const Offset(620, 585),
      size: const Size(1465, 116)), //2266x1488
  ViewSetting(
      position: const Offset(790, 810),
      size: const Size(1500, 158)), //2732x2048
  ViewSetting(
      position: const Offset(615, 440),
      size: const Size(1625, 173)), //2796x1290
  ViewSetting(
      position: const Offset(360, 255), size: const Size(675, 100)), //1334x750
];

List<Offset> getFiveLineAPosition(BuildContext context, bool type) {
  final int index = getScreenSizeIndex(MediaQuery.of(context).size);
  final double scale = getScreenScale(context);
  List<Offset> fiveLineAPositions = [];
  List<ViewSetting> gakufuViewSettings =
      type ? _lineSpaceALineGakufuSettings : _lineSpaceASpaceGakufuSettings;
  for (int i = 0; i < 5; i++) {
    fiveLineAPositions.add((gakufuViewSettings[index].position +
            (Offset(0, gakufuViewSettings[index].size.height * i))) *
        scale);
  }
  return fiveLineAPositions;
}

ViewSetting getFiveLineAViewSetting(BuildContext context, bool type) {
  List<ViewSetting> gakufuViewSettings =
      type ? _lineSpaceALineGakufuSettings : _lineSpaceASpaceGakufuSettings;
  return getViewSetting(gakufuViewSettings, context);
}

List<Offset> getStickerPositions(BuildContext context, bool type) {
  int index = getScreenSizeIndex(MediaQuery.of(context).size);
  double scale = getScreenScale(context);
  return type
      ? _lineStickerPositions[index]
          .map((position) => position * scale)
          .toList()
      : _spaceStickerPositions[index]
          .map((position) => position * scale)
          .toList();
}

Size getStickerSize(BuildContext context, bool type, int level, int partIndex) {
  int index = getScreenSizeIndex(MediaQuery.of(context).size);
  double scale = getScreenScale(context);
  if (type) {
    if (partIndex >= _lineStickerSizes[index][level].length) {
      partIndex = 0;
    }
  }
  return type
      ? _lineStickerSizes[index][level][partIndex] * scale
      : _spaceStickerSizes[index][level] * scale;
}

ViewSetting getLineSpaceAGakufuSetting(BuildContext context, bool type) {
  List<ViewSetting> gakufuViewSettings =
      type ? _lineSpaceALineGakufuSettings : _lineSpaceASpaceGakufuSettings;
  return getViewSetting(gakufuViewSettings, context);
}

List<String> _lineSpaceASpaceLevelFolderNames = [
  'Onigiri',
  'Coffee',
  'GreenPepper',
  'Star',
  'Ribbon',
];

List<List<String>> _lineSpaceASpacePartsNames = [
  ['part.png', 'part.png', 'part.png', 'part.png'],
  ['part.png', 'part.png', 'part.png', 'part.png'],
  ['part1.png', 'part2.png', 'part3.png', 'part4.png'],
  ['part1.png', 'part2.png', 'part3.png', 'part1.png'],
  ['part1.png', 'part2.png', 'part3.png', 'part4.png'],
];

List<String> _lineSpaceALineLevelFolderNames = [
  'Strawberry',
  'Car',
  'Helicopter',
  'Ball',
  'Lease',
];

List<List<String>> _lineSpaceALinePartsNames = [
  ['part.png', 'part.png', 'part.png', 'part.png', 'part.png'],
  ['part1.png', 'part2.png', 'part3.png', 'part4.png', 'part1.png'],
  ['part.png', 'part.png', 'part.png', 'part.png', 'part.png'],
  ['part.png', 'part.png', 'part.png', 'part.png', 'part.png'],
  ['part.png', 'part.png', 'part.png', 'part.png', 'part.png'],
];

String getLineSpaceABGImageName(String folderName, int level, bool type) {
  String typeFolderName = type ? 'Line' : 'Space';
  String levelFolderName = type
      ? _lineSpaceALineLevelFolderNames[level]
      : _lineSpaceASpaceLevelFolderNames[level];
  return 'assets/images/$folderName/LineSpaceA/$typeFolderName/$levelFolderName/bg.png';
}

String getLineSpaceAPartName(
    BuildContext context, int level, int partIndex, bool type) {
  int index = getScreenSizeIndex(MediaQuery.of(context).size);
  String sizeFolderName = _folderNames[index];
  String folderName = type
      ? _lineSpaceALineLevelFolderNames[level]
      : _lineSpaceASpaceLevelFolderNames[level];
  String typeFolderName = type ? 'Line' : 'Space';
  String imageName = type
      ? _lineSpaceALinePartsNames[level][partIndex]
      : _lineSpaceASpacePartsNames[level][partIndex];
  return 'assets/images/$sizeFolderName/LineSpaceA/$typeFolderName/$folderName/$imageName';
}

List<ViewSetting> _lineSpaceASpaceNextButtonViewSettings = [
  // 2266x1488
  ViewSetting(
    position: const Offset(1900, 1352),
    size: const Size(343, 115),
  ),
  // 2732x2048
  ViewSetting(
    position: const Offset(2220, 1816),
    size: const Size(468, 157),
  ),
  // 2796x1290
  ViewSetting(
    position: const Offset(2280, 1107),
    size: const Size(495, 166),
  ),
  // 1334x750
  ViewSetting(
    position: const Offset(1080, 659),
    size: const Size(244, 81),
  ),
];

List<ViewSetting> _lineSpaceALineNextButtonViewSettings = [
  // 2266x1488
  ViewSetting(
    position: const Offset(1700, 1312),
    size: const Size(343, 115),
  ),
  // 2732x2048
  ViewSetting(
    position: const Offset(2220, 1816),
    size: const Size(468, 157),
  ),
  // 2796x1290
  ViewSetting(
    position: const Offset(2280, 1087),
    size: const Size(495, 166),
  ),
  // 1334x750
  ViewSetting(
    position: const Offset(1070, 629),
    size: const Size(244, 81),
  ),
];

ViewSetting getLineSpaceANextButtonViewSetting(
    BuildContext context, bool type) {
  return getViewSetting(
      type
          ? _lineSpaceALineNextButtonViewSettings
          : _lineSpaceASpaceNextButtonViewSettings,
      context);
}

String getLineSpaceANextButtonImageName(BuildContext context) {
  String sizeFolderName = getSizeFolderName(context);
  return 'assets/images/$sizeFolderName/LineSpaceA/next.jpg';
}

List<ViewSetting> _lineSpaceASpaceStartButtonViewSettings = [
  // 2266x1488
  ViewSetting(
    position: const Offset(950, 1340),
    size: const Size(343, 127),
  ),
  // 2732x2048
  ViewSetting(
    position: const Offset(1400, 1800),
    size: const Size(471, 173),
  ),
  // 2796x1290
  ViewSetting(
    position: const Offset(1130, 1090),
    size: const Size(499, 183),
  ),
  // 1334x750
  ViewSetting(
    position: const Offset(500, 650),
    size: const Size(244, 90),
  ),
];

List<ViewSetting> _lineSpaceALineStartButtonViewSettings = [
  // 2266x1488
  ViewSetting(
    position: const Offset(950, 1300),
    size: const Size(343, 127),
  ),
  // 2732x2048
  ViewSetting(
    position: const Offset(1400, 1800),
    size: const Size(471, 173),
  ),
  // 2796x1290
  ViewSetting(
    position: const Offset(2280, 1070),
    size: const Size(499, 183),
  ),
  // 1334x750
  ViewSetting(
    position: const Offset(1070, 620),
    size: const Size(244, 90),
  ),
];

ViewSetting getLineSpaceAStartButtonViewSetting(
    BuildContext context, bool type) {
  return getViewSetting(
      type
          ? _lineSpaceALineStartButtonViewSettings
          : _lineSpaceASpaceStartButtonViewSettings,
      context);
}

String getLineSpaceAStartButtonImageName(BuildContext context) {
  String sizeFolderName = getSizeFolderName(context);
  return 'assets/images/$sizeFolderName/LineSpaceA/start_car.png';
}

/////////////////////////////////////////////////////////////////////////////////////////////////
// 線と間B
/////////////////////////////////////////////////////////////////////////////////////////////////
class LineSpaceButtonSetting {
  final int index;
  final bool type;
  final Offset position;

  LineSpaceButtonSetting({
    required this.index,
    required this.type,
    required this.position,
  });
}

// [ToDo]デバッグ用の位置&問題なので画像が来たら要修正
List<List<List<LineSpaceButtonSetting>>> _lineSpaceBButtonSettings = [
  [
    // 2266x1488
    [
      // イチゴ
      LineSpaceButtonSetting(
          index: 0, type: false, position: const Offset(800, 700)),
      LineSpaceButtonSetting(
          index: 1, type: true, position: const Offset(1050, 880)),
      LineSpaceButtonSetting(
          index: 2, type: true, position: const Offset(1300, 530)),
      LineSpaceButtonSetting(
          index: 3, type: false, position: const Offset(1500, 820)),
      LineSpaceButtonSetting(
          index: 4, type: false, position: const Offset(1700, 590)),
      LineSpaceButtonSetting(
          index: 5, type: false, position: const Offset(1900, 940)),
    ],
    [
      // クルマ(4種)
      LineSpaceButtonSetting(
          index: 0, type: false, position: const Offset(650, 940)),
      LineSpaceButtonSetting(
          index: 1, type: true, position: const Offset(950, 850)),
      LineSpaceButtonSetting(
          index: 2, type: false, position: const Offset(1550, 700)),
      LineSpaceButtonSetting(
          index: 3, type: true, position: const Offset(1250, 730)),
      LineSpaceButtonSetting(
          index: 4, type: false, position: const Offset(1800, 570)),
    ],
    [
      // ヘリコプター
      LineSpaceButtonSetting(
          index: 0, type: false, position: const Offset(650, 825)),
      LineSpaceButtonSetting(
          index: 1, type: true, position: const Offset(950, 760)),
      LineSpaceButtonSetting(
          index: 2, type: false, position: const Offset(1250, 595)),
      LineSpaceButtonSetting(
          index: 3, type: false, position: const Offset(1550, 710)),
      LineSpaceButtonSetting(
          index: 4, type: true, position: const Offset(1800, 1000)),
    ],
    [
      // ボール
      LineSpaceButtonSetting(
          index: 0, type: false, position: const Offset(700, 705)),
      LineSpaceButtonSetting(
          index: 1, type: true, position: const Offset(950, 650)),
      LineSpaceButtonSetting(
          index: 2, type: false, position: const Offset(1150, 940)),
      LineSpaceButtonSetting(
          index: 3, type: true, position: const Offset(1400, 760)),
      LineSpaceButtonSetting(
          index: 4, type: false, position: const Offset(1750, 820)),
      LineSpaceButtonSetting(
          index: 5, type: true, position: const Offset(1950, 530)),
    ],
    [
      // リース
      LineSpaceButtonSetting(
          index: 0, type: true, position: const Offset(700, 650)),
      LineSpaceButtonSetting(
          index: 1, type: false, position: const Offset(900, 820)),
      LineSpaceButtonSetting(
          index: 2, type: true, position: const Offset(1150, 760)),
      LineSpaceButtonSetting(
          index: 3, type: true, position: const Offset(1400, 1000)),
      LineSpaceButtonSetting(
          index: 4, type: false, position: const Offset(1600, 590)),
      LineSpaceButtonSetting(
          index: 5, type: false, position: const Offset(1850, 940)),
    ]
  ],
  [
    // 2732x2048
    [
      // イチゴ
      LineSpaceButtonSetting(
          index: 0, type: false, position: const Offset(1000, 950)),
      LineSpaceButtonSetting(
          index: 1, type: true, position: const Offset(1250, 1200)),
      LineSpaceButtonSetting(
          index: 2, type: true, position: const Offset(1550, 730)),
      LineSpaceButtonSetting(
          index: 3, type: false, position: const Offset(1700, 1110)),
      LineSpaceButtonSetting(
          index: 4, type: false, position: const Offset(1900, 790)),
      LineSpaceButtonSetting(
          index: 5, type: false, position: const Offset(2100, 1270)),
    ],
    [
      // クルマ(4種)
      LineSpaceButtonSetting(
          index: 0, type: false, position: const Offset(800, 1280)),
      LineSpaceButtonSetting(
          index: 1, type: true, position: const Offset(1130, 1190)),
      LineSpaceButtonSetting(
          index: 2, type: false, position: const Offset(1730, 970)),
      LineSpaceButtonSetting(
          index: 3, type: true, position: const Offset(1400, 1030)),
      LineSpaceButtonSetting(
          index: 4, type: false, position: const Offset(1970, 800)),
    ],
    [
      // ヘリコプター
      LineSpaceButtonSetting(
          index: 0, type: false, position: const Offset(800, 1140)),
      LineSpaceButtonSetting(
          index: 1, type: true, position: const Offset(1120, 1060)),
      LineSpaceButtonSetting(
          index: 2, type: false, position: const Offset(1400, 820)),
      LineSpaceButtonSetting(
          index: 3, type: false, position: const Offset(1700, 980)),
      LineSpaceButtonSetting(
          index: 4, type: true, position: const Offset(1970, 1370)),
    ],
    [
      // ボール
      LineSpaceButtonSetting(
          index: 0, type: false, position: const Offset(900, 975)),
      LineSpaceButtonSetting(
          index: 1, type: true, position: const Offset(1200, 900)),
      LineSpaceButtonSetting(
          index: 2, type: false, position: const Offset(1400, 1295)),
      LineSpaceButtonSetting(
          index: 3, type: true, position: const Offset(1600, 1050)),
      LineSpaceButtonSetting(
          index: 4, type: false, position: const Offset(1950, 1135)),
      LineSpaceButtonSetting(
          index: 5, type: true, position: const Offset(2100, 730)),
    ],
    [
      // リース
      LineSpaceButtonSetting(
          index: 0, type: true, position: const Offset(900, 890)),
      LineSpaceButtonSetting(
          index: 1, type: false, position: const Offset(1120, 1140)),
      LineSpaceButtonSetting(
          index: 2, type: true, position: const Offset(1400, 1050)),
      LineSpaceButtonSetting(
          index: 3, type: true, position: const Offset(1600, 1370)),
      LineSpaceButtonSetting(
          index: 4, type: false, position: const Offset(1800, 810)),
      LineSpaceButtonSetting(
          index: 5, type: false, position: const Offset(2000, 1300)),
    ]
  ],
  [
    // 2796x1290
    [
      // イチゴ
      LineSpaceButtonSetting(
          index: 0, type: false, position: const Offset(800, 600)),
      LineSpaceButtonSetting(
          index: 1, type: true, position: const Offset(1000, 850)),
      LineSpaceButtonSetting(
          index: 2, type: true, position: const Offset(1300, 350)),
      LineSpaceButtonSetting(
          index: 3, type: false, position: const Offset(1450, 775)),
      LineSpaceButtonSetting(
          index: 4, type: false, position: const Offset(1700, 435)),
      LineSpaceButtonSetting(
          index: 5, type: false, position: const Offset(1950, 955)),
    ],
    [
      // クルマ(4種)
      LineSpaceButtonSetting(
          index: 0, type: false, position: const Offset(600, 970)),
      LineSpaceButtonSetting(
          index: 1, type: true, position: const Offset(950, 860)),
      LineSpaceButtonSetting(
          index: 2, type: false, position: const Offset(1600, 630)),
      LineSpaceButtonSetting(
          index: 3, type: true, position: const Offset(1250, 680)),
      LineSpaceButtonSetting(
          index: 4, type: false, position: const Offset(1850, 435)),
    ],
    [
      // ヘリコプター
      LineSpaceButtonSetting(
          index: 0, type: false, position: const Offset(600, 750)),
      LineSpaceButtonSetting(
          index: 1, type: true, position: const Offset(950, 650)),
      LineSpaceButtonSetting(
          index: 2, type: false, position: const Offset(1250, 410)),
      LineSpaceButtonSetting(
          index: 3, type: false, position: const Offset(1600, 580)),
      LineSpaceButtonSetting(
          index: 4, type: true, position: const Offset(1850, 1000)),
    ],
    [
      // ボール
      LineSpaceButtonSetting(
          index: 0, type: false, position: const Offset(700, 617)),
      LineSpaceButtonSetting(
          index: 1, type: true, position: const Offset(1000, 540)),
      LineSpaceButtonSetting(
          index: 2, type: false, position: const Offset(1250, 965)),
      LineSpaceButtonSetting(
          index: 3, type: true, position: const Offset(1450, 700)),
      LineSpaceButtonSetting(
          index: 4, type: false, position: const Offset(1800, 790)),
      LineSpaceButtonSetting(
          index: 5, type: true, position: const Offset(2050, 370)),
    ],
    [
      // リース
      LineSpaceButtonSetting(
          index: 0, type: true, position: const Offset(700, 530)),
      LineSpaceButtonSetting(
          index: 1, type: false, position: const Offset(950, 790)),
      LineSpaceButtonSetting(
          index: 2, type: true, position: const Offset(1250, 700)),
      LineSpaceButtonSetting(
          index: 3, type: true, position: const Offset(1450, 1050)),
      LineSpaceButtonSetting(
          index: 4, type: false, position: const Offset(1650, 445)),
      LineSpaceButtonSetting(
          index: 5, type: false, position: const Offset(1900, 960)),
    ]
  ],
  [
    // 1334x750
    [
      // イチゴ
      LineSpaceButtonSetting(
          index: 0, type: false, position: const Offset(400, 355)),
      LineSpaceButtonSetting(
          index: 1, type: true, position: const Offset(500, 500)),
      LineSpaceButtonSetting(
          index: 2, type: true, position: const Offset(600, 200)),
      LineSpaceButtonSetting(
          index: 3, type: false, position: const Offset(700, 455)),
      LineSpaceButtonSetting(
          index: 4, type: false, position: const Offset(800, 255)),
      LineSpaceButtonSetting(
          index: 5, type: false, position: const Offset(900, 555)),
    ],
    [
      // クルマ(4種)
      LineSpaceButtonSetting(
          index: 0, type: false, position: const Offset(300, 570)),
      LineSpaceButtonSetting(
          index: 1, type: true, position: const Offset(470, 500)),
      LineSpaceButtonSetting(
          index: 2, type: false, position: const Offset(750, 360)),
      LineSpaceButtonSetting(
          index: 3, type: true, position: const Offset(580, 395)),
      LineSpaceButtonSetting(
          index: 4, type: false, position: const Offset(850, 250)),
    ],
    [
      // ヘリコプター
      LineSpaceButtonSetting(
          index: 0, type: false, position: const Offset(300, 460)),
      LineSpaceButtonSetting(
          index: 1, type: true, position: const Offset(470, 400)),
      LineSpaceButtonSetting(
          index: 2, type: false, position: const Offset(580, 260)),
      LineSpaceButtonSetting(
          index: 3, type: false, position: const Offset(750, 360)),
      LineSpaceButtonSetting(
          index: 4, type: true, position: const Offset(850, 610)),
    ],
    [
      // ボール
      LineSpaceButtonSetting(
          index: 0, type: false, position: const Offset(380, 360)),
      LineSpaceButtonSetting(
          index: 1, type: true, position: const Offset(520, 310)),
      LineSpaceButtonSetting(
          index: 2, type: false, position: const Offset(580, 560)),
      LineSpaceButtonSetting(
          index: 3, type: true, position: const Offset(700, 410)),
      LineSpaceButtonSetting(
          index: 4, type: false, position: const Offset(850, 460)),
      LineSpaceButtonSetting(
          index: 5, type: true, position: const Offset(930, 210)),
    ],
    [
      // リース
      LineSpaceButtonSetting(
          index: 0, type: true, position: const Offset(380, 310)),
      LineSpaceButtonSetting(
          index: 1, type: false, position: const Offset(470, 460)),
      LineSpaceButtonSetting(
          index: 2, type: true, position: const Offset(610, 410)),
      LineSpaceButtonSetting(
          index: 3, type: true, position: const Offset(710, 610)),
      LineSpaceButtonSetting(
          index: 4, type: false, position: const Offset(820, 260)),
      LineSpaceButtonSetting(
          index: 5, type: false, position: const Offset(930, 560)),
    ]
  ]
];

List<LineSpaceButtonSetting> getLineSpaceBButtonSetting(
    BuildContext context, int level) {
  final int index = getScreenSizeIndex(MediaQuery.of(context).size);
  final double scale = getScreenScale(context);
  if (level >= _lineSpaceBButtonSettings[index].length) {
    level = _lineSpaceBButtonSettings[index].length - 1;
  }

  return _lineSpaceBButtonSettings[index][level]
      .map((setting) => LineSpaceButtonSetting(
            index: setting.index,
            type: setting.type,
            position: setting.position * scale,
          ))
      .toList();
}

const int lineBTypeNum = 5;
List<String> _lineSpaceBFolderNames = [
  'Strawberry',
  'Car',
  'Helicopter',
  'Ball',
  'Lease',
];

String getLineSpaceBBGImageName(String folderName, bool lineType, int level) {
  if (level >= _lineSpaceBButtonSizes[0].length) {
    level = _lineSpaceBButtonSizes[0].length - 1;
  }
  return 'assets/images/$folderName/LineSpaceB/${_lineSpaceBFolderNames[level]}/${lineType ? 'line' : 'space'}_bg.png';
}

List<List<List<Size>>> _lineSpaceBButtonSizes = [
  [
    // 2266x1488
    [
      // イチゴ
      const Size(84, 110),
    ],
    [
      // クルマ(4種)
      const Size(222, 108),
      const Size(242, 121),
      const Size(216, 113),
      const Size(235, 133),
    ],
    [
      // ヘリコプター
      const Size(201, 103),
    ],
    [
      // ボール
      const Size(105, 106),
    ],
    [
      // リース
      const Size(100, 104),
    ]
  ],
  [
    // 2732x2048
    [
      // イチゴ
      const Size(135, 178),
    ],
    [
      // クルマ(4種)
      const Size(269, 161),
      const Size(269, 161),
      const Size(269, 161),
      const Size(269, 161),
    ],
    [
      // ヘリコプター
      const Size(278, 143),
    ],
    [
      // ボール
      const Size(143, 142),
    ],
    [
      // リース
      const Size(134, 139),
    ]
  ],
  [
    // 2796x1290
    [
      // イチゴ
      const Size(135, 178),
    ],
    [
      // クルマ(4種)
      const Size(292, 142),
      const Size(296, 148),
      const Size(272, 143),
      const Size(295, 167),
    ],
    [
      // ヘリコプター
      const Size(309, 230),
    ],
    [
      // ボール
      const Size(158, 159),
    ],
    [
      // リース
      const Size(153, 159),
    ]
  ],
  [
    // 1334x750
    [
      // イチゴ
      const Size(75, 98),
    ],
    [
      // クルマ(4種)
      const Size(170, 83),
      const Size(172, 86),
      const Size(158, 83),
      const Size(171, 97),
    ],
    [
      // ヘリコプター
      const Size(175, 92),
    ],
    [
      // ボール
      const Size(91, 92),
    ],
    [
      // リース
      const Size(88, 91),
    ]
  ]
];

String getLineSpaceBButtonImageName(
    String folderName, int level, int buttonIndex) {
  if (level >= _lineSpaceBButtonSizes[0].length) {
    level = _lineSpaceBButtonSizes[0].length - 1;
  }
  String imageName = 'button';
  if (_lineSpaceBButtonSizes[0][level].length > 1) {
    if (buttonIndex >= _lineSpaceBButtonSizes[0][level].length) {
      buttonIndex = _lineSpaceBButtonSizes[0][level].length - 1;
    }
    imageName += (buttonIndex + 1).toString();
  }
  return 'assets/images/$folderName/LineSpaceB/${_lineSpaceBFolderNames[level]}/$imageName.png';
}

Size getLineSpaceBButtonSize(BuildContext context, int level, int buttonIndex) {
  final int index = getScreenSizeIndex(MediaQuery.of(context).size);
  if (level >= _lineSpaceBButtonSizes[0].length) {
    level = _lineSpaceBButtonSizes[0].length - 1;
  }
  if (buttonIndex >= _lineSpaceBButtonSizes[0][level].length) {
    buttonIndex = _lineSpaceBButtonSizes[0][level].length - 1;
  }
  return _lineSpaceBButtonSizes[index][level][buttonIndex] *
      getScreenScale(context);
}

List<ViewSetting> _lineSpaceBNextButtonViewSettings = [
  // 2266x1488
  ViewSetting(
    position: const Offset(1900, 1312),
    size: const Size(343, 115),
  ),
  // 2732x2048
  ViewSetting(
    position: const Offset(2220, 1816),
    size: const Size(468, 157),
  ),
  // 2796x1290
  ViewSetting(
    position: const Offset(2280, 1050),
    size: const Size(495, 166),
  ),
  // 1334x750
  ViewSetting(
    position: const Offset(1080, 630),
    size: const Size(244, 81),
  ),
];

ViewSetting getLineSpaceBNextButtonViewSetting(BuildContext context) {
  return getViewSetting(_lineSpaceBNextButtonViewSettings, context);
}

List<ViewSetting> _lineSpaceBStartButtonViewSettings = [
  // 2266x1488
  ViewSetting(
    position: const Offset(950, 1300),
    size: const Size(343, 127),
  ),
  // 2732x2048
  ViewSetting(
    position: const Offset(1400, 1800),
    size: const Size(471, 173),
  ),
  // 2796x1290
  ViewSetting(
    position: const Offset(2280, 800),
    size: const Size(499, 183),
  ),
  // 1334x750
  ViewSetting(
    position: const Offset(1080, 500),
    size: const Size(244, 90),
  ),
];

ViewSetting getLineSpaceBStartButtonViewSetting(BuildContext context) {
  return getViewSetting(_lineSpaceBStartButtonViewSettings, context);
}

/////////////////////////////////////////////////////////////////////////////////////////////////
// 線と間C
/////////////////////////////////////////////////////////////////////////////////////////////////
List<String> _lineSpaceCButtonImageName = [
  '5.png',
  '4.png',
  '3.png',
  '2.png',
  '1.png',
];

const List<Size> _lineSpaceCButtonSize = [
  Size(535, 142), // 2266x1488
  Size(737, 193), // 2732x2048
  Size(464, 121), // 2796x1290
  Size(270, 70), // 1334x750
];

List<Offset> _lineSpaceCLineButtonStartPos = [
  Offset(1350, 500), // 2266x1488
  Offset(1700, 650), // 2732x2048
  Offset(1600, 400), // 2796x1290
  Offset(800, 250), // 1334x750
];

List<Offset> _lineSpaceCSpaceButtonStartPos = [
  Offset(1350, 550), // 2266x1488
  Offset(1700, 750), // 2732x2048
  Offset(1600, 450), // 2796x1290
  Offset(800, 280), // 1334x750
];

List<double> _lineSpaceCButtonSpace = [
  142, // 2266x1488
  193, // 2732x2048
  121, // 2796x1290
  70, // 1334x750
];

List<OnpuKeyboardSetting> getLineSpaceCButtonSetting(
    BuildContext context, bool lineType) {
  final String folderName = getSizeFolderName(context);
  final int index = getScreenSizeIndex(MediaQuery.of(context).size);
  final double scale = getScreenScale(context);
  List<OnpuKeyboardSetting> onpuKeyboardSetting = [];
  List<Offset> positions =
      lineType ? _lineSpaceCLineButtonStartPos : _lineSpaceCSpaceButtonStartPos;
  final num = lineType ? 5 : 4;
  final int ofs = lineType ? 0 : 1;
  for (int i = 0; i < num; i++) {
    onpuKeyboardSetting.add(OnpuKeyboardSetting(
      image: true,
      imageName:
          'assets/images/$folderName/LineSpaceC/${_lineSpaceCButtonImageName[i + ofs]}',
      index: i,
      position: positions[index] * scale +
          Offset(0, _lineSpaceCButtonSpace[index] * i * scale),
    ));
  }
  return onpuKeyboardSetting;
}

Size getLineSpaceCButtonSize(BuildContext context) {
  final int index = getScreenSizeIndex(MediaQuery.of(context).size);
  return _lineSpaceCButtonSize[index] * getScreenScale(context);
}

List<OnpuQuestionSetting> lineSpaceCLineKeyboardQuestionsTo = [
  OnpuQuestionSetting(index: 0, correctIdx: 4, imageName: "gakufu_mi.png"),
  OnpuQuestionSetting(index: 1, correctIdx: 3, imageName: "gakufu_so.png"),
  OnpuQuestionSetting(index: 2, correctIdx: 2, imageName: "gakufu_ti.png"),
  OnpuQuestionSetting(index: 3, correctIdx: 1, imageName: "gakufu_hre.png"),
  OnpuQuestionSetting(index: 4, correctIdx: 0, imageName: "gakufu_hfa.png"),
];
List<OnpuQuestionSetting> lineSpaceCLineKeyboardQuestionsHe = [
  OnpuQuestionSetting(index: 0, correctIdx: 2, imageName: "gakufu_re.png"),
  OnpuQuestionSetting(index: 1, correctIdx: 1, imageName: "gakufu_fa.png"),
  OnpuQuestionSetting(index: 2, correctIdx: 0, imageName: "gakufu_la.png"),
  OnpuQuestionSetting(index: 3, correctIdx: 3, imageName: "gakufu_uti.png"),
  OnpuQuestionSetting(index: 4, correctIdx: 4, imageName: "gakufu_uso.png"),
];
List<OnpuQuestionSetting> lineSpaceCSpaceKeyboardQuestionsTo = [
  OnpuQuestionSetting(index: 0, correctIdx: 3, imageName: "gakufu_fa.png"),
  OnpuQuestionSetting(index: 1, correctIdx: 2, imageName: "gakufu_la.png"),
  OnpuQuestionSetting(index: 2, correctIdx: 1, imageName: "gakufu_hdo.png"),
  OnpuQuestionSetting(index: 3, correctIdx: 0, imageName: "gakufu_hmi.png"),
];
List<OnpuQuestionSetting> lineSpaceCSpaceKeyboardQuestionsHe = [
  OnpuQuestionSetting(index: 0, correctIdx: 2, imageName: "gakufu_do.png"),
  OnpuQuestionSetting(index: 1, correctIdx: 1, imageName: "gakufu_mi.png"),
  OnpuQuestionSetting(index: 2, correctIdx: 0, imageName: "gakufu_so.png"),
  OnpuQuestionSetting(index: 3, correctIdx: 3, imageName: "gakufu_ula.png"),
];

List<ViewSetting> _lineSpaceCGakufuViewSettings = [
  ViewSetting(
    // 2266x1488
    position: const Offset(250, 400),
    size: const Size(1018, 837),
  ),
  ViewSetting(
    // 2732x2048
    position: const Offset(200, 550),
    size: const Size(1324, 1088),
  ),
  ViewSetting(
    // 2796x1290
    position: const Offset(600, 250),
    size: const Size(967, 795),
  ),
  ViewSetting(
    // 1334x750
    position: const Offset(200, 170),
    size: const Size(561, 461),
  ),
];

ViewSetting getLineSpaceCGakufuViewSetting(BuildContext context) {
  return getViewSetting(_lineSpaceCGakufuViewSettings, context);
}

String getLineSpaceCGakufuName(
    String folder, int index, bool soundType, bool lineType) {
  String soundFolder = soundType ? 'To' : 'He';
  List<OnpuQuestionSetting> questions =
      getLineSpaceCQuestions(lineType, soundType);
  return 'assets/images/$folder/LineSpaceC/$soundFolder/${questions[index].imageName}';
}

List<OnpuQuestionSetting> getLineSpaceCQuestions(
    bool lineType, bool soundType) {
  return lineType
      ? soundType
          ? lineSpaceCLineKeyboardQuestionsTo
          : lineSpaceCLineKeyboardQuestionsHe
      : soundType
          ? lineSpaceCSpaceKeyboardQuestionsTo
          : lineSpaceCSpaceKeyboardQuestionsHe;
}

List<ViewSetting> _lineSpaceCStartButtonViewSettings = [
  ViewSetting(
    // 2266x1488
    position: const Offset(900, 1200),
    size: const Size(343, 115),
  ),
  ViewSetting(
    // 2732x2048
    position: const Offset(1100, 1650),
    size: const Size(471, 158),
  ),
  ViewSetting(
    // 2796x1290
    position: const Offset(1000, 970),
    size: const Size(499, 167),
  ),
  ViewSetting(
    // 1334x750
    position: const Offset(500, 570),
    size: const Size(244, 82),
  ),
];

ViewSetting getLineSpaceCStartButtonViewSetting(BuildContext context) {
  return getViewSetting(_lineSpaceCStartButtonViewSettings, context);
}

String getOnpu2LineSpaceCStartButtonImageName(BuildContext context, int type) {
  String sizeFolderName = getSizeFolderName(context);
  String folderName = (type < 2) ? 'OnpuGame2' : 'LineSpaceC';
  String typeName = (type == 0) ? 'Kenban' : 'Icon';
  String imageName = (type < 2) ? '$typeName/start_car.png' : 'start_plane.png';
  return 'assets/images/$sizeFolderName/$folderName/$imageName';
}

String getOnpu2LineSpaceCBGName(
    BuildContext context, int type, bool soundType) {
  String sizeFolderName = getSizeFolderName(context);
  String folderName = (type < 2) ? 'OnpuGame2' : 'LineSpaceC';
  String typeName = (type == 0) ? 'Kenban' : 'Icon';

  String imageName = (type < 2)
      ? '$typeName/bg.png'
      : (type == 2)
          ? (soundType ? 'line_bg.png' : 'line_to_bg.png')
          : (soundType ? 'space_bg.png' : 'space_to_bg.png');

  return 'assets/images/$sizeFolderName/$folderName/$imageName';
}

List<ViewSetting> _onpu2IconNextButtonViewSettings = [
  ViewSetting(
      position: const Offset(1500, 802),
      size: const Size(343, 115)), //2266x1488
  ViewSetting(
      position: const Offset(1850, 1116),
      size: const Size(468, 157)), //2732x2048
  ViewSetting(
      position: const Offset(1650, 717),
      size: const Size(495, 166)), //2796x1290
  ViewSetting(
      position: const Offset(800, 379), size: const Size(244, 81)), //1334x750
];

List<ViewSetting> _onpu2KenbanNextButtonViewSettings = [
  ViewSetting(
      position: const Offset(1600, 761),
      size: const Size(343, 115)), //2266x1488
  ViewSetting(
      position: const Offset(2050, 1066),
      size: const Size(468, 157)), //2732x2048
  ViewSetting(
      position: const Offset(2110, 998),
      size: const Size(495, 166)), //2796x1290
  ViewSetting(
      position: const Offset(1030, 581), size: const Size(244, 81)), //1334x750
];

List<ViewSetting> _lineSpaceCNextButtonViewSettings = [
  ViewSetting(
      position: const Offset(900, 1200),
      size: const Size(343, 115)), //2266x1488
  ViewSetting(
      position: const Offset(1100, 1651),
      size: const Size(468, 157)), //2732x2048
  ViewSetting(
      position: const Offset(1000, 971),
      size: const Size(495, 166)), //2796x1290
  ViewSetting(
      position: const Offset(500, 571), size: const Size(244, 81)), //1334x750
];
ViewSetting getOnpu2LineSpaceCNextButtonViewSetting(
    BuildContext context, int type) {
  List<ViewSetting> settings = (type < 2)
      ? ((type == 0)
          ? _onpu2KenbanNextButtonViewSettings
          : _onpu2IconNextButtonViewSettings)
      : _lineSpaceCNextButtonViewSettings;
  return getViewSetting(settings, context);
}

String getOnpu2LineSpaceCNextButtonImageName(context) {
  String sizeFolderName = getSizeFolderName(context);
  return 'assets/images/$sizeFolderName/OnpuGame2/next.jpg';
}

String getOnpu2LineSpaceCsoundbgImageName(context) {
  String sizeFolderName = getSizeFolderName(context);
  return 'assets/images/$sizeFolderName/OnpuGame2/bg.png';
}
