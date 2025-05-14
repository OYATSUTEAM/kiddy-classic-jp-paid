import 'package:flutter/material.dart';

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

/////////////////////////////////////////////////////////////////////////////////////////////////
// メニュー
/////////////////////////////////////////////////////////////////////////////////////////////////
String getBackGroundImageName(String folderName, int idx) {
  return 'assets/images/$folderName/Menu/menu$idx.png';
}

List<List<ViewSetting>> _puzzlesButtonSetting = [
  [
    // ト音パズル
    ViewSetting(
        position: const Offset(120, 720),
        size: const Size(400, 520)), // 2266x1488
    ViewSetting(
        position: const Offset(145, 990),
        size: const Size(475, 635)), // 2732x2048
    ViewSetting(
        position: const Offset(420, 620),
        size: const Size(380, 510)), // 2796x1290
    ViewSetting(
        position: const Offset(65, 360),
        size: const Size(240, 310)), // 1334x750
  ],
  [
    // ヘ音パズル
    ViewSetting(
        position: const Offset(660, 720),
        size: const Size(400, 520)), // 2266x1488
    ViewSetting(
        position: const Offset(795, 990),
        size: const Size(475, 635)), // 2732x2048
    ViewSetting(
        position: const Offset(950, 620),
        size: const Size(380, 510)), // 2796x1290
    ViewSetting(
        position: const Offset(380, 360),
        size: const Size(240, 310)), // 1334x750
  ],
  [
    // 音符パズル
    ViewSetting(
        position: const Offset(1215, 720),
        size: const Size(400, 520)), // 2266x1488
    ViewSetting(
        position: const Offset(1455, 990),
        size: const Size(475, 635)), // 2732x2048
    ViewSetting(
        position: const Offset(1480, 620),
        size: const Size(380, 510)), // 2796x1290
    ViewSetting(
        position: const Offset(700, 360),
        size: const Size(240, 310)), // 1334x750
  ],
  [
    // 休符パズル
    ViewSetting(
        position: const Offset(1720, 720),
        size: const Size(400, 520)), // 2266x1488
    ViewSetting(
        position: const Offset(2090, 990),
        size: const Size(475, 635)), // 2732x2048
    ViewSetting(
        position: const Offset(2000, 620),
        size: const Size(380, 510)), // 2796x1290
    ViewSetting(
        position: const Offset(1020, 360),
        size: const Size(240, 310)), // 1334x750
  ],
];

ViewSetting getPuzzleButtonViewSetting(BuildContext context, int index) {
  if (index > _puzzlesButtonSetting.length) {
    index = _puzzlesButtonSetting.length - 1;
  }
  return getViewSetting(_puzzlesButtonSetting[index], context);
}

