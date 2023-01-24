import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/models/test_models.dart';

// -- screen
import 'package:forfreshers_app/screens/test_summary/styles/screen_styles.dart';

Widget testSummaryScreenHeaderWidget(
    CompletedTestModel completedTestModal
) => Text(
  completedTestModal.testName,
  style: testSummaryScreenAppBarTitleStyles,
);