import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/colors/app_colors.dart';
import 'package:forfreshers_app/global/consts/app_consts.dart';
import 'package:forfreshers_app/global/models/test_models.dart';
import 'package:forfreshers_app/global/styles/app_styles.dart';
import 'package:forfreshers_app/screens/test_summary/test_summary_screen.dart';

// -- utilities
import 'package:forfreshers_app/utilities/helpers/app_helpers.dart';

// -- packages
import 'package:page_transition/page_transition.dart';

Widget testDetailsScreenCompletedTestDetailsWidget(BuildContext context, CompletedTestModel completedTest) => Row(
  children: [
    // child: left sec
    Expanded(
      child: Row(
        children: [
          const Text(
            "Completed on : ",
            style: TextStyle(
              // fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            getDateHelper(completedTest.completedOn),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    ),

    // child: left sec
    InkWell(
      onTap: () => Navigator.of(context).push(
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: TestSummaryScreen(
            completedTestModal: completedTest,
          ),
        ),
      ),
      highlightColor: appColorInkWellHighlight,
      borderRadius: BorderRadius.circular(5),
      child: const Padding(
        padding: EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 8,
        ),
        child: Text(
          APP_CONST_VIEW_TEST_SUMMARY,
          style: appLinkTextSmallStyles,
        ),
      ),
    ),
  ],
);