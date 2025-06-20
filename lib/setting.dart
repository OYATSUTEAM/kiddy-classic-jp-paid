import 'package:flutter/material.dart';
import 'dart:developer' as developer;

void console(List<dynamic> parameters) {
  for (var parameter in parameters) {
    developer.log(parameter.toString());
  }
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

String getBackGroundImageName(String folderName, int idx) {
  return 'assets/images/$folderName/Menu/menu$idx.png';
}

List<List<ViewSetting>> _doremiToButtonSetting = [
  [
    // ト音どれみ-ど
    ViewSetting(
        position: const Offset(85, 180),
        size: const Size(484, 280)), // 2266x1488
    ViewSetting(
        position: const Offset(102, 350),
        size: const Size(583, 327)), // 2732x2048
    ViewSetting(
        position: const Offset(480, 160),
        size: const Size(430, 230)), // 2796x1290
    ViewSetting(
        position: const Offset(140, 90),
        size: const Size(250, 140)), // 1334x750
  ],
  [
    // ヘ音どれみ-れ
    ViewSetting(
        position: const Offset(630, 180),
        size: const Size(484, 280)), // 2266x1488
    ViewSetting(
        position: const Offset(770, 350),
        size: const Size(583, 327)), // 2732x2048
    ViewSetting(
        position: const Offset(950, 160),
        size: const Size(430, 230)), // 2796x1290
    ViewSetting(
        position: const Offset(410, 90),
        size: const Size(250, 140)), // 1334x750
  ],
  [
    // ト音どれみ-ど
    ViewSetting(
        position: const Offset(1180, 180),
        size: const Size(484, 280)), // 2266x1488
    ViewSetting(
        position: const Offset(1415, 350),
        size: const Size(583, 327)), // 2732x2048
    ViewSetting(
        position: const Offset(1440, 160),
        size: const Size(430, 230)), // 2796x1290
    ViewSetting(
        position: const Offset(690, 90),
        size: const Size(250, 140)), // 1334x750
  ],
  [
    // ヘ音どれみ-れ
    ViewSetting(
        position: const Offset(1730, 180),
        size: const Size(484, 280)), // 2266x1488
    ViewSetting(
        position: const Offset(2090, 350),
        size: const Size(583, 327)), // 2732x2048
    ViewSetting(
        position: const Offset(1920, 160),
        size: const Size(430, 230)), // 2796x1290
    ViewSetting(
        position: const Offset(960, 90),
        size: const Size(250, 140)), // 1334x750
  ],
  [
    // ト音どれみ-ど
    ViewSetting(
        position: const Offset(85, 500),
        size: const Size(484, 280)), // 2266x1488
    ViewSetting(
        position: const Offset(102, 730),
        size: const Size(583, 327)), // 2732x2048
    ViewSetting(
        position: const Offset(480, 430),
        size: const Size(430, 230)), // 2796x1290
    ViewSetting(
        position: const Offset(140, 250),
        size: const Size(250, 140)), // 1334x750
  ],
  [
    // ヘ音どれみ-れ
    ViewSetting(
        position: const Offset(630, 500),
        size: const Size(484, 280)), // 2266x1488
    ViewSetting(
        position: const Offset(770, 730),
        size: const Size(583, 327)), // 2732x2048
    ViewSetting(
        position: const Offset(950, 430),
        size: const Size(430, 230)), // 2796x1290
    ViewSetting(
        position: const Offset(410, 250),
        size: const Size(250, 140)), // 1334x750
  ],
  [
    // ト音どれみ-ど
    ViewSetting(
        position: const Offset(1180, 500),
        size: const Size(484, 280)), // 2266x1488
    ViewSetting(
        position: const Offset(1415, 730),
        size: const Size(583, 327)), // 2732x2048
    ViewSetting(
        position: const Offset(1440, 430),
        size: const Size(430, 230)), // 2796x1290
    ViewSetting(
        position: const Offset(690, 250),
        size: const Size(250, 140)), // 1334x750
  ],
  [
    // ヘ音どれみ-れ
    ViewSetting(
        position: const Offset(1730, 500),
        size: const Size(484, 280)), // 2266x1488
    ViewSetting(
        position: const Offset(2090, 730),
        size: const Size(583, 327)), // 2732x2048
    ViewSetting(
        position: const Offset(1920, 430),
        size: const Size(430, 230)), // 2796x1290
    ViewSetting(
        position: const Offset(960, 250),
        size: const Size(250, 140)), // 1334x750
  ],
];

//==================================================================================    doremi to
//==================================================================================    doremi to
//==================================================================================    doremi to
//==================================================================================    doremi to

List<List<ViewSetting>> _doremiHeButtonSetting = [
  [
    // ト音どれみ-ど
    ViewSetting(
        position: const Offset(85, 820),
        size: const Size(484, 280)), // 2266x1488
    ViewSetting(
        position: const Offset(102, 1120),
        size: const Size(583, 327)), // 2732x2048
    ViewSetting(
        position: const Offset(480, 720),
        size: const Size(430, 230)), // 2796x1290
    ViewSetting(
        position: const Offset(140, 415),
        size: const Size(250, 140)), // 1334x750
  ],
  [
    // ヘ音どれみ-れ
    ViewSetting(
        position: const Offset(630, 820),
        size: const Size(484, 280)), // 2266x1488
    ViewSetting(
        position: const Offset(770, 1120),
        size: const Size(583, 327)), // 2732x2048
    ViewSetting(
        position: const Offset(950, 720),
        size: const Size(430, 230)), // 2796x1290
    ViewSetting(
        position: const Offset(410, 415),
        size: const Size(250, 140)), // 1334x750
  ],
  [
    // ト音どれみ-ど
    ViewSetting(
        position: const Offset(1180, 820),
        size: const Size(484, 280)), // 2266x1488
    ViewSetting(
        position: const Offset(1415, 1120),
        size: const Size(583, 327)), // 2732x2048
    ViewSetting(
        position: const Offset(1440, 720),
        size: const Size(430, 230)), // 2796x1290
    ViewSetting(
        position: const Offset(690, 415),
        size: const Size(250, 140)), // 1334x750
  ],
  [
    // ヘ音どれみ-れ
    ViewSetting(
        position: const Offset(1730, 820),
        size: const Size(484, 280)), // 2266x1488
    ViewSetting(
        position: const Offset(2090, 1120),
        size: const Size(583, 327)), // 2732x2048
    ViewSetting(
        position: const Offset(1920, 720),
        size: const Size(430, 230)), // 2796x1290
    ViewSetting(
        position: const Offset(960, 415),
        size: const Size(250, 140)), // 1334x750
  ],
  [
    // ト音どれみ-ど
    ViewSetting(
        position: const Offset(85, 1150),
        size: const Size(484, 280)), // 2266x1488
    ViewSetting(
        position: const Offset(102, 1500),
        size: const Size(583, 327)), // 2732x2048
    ViewSetting(
        position: const Offset(480, 990),
        size: const Size(430, 230)), // 2796x1290
    ViewSetting(
        position: const Offset(140, 570),
        size: const Size(250, 140)), // 1334x750
  ],
  [
    // ヘ音どれみ-れ
    ViewSetting(
        position: const Offset(630, 1150),
        size: const Size(484, 280)), // 2266x1488
    ViewSetting(
        position: const Offset(770, 1500),
        size: const Size(583, 327)), // 2732x2048
    ViewSetting(
        position: const Offset(950, 990),
        size: const Size(430, 230)), // 2796x1290
    ViewSetting(
        position: const Offset(410, 570),
        size: const Size(250, 140)), // 1334x750
  ],
  [
    // ト音どれみ-ど
    ViewSetting(
        position: const Offset(1180, 1150),
        size: const Size(484, 280)), // 2266x1488
    ViewSetting(
        position: const Offset(1415, 1500),
        size: const Size(583, 327)), // 2732x2048
    ViewSetting(
        position: const Offset(1440, 990),
        size: const Size(430, 230)), // 2796x1290
    ViewSetting(
        position: const Offset(690, 570),
        size: const Size(250, 140)), // 1334x750
  ],
  [
    // ヘ音どれみ-れ
    ViewSetting(
        position: const Offset(1730, 1150),
        size: const Size(484, 280)), // 2266x1488
    ViewSetting(
        position: const Offset(2090, 1500),
        size: const Size(583, 327)), // 2732x2048
    ViewSetting(
        position: const Offset(1920, 990),
        size: const Size(430, 230)), // 2796x1290
    ViewSetting(
        position: const Offset(960, 570),
        size: const Size(250, 140)), // 1334x750
  ],
];

//==================================================================================    doremi he
//==================================================================================    doremi he
//==================================================================================    doremi he
//==================================================================================    doremi he

List<List<ViewSetting>> _menu2ButtonSetting = [
  [
    // 線と間A 線の上
    ViewSetting(
        position: const Offset(120, 200),
        size: const Size(400, 530)), // 2266x1488
    ViewSetting(
        position: const Offset(170, 380),
        size: const Size(480, 650)), // 2732x2048
    ViewSetting(
        position: const Offset(490, 170),
        size: const Size(370, 460)), // 2796x1290
    ViewSetting(
        position: const Offset(140, 90),
        size: const Size(210, 270)), // 1334x750
  ],
  [
    // 線と間A 線の間
    ViewSetting(
        position: const Offset(660, 200),
        size: const Size(400, 530)), // 2266x1488
    ViewSetting(
        position: const Offset(780, 380),
        size: const Size(480, 650)), // 2732x2048
    ViewSetting(
        position: const Offset(970, 170),
        size: const Size(370, 450)), // 2796x1290
    ViewSetting(
        position: const Offset(420, 90),
        size: const Size(210, 270)), // 1334x750
  ],
  [
    // 線と間B 線の上
    ViewSetting(
        position: const Offset(1200, 200),
        size: const Size(400, 530)), // 2266x1488
    ViewSetting(
        position: const Offset(1470, 380),
        size: const Size(480, 650)), // 2732x2048
    ViewSetting(
        position: const Offset(1460, 170),
        size: const Size(370, 450)), // 2796x1290
    ViewSetting(
        position: const Offset(700, 90),
        size: const Size(210, 270)), // 1334x750
  ],
  [
    // 線と間B 線の間
    ViewSetting(
        position: const Offset(1710, 200),
        size: const Size(400, 530)), // 2266x1488
    ViewSetting(
        position: const Offset(2100, 380),
        size: const Size(480, 650)), // 2732x2048
    ViewSetting(
        position: const Offset(1910, 170),
        size: const Size(370, 450)), // 2796x1290
    ViewSetting(
        position: const Offset(970, 90),
        size: const Size(210, 270)), // 1334x750
  ],
// =============================================================================================           PUZZLE
// =============================================================================================           PUZZLE
// =============================================================================================           PUZZLE
// =============================================================================================           PUZZLE
  [
    // 線と間A 線の上
    ViewSetting(
        position: const Offset(180, 1100),
        size: const Size(330, 330)), // 2266x1488
    ViewSetting(
        position: const Offset(200, 1500),
        size: const Size(400, 400)), // 2732x2048
    ViewSetting(
        position: const Offset(530, 950),
        size: const Size(320, 320)), // 2796x1290
    ViewSetting(
        position: const Offset(170, 560),
        size: const Size(190, 190)), // 1334x750
  ],
  [
    // 線と間A 線の間
    ViewSetting(
        position: const Offset(660, 1100),
        size: const Size(330, 330)), // 2266x1488
    ViewSetting(
        position: const Offset(780, 1500),
        size: const Size(400, 400)), // 2732x2048
    ViewSetting(
        position: const Offset(970, 950),
        size: const Size(320, 320)), // 2796x1290
    ViewSetting(
        position: const Offset(420, 560),
        size: const Size(190, 190)), // 1334x750
  ],
  [
    // 線と間B 線の上
    ViewSetting(
        position: const Offset(1280, 1100),
        size: const Size(330, 330)), // 2266x1488
    ViewSetting(
        position: const Offset(1560, 1500),
        size: const Size(400, 400)), // 2732x2048
    ViewSetting(
        position: const Offset(1510, 950),
        size: const Size(320, 320)), // 2796x1290
    ViewSetting(
        position: const Offset(740, 560),
        size: const Size(190, 190)), // 1334x750
  ],
  [
    // 線と間B 線の間
    ViewSetting(
        position: const Offset(1750, 1100),
        size: const Size(330, 330)), // 2266x1488
    ViewSetting(
        position: const Offset(2150, 1500),
        size: const Size(400, 400)), // 2732x2048
    ViewSetting(
        position: const Offset(1950, 950),
        size: const Size(320, 320)), // 2796x1290
    ViewSetting(
        position: const Offset(980, 560),
        size: const Size(190, 190)), // 1334x750
  ],
];

List<List<ViewSetting>> _menu3ButtonSetting = [
  [
    // おんぷゲーム２ 鍵盤
    ViewSetting(
        position: const Offset(80, 200),
        size: const Size(1000, 480)), // 2266x1488
    ViewSetting(
        position: const Offset(70, 350),
        size: const Size(1240, 570)), // 2732x2048
    ViewSetting(
        position: const Offset(400, 150),
        size: const Size(950, 420)), // 2796x1290
    ViewSetting(
        position: const Offset(100, 85),
        size: const Size(550, 260)), // 1334x750
  ],
  [
    // おんぷゲーム１
    ViewSetting(
        position: const Offset(1170, 200),
        size: const Size(1000, 480)), // 2266x1488
    ViewSetting(
        position: const Offset(1400, 350),
        size: const Size(1240, 570)), // 2732x2048
    ViewSetting(
        position: const Offset(1430, 150),
        size: const Size(950, 420)), // 2796x1290
    ViewSetting(
        position: const Offset(690, 85),
        size: const Size(550, 260)), // 1334x750
  ],
  [
    // おんぷゲーム２ 鍵盤
    ViewSetting(
        position: const Offset(80, 750),
        size: const Size(1000, 480)), // 2266x1488
    ViewSetting(
        position: const Offset(80, 1000),
        size: const Size(1250, 560)), // 2732x2048
    ViewSetting(
        position: const Offset(400, 650),
        size: const Size(950, 420)), // 2796x1290
    ViewSetting(
        position: const Offset(100, 370),
        size: const Size(550, 260)), // 1334x750
  ],
  [
    // おんぷゲーム１
    ViewSetting(
        position: const Offset(1170, 750),
        size: const Size(1000, 480)), // 2266x1488
    ViewSetting(
        position: const Offset(1400, 1000),
        size: const Size(1250, 560)), // 2732x2048
    ViewSetting(
        position: const Offset(1420, 650),
        size: const Size(950, 420)), // 2796x1290
    ViewSetting(
        position: const Offset(690, 370),
        size: const Size(550, 260)), // 1334x750
  ],
];

List<List<ViewSetting>> _menu4ButtonSetting = [
  [
    // おんぷゲーム２ 鍵盤
    ViewSetting(
        position: const Offset(80, 200),
        size: const Size(1050, 420)), // 2266x1488
    ViewSetting(
        position: const Offset(70, 350),
        size: const Size(1240, 570)), // 2732x2048
    ViewSetting(
        position: const Offset(420, 150),
        size: const Size(940, 410)), // 2796x1290
    ViewSetting(
        position: const Offset(100, 75),
        size: const Size(550, 240)), // 1334x750
  ],
  [
    // おんぷゲーム１
    ViewSetting(
        position: const Offset(1170, 200),
        size: const Size(1050, 420)), // 2266x1488
    ViewSetting(
        position: const Offset(1400, 350),
        size: const Size(1240, 570)), // 2732x2048
    ViewSetting(
        position: const Offset(1430, 150),
        size: const Size(940, 410)), // 2796x1290
    ViewSetting(
        position: const Offset(680, 75),
        size: const Size(550, 240)), // 1334x750
  ],
  [
    // おんぷゲーム２ 鍵盤
    ViewSetting(
        position: const Offset(80, 700),
        size: const Size(1050, 420)), // 2266x1488
    ViewSetting(
        position: const Offset(70, 1000),
        size: const Size(1240, 570)), // 2732x2048
    ViewSetting(
        position: const Offset(420, 600),
        size: const Size(940, 410)), // 2796x1290
    ViewSetting(
        position: const Offset(100, 350),
        size: const Size(550, 240)), // 1334x750
  ],
  [
    // おんぷゲーム１
    ViewSetting(
        position: const Offset(1170, 700),
        size: const Size(1050, 420)), // 2266x1488
    ViewSetting(
        position: const Offset(1400, 1000),
        size: const Size(1240, 570)), // 2732x2048
    ViewSetting(
        position: const Offset(1430, 600),
        size: const Size(940, 410)), // 2796x1290
    ViewSetting(
        position: const Offset(680, 350),
        size: const Size(550, 240)), // 1334x750
  ],
  [
    // おんぷゲーム２ 鍵盤
    ViewSetting(
        position: const Offset(80, 1200),
        size: const Size(1050, 420)), // 2266x1488
    ViewSetting(
        position: const Offset(70, 1650),
        size: const Size(1240, 570)), // 2732x2048
    ViewSetting(
        position: const Offset(420, 1100),
        size: const Size(940, 410)), // 2796x1290
    ViewSetting(
        position: const Offset(100, 620),
        size: const Size(550, 240)), // 1334x750
  ],
  [
    // おんぷゲーム１
    ViewSetting(
        position: const Offset(1170, 1200),
        size: const Size(1050, 420)), // 2266x1488
    ViewSetting(
        position: const Offset(1400, 1650),
        size: const Size(1240, 570)), // 2732x2048
    ViewSetting(
        position: const Offset(1430, 1100),
        size: const Size(940, 410)), // 2796x1290
    ViewSetting(
        position: const Offset(680, 620),
        size: const Size(550, 240)), // 1334x750
  ],
];

List<List<ViewSetting>> _menu5ButtonSetting = [
  [
    // おんぷゲーム２ 鍵盤
    ViewSetting(
        position: const Offset(80, 200),
        size: const Size(1000, 480)), // 2266x1488
    ViewSetting(
        position: const Offset(80, 320),
        size: const Size(1250, 560)), // 2732x2048
    ViewSetting(
        position: const Offset(420, 150),
        size: const Size(920, 420)), // 2796x1290
    ViewSetting(
        position: const Offset(110, 100),
        size: const Size(550, 260)), // 1334x750
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
        size: const Size(920, 420)), // 2796x1290
    ViewSetting(
        position: const Offset(690, 120),
        size: const Size(550, 260)), // 1334x750
  ],
];

