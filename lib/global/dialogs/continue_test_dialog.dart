import 'package:flutter/material.dart';
import 'package:forfreshers_app/global/models/test_models.dart';

// -- global
import 'package:forfreshers_app/global/styles/app_styles.dart';
import 'package:forfreshers_app/global/consts/app_consts.dart';
import 'package:forfreshers_app/global/colors/app_colors.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';
import 'package:forfreshers_app/screens/test_view/test_view_screen.dart';
import 'package:forfreshers_app/utilities/helpers/app_helpers.dart';
import 'package:forfreshers_app/utilities/helpers/saving_tests_progress_helpers.dart';

// -- utilities
import 'package:forfreshers_app/utilities/helpers/tests_helpers.dart';
import 'package:forfreshers_app/utilities/routing/routing_consts.dart';

class ContinueTestDialog extends StatelessWidget {
  final InCompleteTestsDataModel inCompleteTestDetails;
  final TestModel onGoingTest;
  final bool mounted;

  const ContinueTestDialog({
    Key? key,
    required this.inCompleteTestDetails,
    required this.onGoingTest,
    required this.mounted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime lastAttemptedOn =
        inCompleteTestDetails.selectedAnswers.last.selectedOn;

    return SimpleDialog(
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.all(20),
      children: [
        // child | heading
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              APP_CONST_DIALOG_CONTINUE_TEST_HEADING,
              style: appDialogStartingTestOverHeadeingStyles,
            ),
          ],
        ),
        const SizedBox(height: 10),

        // child | description
        Text(
          APP_CONST_DIALOG_CONTINUE_TEST_DESCRIPTION(
              getDateHelper(lastAttemptedOn)),
          style: appDialogStartingTestOverDescriptionStyles,
        ),
        const SizedBox(height: 20),

        // child | button | get premium
        ElevatedButton(
          onPressed: () async {
            if (mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TestViewScreen(
                    isTestContinued: true,
                    inCompleteTestDetails: inCompleteTestDetails,
                  ),
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            minimumSize: const Size(
              double.infinity,
              appSettingsDefaultButtonHeight,
            ),
            backgroundColor: appColorPrimary,
            splashFactory: NoSplash.splashFactory,
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text(APP_CONST_DIALOG_CONTINUE_TEST_BTN_TEXT_CONTINUE),
        ),
        const SizedBox(height: 15),

        Column(
          children: [
            InkWell(
              onTap: () async {
                // deleting current test
                await deleteInCompleteTestHelper(onGoingTest.testId);

                if (mounted) {
                  // navigating to test view screen
                  Navigator.pushNamed(context, testViewScreenRoute);
                }
              },
              highlightColor: appColorInkWellHighlight,
              borderRadius: BorderRadius.circular(5),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                child: Text(
                  APP_CONST_DIALOG_CONTINUE_TEST_TEXT_START_OVER,
                  textAlign: TextAlign.center,
                  style: appDialogOkBtnStyles,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
