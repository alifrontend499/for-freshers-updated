import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/screens/test_view/styles/screen_styles.dart';

// -- screens
import 'package:forfreshers_app/global/consts/test_view_screen_consts.dart';

Widget testViewTestResultScreenHeaderWidget(
    double rightAnswersPercentage
) => Column(
  children: [
    Text(
      TEST_VIEW_TEST_RESULT_SCREEN_CONST_HEADING1,
      textAlign: TextAlign.center,
      style: testViewTestResultScreenHeading1Styles,
    ),
    const SizedBox(height: 10),
    Text(
      TEST_VIEW_TEST_RESULT_SCREEN_CONST_HEADING2(
          rightAnswersPercentage.round().toString()),
      textAlign: TextAlign.center,
      style: testViewTestResultScreenHeading2Styles,
    ),
  ],
);