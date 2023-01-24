import 'package:flutter/material.dart';

// -- packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
import 'package:forfreshers_app/screens/test_details/widgets/test_all_details_widget.dart';
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
  late CompletedTestModel completedTest;

  @override
  void initState() {
    super.initState();

    checkIfTestAlreadyCompleted();
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

                  // child | button start test
                  ElevatedButton(
                    style: testDetailsSubmitBtnStyles,
                    onPressed: () {
                      if (isTestAlreadyCompleted) {
                        // showing dialog
                        showDialog(
                          context: context,
                          builder: (context) => StartingTestOverDialog(
                            testId: completedTest.testId,
                          ),
                        );
                      } else {
                        Navigator.pushNamed(context, testViewScreenRoute);
                      }
                    },
                    child: Text(isTestAlreadyCompleted
                        ? TEST_DETAILS_SCREEN_CONSTS_SUBMIT_BTN_TEXT_START_OVER
                        : TEST_DETAILS_SCREEN_CONSTS_SUBMIT_BTN_TEXT),
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
