/*import 'package:flutter/material.dart';
import 'package:onpu/page_state/line_space_c_page_state.dart';
import 'package:onpu/setting.dart';
import 'package:onpu/widget/onpu_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// onpu2_page.dartの設定分けで良いかも
class LineSpaceCPage extends StatelessWidget {
  const LineSpaceCPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.red,
            width: 2,
          ),
        ),
        alignment: Alignment.center,
        width: 2266 / 2,
        height: 1488 / 2,
        child: Stack(
          children: [
            ...fiveLinesC.map(
              // デバッグ用表示
              (line) => Positioned(
                width: 2266 / 4,
                height: 10,
                left: line.dx,
                top: line.dy,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  alignment: Alignment.center,
                ),
              ),
            ),
            Consumer(
              builder: (context, WidgetRef ref, child) {
                final isCompleted = ref
                    .read(lineSpaceCPageNotifierProvider.notifier)
                    .isCompleted();
                final level = ref.watch(lineSpaceCPageNotifierProvider
                        .select((state) => state.level)) -
                    (isCompleted ? 1 : 0);

                bool lineType = lineSpaceQuestions[level].lineType;
                List<LineSpaceCButtonSetting> state =
                    lineType ? lineButtons : spaceButtons;

                double top = 220;
                if (lineType) {
                  top += (4 - lineSpaceQuestions[level].correctIndex) * 70 - 30;
                } else {
                  top += (3 - lineSpaceQuestions[level].correctIndex) * 70 + 5;
                }

                return Stack(
                  children: [
                    Positioned(
                      // デバッグ用表示
                      left: 250,
                      top: top,
                      child: Container(
                        width: 70,
                        height: 70,
                        alignment: Alignment.center,
                        color: Colors.red.withOpacity(0.5),
                      ),
                    ),
                    ...state.map(
                      (button) => Positioned(
                        child: OnpuButton(
                          onTap: isCompleted
                              ? null
                              : () {
                                  ref
                                      .read(lineSpaceCPageNotifierProvider
                                          .notifier)
                                      .checkCorrect(button.index);
                                },
                          icon: false,
                          position: button.position,
                          buttonSize: const Size(300, 70),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
*/