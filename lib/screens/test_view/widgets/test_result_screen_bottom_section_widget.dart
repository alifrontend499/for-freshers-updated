import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/consts/test_view_screen_consts.dart';

// -- screen
import 'package:forfreshers_app/screens/test_view/helpers/test_view_helpers.dart';
import 'package:forfreshers_app/screens/test_view/styles/screen_styles.dart';

Widget testViewTestResultBottomSectionWidget(
  TestViewSelectedAnswersDataModel selectedAnswersData,
  final int passPercentage,
  Function onRetryBtnPress,
  Function onExploreBtnPress,
) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // child | button | retry test
        if (selectedAnswersData.rightAnswersPercentage < passPercentage) ...[
          ElevatedButton(
            onPressed: () => onRetryBtnPress(),
            style: testViewTestResultScreenRetryTestsBtnStyles,
            child: Text(
              TEST_VIEW_TEST_RESULT_SCREEN_CONST_RETRY_TEST_BUTTON_TEXT,
            ),
          ),
          const SizedBox(height: 15),
        ],

        // child | button | explore test
        ElevatedButton(
          onPressed: () => onExploreBtnPress(),
          style: testViewTestResultScreenExploreOtherTestsBtnStyles,
          child: Text(
            TEST_VIEW_TEST_RESULT_SCREEN_CONST_EXPLORE_OTHER_TESTS_TEXT,
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
