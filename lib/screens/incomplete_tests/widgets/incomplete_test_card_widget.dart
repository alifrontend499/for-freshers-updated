import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forfreshers_app/global/state/app_state.dart';
import 'package:forfreshers_app/utilities/routing/routing_consts.dart';

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

Widget incompleteTestsScreenCardWidget(
  BuildContext context,
  InCompleteTestsDataModel incompleteTestItem,
  WidgetRef ref,
) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Colors.grey.withOpacity(0.1),
      ),
      color: appColorLightGrey,
    ),
    padding: const EdgeInsets.only(
      top: 9,
      bottom: 9,
      left: 15,
      right: 9,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // temp
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                incompleteTestItem.testName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: appColorPrimary,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        incompleteTestItem.totalQuestions,
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Completed",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: appColorPrimary,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        incompleteTestItem.selectedAnswers.length.toString(),
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        InkWell(
          onTap: () async {
            final TestModel testDetails = TestModel(
              testId: incompleteTestItem.testId,
              testType: incompleteTestItem.testType,
              testName: incompleteTestItem.testName,
              totalQuestions: incompleteTestItem.totalQuestions,
              testDescription: incompleteTestItem.testDescription,
              isTestPremium: incompleteTestItem.isTestPremium,
              testImg: incompleteTestItem.testImg,
            );
            ref.watch(ongoingTestProvider.notifier).state = testDetails;

            Navigator.pushNamed(context, testDetailsScreenRoute);
          },
          highlightColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              color: appColorPrimary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.play_circle,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