ViewSetting getDoremiToButtonViewSetting(BuildContext context, int index) {
  if (index > _doremiToButtonSetting.length) {
    index = _doremiToButtonSetting.length - 1;
  }
  return getViewSetting(_doremiToButtonSetting[index], context);
}

ViewSetting getDoremiHeButtonViewSetting(BuildContext context, int index) {
  if (index > _doremiHeButtonSetting.length) {
    index = _doremiHeButtonSetting.length - 1;
  }
  return getViewSetting(_doremiHeButtonSetting[index], context);
}

ViewSetting getMenu2ButtonViewSetting(BuildContext context, int index) {
  if (index > _menu2ButtonSetting.length) {
    index = _menu2ButtonSetting.length - 1;
  }
  return getViewSetting(_menu2ButtonSetting[index], context);
}

ViewSetting getMenu3ButtonViewSetting(BuildContext context, int index) {
  if (index > _menu3ButtonSetting.length) {
    index = _menu3ButtonSetting.length - 1;
  }
  return getViewSetting(_menu3ButtonSetting[index], context);
}

ViewSetting getMenu4ButtonViewSetting(BuildContext context, int index) {
  if (index > _menu4ButtonSetting.length) {
    index = _menu4ButtonSetting.length - 1;
  }
  return getViewSetting(_menu4ButtonSetting[index], context);
}

ViewSetting getMenu5ButtonViewSetting(BuildContext context, int index) {
  if (index > _menu5ButtonSetting.length) {
    index = _menu5ButtonSetting.length - 1;
  }
  return getViewSetting(_menu5ButtonSetting[index], context);
}
