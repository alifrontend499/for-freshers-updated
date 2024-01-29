import 'package:flutter/material.dart';

// -- packages
import 'package:page_transition/page_transition.dart';

// -- global
import 'package:forfreshers_app/global/colors/app_colors.dart';
import 'package:forfreshers_app/global/models/test_models.dart';

// -- screens
import 'package:forfreshers_app/screens/completed_tests/styles/screen_styles.dart';
import 'package:forfreshers_app/screens/test_summary/test_summary_screen.dart';

// -- utilities
import 'package:forfreshers_app/utilities/helpers/app_helpers.dart';

Widget completeTestsScreenCardWidget(
  BuildContext context,
  CompletedTestModel completedTestItem,
) =>
    InkWell(
      onTap: () => Navigator.of(context).push(
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: TestSummaryScreen(
            completedTestModal: completedTestItem,
          ),
        ),
      ),
      splashColor: Colors.transparent,
      highlightColor: appColorInkWellHighlight,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey.withOpacity(0.1),
          ),
          color: appColorLightGrey,
        ),
        child: Stack(
          children: [
            // child | content
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // child | heading
                cardHeadingWidget(completedTestItem),
                const SizedBox(height: 10),

                // child | description
                Text(
                  completedTestItem.testDetails.testDescription,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 15),

                // child | questions data
                questionDataWidget(completedTestItem),
              ],
            ),
          ],
        ),
      ),
    );

// heading widget
Widget cardHeadingWidget(
  CompletedTestModel completedTestItem,
) =>
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            getCapitalizeTextHelper(
              completedTestItem.testDetails.testName,
            ),
            style: completedTestCardHeadingStyles,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          getDateHelper(
            completedTestItem.completedOn,
          ),
          style: completedTestCardDateStyles,
        ),
      ],
    );

Widget questionDataWidget(
  CompletedTestModel completedTestItem,
) =>
    Row(
      children: [
        // child | total questions
        Text(
          "${completedTestItem.testDetails.totalQuestions} Questions Total",
          style: completedTestCardQuestionDataTotalQuestionStyles,
        ),
        const SizedBox(width: 10),

        // child | right questions
        Text(
          "${completedTestItem.rightAnswersCount} Right",
          style: completedTestCardQuestionDataRightQuestionStyles,
        ),
        const SizedBox(width: 10),

        // child | wrong questions
        Text(
          "${int.parse(completedTestItem.testDetails.totalQuestions) - completedTestItem.rightAnswersCount} Wrong",
          style: completedTestCardQuestionDataWrongQuestionStyles,
        ),
        const SizedBox(height: 5),
      ],
    );
