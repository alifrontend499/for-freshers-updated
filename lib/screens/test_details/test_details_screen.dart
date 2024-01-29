import 'package:flutter/material.dart';

// -- packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forfreshers_app/global/dialogs/continue_test_dialog.dart';

// -- global
import 'package:forfreshers_app/global/models/test_models.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';
import 'package:forfreshers_app/global/state/app_state.dart';
import 'package:forfreshers_app/global/styles/app_styles.dart';
import 'package:forfreshers_app/global/colors/app_colors.dart';
import 'package:forfreshers_app/global/consts/test_details_screen_consts.dart';
import 'package:forfreshers_app/global/dialogs/starting_test_over_dialog.dart';

// -- screen
import 'package:forfreshers_app/screens/test_details/components/app_bar/app_bar.dart';
import 'package:forfreshers_app/screens/test_details/styles/screen_styles.dart';
import 'package:forfreshers_app/screens/test_details/widgets/completed_test_details_widget.dart';
import 'package:forfreshers_app/screens/test_details/widgets/incomplete_test_details_widget.dart';
import 'package:forfreshers_app/screens/test_details/widgets/test_all_details_widget.dart';
import 'package:forfreshers_app/utilities/helpers/saving_tests_progress_helpers.dart';
import 'package:forfreshers_app/utilities/helpers/tests_helpers.dart';

// -- utilities
import 'package:forfreshers_app/utilities/routing/routing_consts.dart';

class TestDetailsScreen extends ConsumerStatefulWidget {
  const TestDetailsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TestDetailsScreen> createState() => _TestDetailsScreenState();
}

class _TestDetailsScreenState extends ConsumerState<TestDetailsScreen> {
  bool isTestAlreadyCompleted = false;
  bool isTestWasNotCompletedEarlier = false;
  InCompleteTestsDataModel? inCompleteTestDetails;
  late CompletedTestModel completedTest;

  @override
  void initState() {
    super.initState();

    checkIfTestAlreadyCompleted();
    checkIfTestIsIncomplete();
  }

  // checking if test has already been completed
  Future<void> checkIfTestAlreadyCompleted() async {
    final TestModel? onGoingTest = ref.read(ongoingTestProvider);
    if (onGoingTest != null) {
      final String onGoingTestId = onGoingTest.testId;
      final isTestExist = await checkIfCompletedTestExistHelper(onGoingTestId);
      final CompletedTestModel? completedTestRaw =
          await getCompletedTestByIdHelper(onGoingTestId);
      if (isTestExist && completedTestRaw != null) {
        setState(() {
          isTestAlreadyCompleted = isTestExist;
          completedTest = completedTestRaw;
        });
      }
    } else {
      setState(() {
        isTestAlreadyCompleted = false;
      });
    }
  }

  // checking if test has already been selected by user and not completed last time
  Future<void> checkIfTestIsIncomplete() async {
    final TestModel? onGoingTest = ref.read(ongoingTestProvider);
    if (onGoingTest != null) {
      final bool isTextExist =
          await isInCompleteTestExistHelper(onGoingTest.testId);
      final InCompleteTestsDataModel? inCompleteTestDetailsRaw =
          await getInCompleteTestByIdHelper(onGoingTest.testId);
      setState(() {
        isTestWasNotCompletedEarlier = isTextExist;
        inCompleteTestDetails = inCompleteTestDetailsRaw;
      });
    } else {
      setState(() {
        isTestWasNotCompletedEarlier = false;
      });
    }
  }

  Future<void> handleTestClicked() async {
    final TestModel? onGoingTest = ref.read(ongoingTestProvider);
    if (isTestAlreadyCompleted) {
      // showing dialog
      showDialog(
        context: context,
        builder: (context) => StartingTestOverDialog(
          testId: completedTest.testDetails.testId,
        ),
      );
      return;
    }
    if (isTestWasNotCompletedEarlier &&
        inCompleteTestDetails != null &&
        onGoingTest != null) {
      // showing dialog
      showDialog(
        context: context,
        builder: (context) => ContinueTestDialog(
          inCompleteTestDetails: inCompleteTestDetails!,
          onGoingTest: onGoingTest,
          mounted: mounted,
        ),
      );
      return;
    }

    if (mounted) {
      Navigator.pushNamed(context, testViewScreenRoute);
    }
  }

  // func: to get button text
  String getButtonText() {
    // if test is already completed
    if (isTestAlreadyCompleted) {
      return TEST_DETAILS_SCREEN_CONSTS_SUBMIT_BTN_TEXT_START_OVER;
    } else if (isTestWasNotCompletedEarlier) {
      return TEST_DETAILS_SCREEN_CONSTS_SUBMIT_BTN_TEXT_CONTINUE_TEST;
    } else {
      return TEST_DETAILS_SCREEN_CONSTS_SUBMIT_BTN_TEXT;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TestModel? onGoingTest = ref.read(ongoingTestProvider);

    return Scaffold(
      appBar: getPageAppBar(context, onGoingTest?.testName ?? ''),
      body: Padding(
        padding: appSettingsPagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // child | scroll view
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 20),
                physics: const BouncingScrollPhysics(),
                child: testDetailsScreenTestAllDetailsWidget(onGoingTest!),
              ),
            ),

            // child | buttons
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // if test is already completed
                  if (isTestAlreadyCompleted) ...[
                    testDetailsScreenCompletedTestDetailsWidget(
                      context,
                      completedTest,
                    ),
                    const SizedBox(height: 10),
                  ],

                  // if test is incomplete
                  if (isTestWasNotCompletedEarlier &&
                      inCompleteTestDetails != null) ...[
                    testDetailsScreenIncompleteTestDetailsWidget(
                      context,
                      inCompleteTestDetails!,
                    ),
                    const SizedBox(height: 10),
                  ],

                  // child | button start test
                  Opacity(
                    opacity: onGoingTest.totalQuestions == '0' ? .4 : 1,
                    child: ElevatedButton(
                      style: testDetailsSubmitBtnStyles,
                      onPressed: () {
                        if (onGoingTest.totalQuestions != '0') {
                          handleTestClicked();
                        }
                      },
                      child: Text(
                        onGoingTest.totalQuestions == '0'
                            ? 'No Questions'
                            : getButtonText(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // child | cancel test link
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, homeScreenRoute),
                    highlightColor: appColorInkWellHighlight,
                    borderRadius: BorderRadius.circular(5),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 8,
                      ),
                      child: Text(
                        TEST_DETAILS_SCREEN_CONSTS_OTHER_TESTS,
                        style: appLinkTextStyles,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