List<List<ViewSetting>> _doremiButtonSetting = [
  [
    // ト音どれみ-ど
    ViewSetting(
        position: const Offset(85, 270),
        size: const Size(484, 280)), // 2266x1488
    ViewSetting(
        position: const Offset(102, 430),
        size: const Size(583, 327)), // 2732x2048
    ViewSetting(
        position: const Offset(280, 200),
        size: const Size(520, 280)), // 2796x1290
    ViewSetting(
        position: const Offset(050, 130),
        size: const Size(285, 160)), // 1334x750
  ],
  [
    // ヘ音どれみ-れ
    ViewSetting(
        position: const Offset(630, 270),
        size: const Size(484, 280)), // 2266x1488
    ViewSetting(
        position: const Offset(770, 430),
        size: const Size(583, 327)), // 2732x2048
    ViewSetting(
        position: const Offset(860, 200),
        size: const Size(520, 280)), // 2796x1290
    ViewSetting(
        position: const Offset(360, 130),
        size: const Size(285, 160)), // 1334x750
  ],
  [
    // ト音どれみ-ど
    ViewSetting(
        position: const Offset(1180, 270),
        size: const Size(484, 280)), // 2266x1488
    ViewSetting(
        position: const Offset(1415, 430),
        size: const Size(583, 327)), // 2732x2048
    ViewSetting(
        position: const Offset(1440, 200),
        size: const Size(520, 280)), // 2796x1290
    ViewSetting(
        position: const Offset(690, 130),
        size: const Size(285, 160)), // 1334x750
  ],
  [
    // ヘ音どれみ-れ
    ViewSetting(
        position: const Offset(1730, 270),
        size: const Size(484, 280)), // 2266x1488
    ViewSetting(
        position: const Offset(2090, 430),
        size: const Size(583, 327)), // 2732x2048
    ViewSetting(
        position: const Offset(2020, 200),
        size: const Size(520, 280)), // 2796x1290
    ViewSetting(
        position: const Offset(1020, 130),
        size: const Size(285, 160)), // 1334x750
  ],
   [
    // ト音どれみ-ど
    ViewSetting(
        position: const Offset(85, 600),
        size: const Size(484, 280)), // 2266x1488
    ViewSetting(
        position: const Offset(102, 800),
        size: const Size(583, 327)), // 2732x2048
    ViewSetting(
        position: const Offset(280, 540),
        size: const Size(520, 280)), // 2796x1290
    ViewSetting(
        position: const Offset(050, 310),
        size: const Size(285, 160)), // 1334x750
  ],
  [
    // ヘ音どれみ-れ
    ViewSetting(
        position: const Offset(630, 600),
        size: const Size(484, 280)), // 2266x1488
    ViewSetting(
        position: const Offset(770, 800),
        size: const Size(583, 327)), // 2732x2048
    ViewSetting(
        position: const Offset(860, 540),
        size: const Size(520, 280)), // 2796x1290
    ViewSetting(
        position: const Offset(360, 310),
        size: const Size(285, 160)), // 1334x750
  ],
  [
    // ト音どれみ-ど
    ViewSetting(
        position: const Offset(1180, 600),
        size: const Size(484, 280)), // 2266x1488
    ViewSetting(
        position: const Offset(1415, 800),
        size: const Size(583, 327)), // 2732x2048
    ViewSetting(
        position: const Offset(1440, 540),
        size: const Size(520, 280)), // 2796x1290
    ViewSetting(
        position: const Offset(690, 310),
        size: const Size(285, 160)), // 1334x750
  ],
  [
    // ヘ音どれみ-れ
    ViewSetting(
        position: const Offset(1730, 600),
        size: const Size(484, 280)), // 2266x1488
    ViewSetting(
        position: const Offset(2090, 800),
        size: const Size(583, 327)), // 2732x2048
    ViewSetting(
        position: const Offset(2020, 540),
        size: const Size(520, 280)), // 2796x1290
    ViewSetting(
        position: const Offset(1020, 310),
        size: const Size(285, 160)), // 1334x750
  ],

];

ViewSetting getDoremiButtonViewSetting(BuildContext context, int index) {
  if (index > _doremiButtonSetting.length) {
    index = _doremiButtonSetting.length - 1;
  }
  return getViewSetting(_doremiButtonSetting[index], context);
}

List<List<ViewSetting>> _menu2ButtonSetting = [
  [
    // 線と間A 線の上
    ViewSetting(
        position: const Offset(120, 260),
        size: const Size(400, 530)), // 2266x1488
    ViewSetting(
        position: const Offset(170, 420),
        size: const Size(480, 650)), // 2732x2048
    ViewSetting(
        position: const Offset(360, 220),
        size: const Size(390, 500)), // 2796x1290
    ViewSetting(
        position: const Offset(80, 120),
        size: const Size(220, 310)), // 1334x750
  ],
  [
    // 線と間A 線の間
    ViewSetting(
        position: const Offset(660, 260),
        size: const Size(400, 530)), // 2266x1488
    ViewSetting(
        position: const Offset(780, 420),
        size: const Size(480, 650)), // 2732x2048
    ViewSetting(
        position: const Offset(900, 220),
        size: const Size(390, 500)), // 2796x1290
    ViewSetting(
        position: const Offset(400, 120),
        size: const Size(220, 310)), // 1334x750
  ],
  [
    // 線と間B 線の上
    ViewSetting(
        position: const Offset(1200, 260),
        size: const Size(400, 530)), // 2266x1488
    ViewSetting(
        position: const Offset(1470, 420),
        size: const Size(480, 650)), // 2732x2048
    ViewSetting(
        position: const Offset(1480, 220),
        size: const Size(390, 500)), // 2796x1290
    ViewSetting(
        position: const Offset(720, 120),
        size: const Size(220, 310)), // 1334x750
  ],
  [
    // 線と間B 線の間
    ViewSetting(
        position: const Offset(1710, 260),
        size: const Size(400, 530)), // 2266x1488
    ViewSetting(
        position: const Offset(2100, 420),
        size: const Size(480, 650)), // 2732x2048
    ViewSetting(
        position: const Offset(2020, 220),
        size: const Size(390, 500)), // 2796x1290
    ViewSetting(
        position: const Offset(1020, 120),
        size: const Size(220, 310)), // 1334x750
  ],
 
];

