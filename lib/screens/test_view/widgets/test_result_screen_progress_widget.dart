import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/colors/app_colors.dart';
import 'package:forfreshers_app/global/consts/test_view_screen_consts.dart';

// -- screen
import 'package:forfreshers_app/screens/test_view/helpers/test_view_helpers.dart';
import 'package:forfreshers_app/screens/test_view/styles/screen_styles.dart';

Widget testViewTestResultProgressWidget(
  TestViewSelectedAnswersDataModel selectedAnswersData,
) =>
    Stack(
      children: [
        // circular progress
        SizedBox(
          height: 160,
          width: 160,
          child: CircularProgressIndicator(
            value: selectedAnswersData.rightAnswersPercentage / 100,
            valueColor: const AlwaysStoppedAnimation(
              appColorPrimary,
            ),
            backgroundColor: Colors.black12,
            strokeWidth: 9,
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${selectedAnswersData.rightAnswersCount}',
                      style: testViewTestResultScreenProgressCircleTextStyles(
                        25,
                        FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 1),
                    Text(
                      '/',
                      style: testViewTestResultScreenProgressCircleTextStyles(
                        23,
                        FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 1),
                    Text(
                      '${selectedAnswersData.totalAnswersCount}',
                      style: testViewTestResultScreenProgressCircleTextStyles(
                        19,
                        FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  TEST_VIEW_TEST_RESULT_SCREEN_CONST_RIGHT_QUESTIONS_TEXT,
                  style:
                      testViewTestResultScreenProgressRightQuestionsTextStyles,
                ),
              ],
            ),
          ),
        ),
      ],
    );
