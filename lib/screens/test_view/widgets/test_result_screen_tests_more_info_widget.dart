import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/colors/app_colors.dart';
import 'package:forfreshers_app/global/consts/test_view_screen_consts.dart';
import 'package:forfreshers_app/global/models/test_models.dart';
import 'package:forfreshers_app/global/styles/app_styles.dart';

// -- screens
import 'package:forfreshers_app/screens/test_summary/test_summary_screen.dart';

// -- screen
import 'package:forfreshers_app/screens/test_view/helpers/test_view_helpers.dart';
import 'package:forfreshers_app/screens/test_view/styles/screen_styles.dart';
import 'package:page_transition/page_transition.dart';

Widget testViewTestResultTestsMoreInfo(
  BuildContext context,
  TestViewSelectedAnswersDataModel selectedAnswersData,
  int passPercentage,
  CompletedTestModel completedTestDetails,
) =>
    Column(
      children: [
        // child | test passed or failed
        Text(
          selectedAnswersData.rightAnswersPercentage > passPercentage
              ? TEST_VIEW_TEST_RESULT_SCREEN_CONST_TEST_PASSED_TEXT
              : TEST_VIEW_TEST_RESULT_SCREEN_CONST_TEST_FAILED_TEXT,
          textAlign: TextAlign.center,
          style: testViewTestResultScreenTestPassOrFailTextStyles(
            selectedAnswersData.rightAnswersPercentage > passPercentage,
          ),
        ),
        const SizedBox(height: 8),

        // child | test passed or failed message
        Text(
          selectedAnswersData.rightAnswersPercentage > passPercentage
              ? TEST_VIEW_TEST_RESULT_SCREEN_CONST_TEST_PASSED_MSG(
                  selectedAnswersData.rightAnswersPercentage.toString(),
                )
              : TEST_VIEW_TEST_RESULT_SCREEN_CONST_TEST_FAILED_MSG(
                  passPercentage.toString()),
          textAlign: TextAlign.center,
          style: testViewTestResultScreenTestPassOrFailMsgStyles,
        ),
        const SizedBox(height: 15),

        // child | test summary link
        InkWell(
          onTap: () => Navigator.of(context).push(
            PageTransition(
              type: PageTransitionType.rightToLeft,
              child: TestSummaryScreen(
                completedTestModal: completedTestDetails,
              ),
            ),
          ),
          highlightColor: appColorInkWellHighlight,
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 9),
            child: Text(
              TEST_VIEW_TEST_RESULT_SCREEN_CONST_TEST_SUMMARY_TEXT,
              style: appLinkTextStyles,
            ),
          ),
        ),
      ],
    );