ViewSetting getMenu2ButtonViewSetting(BuildContext context, int index) {
  if (index > _menu2ButtonSetting.length) {
    index = _menu2ButtonSetting.length - 1;
  }
  return getViewSetting(_menu2ButtonSetting[index], context);
}

List<List<ViewSetting>> _menu3ButtonSetting = [
  [
    // 線と間A 線の上
    ViewSetting(
        position: const Offset(150, 420),
        size: const Size(330, 330)), // 2266x1488
    ViewSetting(
        position: const Offset(200, 570),
        size: const Size(400, 400)), // 2732x2048
    ViewSetting(
        position: const Offset(380, 340),
        size: const Size(370, 340)), // 2796x1290
    ViewSetting(
        position: const Offset(100, 200),
        size: const Size(210, 210)), // 1334x750
  ],
  [
    // 線と間A 線の間
    ViewSetting(
        position: const Offset(660, 420),
        size: const Size(330, 330)), // 2266x1488
    ViewSetting(
        position: const Offset(780, 570),
        size: const Size(400, 400)), // 2732x2048
    ViewSetting(
        position: const Offset(900, 340),
        size: const Size(370, 340)), // 2796x1290
    ViewSetting(
        position: const Offset(380, 200),
        size: const Size(210, 210)), // 1334x750
  ],
  [
    // 線と間B 線の上
    ViewSetting(
        position: const Offset(1280, 420),
        size: const Size(330, 330)), // 2266x1488
    ViewSetting(
        position: const Offset(1560, 570),
        size: const Size(400, 400)), // 2732x2048
    ViewSetting(
        position: const Offset(1550, 340),
        size: const Size(370, 340)), // 2796x1290
    ViewSetting(
        position: const Offset(750, 200),
        size: const Size(210, 210)), // 1334x750
  ],
  [
    // 線と間B 線の間
    ViewSetting(
        position: const Offset(1800, 420),
        size: const Size(330, 330)), // 2266x1488
    ViewSetting(
        position: const Offset(2150, 570),
        size: const Size(400, 400)), // 2732x2048
    ViewSetting(
        position: const Offset(2050, 340),
        size: const Size(370, 340)), // 2796x1290
    ViewSetting(
        position: const Offset(1030, 200),
        size: const Size(210, 210)), // 1334x750
  ],
 
];

ViewSetting getMenu3ButtonViewSetting(BuildContext context, int index) {
  if (index > _menu3ButtonSetting.length) {
    index = _menu3ButtonSetting.length - 1;
  }
  return getViewSetting(_menu3ButtonSetting[index], context);
}

List<List<ViewSetting>> _menu4ButtonSetting = [
  [
    // おんぷゲーム２ 鍵盤
    ViewSetting(
        position: const Offset(100, 250),
        size: const Size(1000, 480)), // 2266x1488
    ViewSetting(
        position: const Offset(70, 400),
        size: const Size(1240, 570)), // 2732x2048
    ViewSetting(
        position: const Offset(320, 200),
        size: const Size(1050, 450)), // 2796x1290
    ViewSetting(
        position: const Offset(040, 95),
        size: const Size(600, 280)), // 1334x750
  ],
  [
    // おんぷゲーム１
    ViewSetting(
        position: const Offset(1170, 250),
        size: const Size(1000, 480)), // 2266x1488
    ViewSetting(
        position: const Offset(1400, 400),
        size: const Size(1240, 570)), // 2732x2048
    ViewSetting(
        position: const Offset(1430, 200),
        size: const Size(1050, 450)), // 2796x1290
    ViewSetting(
        position: const Offset(690, 95),
        size: const Size(600, 280)), // 1334x750
  ],

];

ViewSetting getMenu4ButtonViewSetting(BuildContext context, int index) {
  if (index > _menu4ButtonSetting.length) {
    index = _menu4ButtonSetting.length - 1;
  }
  return getViewSetting(_menu4ButtonSetting[index], context);
}

List<List<ViewSetting>> _menu5ButtonSetting = [
  [
    // おんぷゲーム２ 鍵盤
    ViewSetting(
        position: const Offset(100, 250),
        size: const Size(1000, 480)), // 2266x1488
    ViewSetting(
        position: const Offset(80, 400),
        size: const Size(1250, 560)), // 2732x2048
    ViewSetting(
        position: const Offset(320, 200),
        size: const Size(1000, 450)), // 2796x1290
    ViewSetting(
        position: const Offset(040, 120),
        size: const Size(600, 260)), // 1334x750
  ],
  [
    // おんぷゲーム１
    ViewSetting(
        position: const Offset(1170, 250),
        size: const Size(1000, 480)), // 2266x1488
    ViewSetting(
        position: const Offset(1400, 400),
        size: const Size(1250, 560)), // 2732x2048
    ViewSetting(
        position: const Offset(1420, 200),
        size: const Size(1050, 450)), // 2796x1290
    ViewSetting(
        position: const Offset(690, 120),
        size: const Size(600, 260)), // 1334x750
  ],
 
];

ViewSetting getMenu5ButtonViewSetting(BuildContext context, int index) {
  if (index > _menu5ButtonSetting.length) {
    index = _menu5ButtonSetting.length - 1;
  }
  return getViewSetting(_menu5ButtonSetting[index], context);
}



List<List<ViewSetting>> _menu6ButtonSetting = [
  [
    // おんぷゲーム２ 鍵盤
    ViewSetting(
        position: const Offset(70, 200),
        size: const Size(1000, 480)), // 2266x1488
    ViewSetting(
        position: const Offset(80, 350),
        size: const Size(1250, 560)), // 2732x2048
    ViewSetting(
        position: const Offset(300, 170),
        size: const Size(1050, 460)), // 2796x1290
    ViewSetting(
        position: const Offset(040, 100),
        size: const Size(600, 260)), // 1334x750
  ],
  [
    // おんぷゲーム１
    ViewSetting(
        position: const Offset(1170, 155),
        size: const Size(1050, 480)), // 2266x1488
    ViewSetting(
        position: const Offset(1400, 290),
        size: const Size(1250, 560)), // 2732x2048
    ViewSetting(
        position: const Offset(1450, 70),
        size: const Size(1000, 430)), // 2796x1290
    ViewSetting(
        position: const Offset(690, 120),
        size: const Size(600, 260)), // 1334x750
  ],
 
];

ViewSetting getMenu6ButtonViewSetting(BuildContext context, int index) {
  if (index > _menu6ButtonSetting.length) {
    index = _menu6ButtonSetting.length - 1;
  }
  return getViewSetting(_menu6ButtonSetting[index], context);
}



List<List<ViewSetting>> _menu7ButtonSetting = [
  [
    // おんぷゲーム２ 鍵盤
    ViewSetting(
        position: const Offset(70, 250),
        size: const Size(1000, 480)), // 2266x1488
    ViewSetting(
        position: const Offset(80, 400),
        size: const Size(1250, 560)), // 2732x2048
    ViewSetting(
        position: const Offset(320, 200),
        size: const Size(1050, 460)), // 2796x1290
    ViewSetting(
        position: const Offset(040, 120),
        size: const Size(600, 260)), // 1334x750
  ],
  [
    // おんぷゲーム１
    ViewSetting(
        position: const Offset(1170, 155),
        size: const Size(1050, 480)), // 2266x1488
    ViewSetting(
        position: const Offset(1400, 290),
        size: const Size(1250, 560)), // 2732x2048
    ViewSetting(
        position: const Offset(1450, 70),
        size: const Size(1000, 430)), // 2796x1290
    ViewSetting(
        position: const Offset(690, 120),
        size: const Size(600, 260)), // 1334x750
  ],
 
];

ViewSetting getMenu7ButtonViewSetting(BuildContext context, int index) {
  if (index > _menu7ButtonSetting.length) {
    index = _menu7ButtonSetting.length - 1;
  }
  return getViewSetting(_menu7ButtonSetting[index], context);
}

