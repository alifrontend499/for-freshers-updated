import 'package:flutter/material.dart';

// -- packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

// -- global
import 'package:forfreshers_app/global/models/test_models.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';

// -- screens
import 'package:forfreshers_app/screens/test_view/components/test_result_screen_app_bar.dart';
import 'package:forfreshers_app/screens/test_view/helpers/test_view_helpers.dart';
import 'package:forfreshers_app/screens/test_view/widgets/test_result_screen_bottom_section_widget.dart';
import 'package:forfreshers_app/screens/test_view/widgets/test_result_screen_header_widget.dart';
import 'package:forfreshers_app/screens/test_view/widgets/test_result_screen_progress_widget.dart';
import 'package:forfreshers_app/screens/test_view/widgets/test_result_screen_tests_more_info_widget.dart';

// -- utilities
import 'package:forfreshers_app/utilities/helpers/app_helpers.dart';
import 'package:forfreshers_app/utilities/helpers/state_helpers.dart';
import 'package:forfreshers_app/utilities/helpers/tests_helpers.dart';
import 'package:forfreshers_app/utilities/routing/routing_consts.dart';

class TestViewTestResultScreen extends ConsumerStatefulWidget {
  final TestViewSelectedAnswersDataModel selectedAnswersData;
  final int passPercentage;
  final CompletedTestModel completedTestDetails;

  const TestViewTestResultScreen({
    Key? key,
    required this.selectedAnswersData,
    required this.passPercentage,
    required this.completedTestDetails,
  }) : super(key: key);

  @override
  ConsumerState<TestViewTestResultScreen> createState() =>
      _TestViewTestResultScreenState();
}

class _TestViewTestResultScreenState
    extends ConsumerState<TestViewTestResultScreen> {
  // on retry btn press
  Future<void> onRetryBtnPress() async {
    // deleting test from storage (completed test list)
    await deleteSingleCompletedTestHelper(
      widget.completedTestDetails.testDetails.testId,
    );

    // deleting selected answer state
    retryTestGlobalHelper(ref);

    if (mounted) {
      // navigating to test
      Navigator.pushNamed(
        context,
        testViewScreenRoute,
      );
    }
  }

  void onExploreBtnPress() {
    // deleting selected answer state
    testCompleteGlobalHelper(ref);

    // navigating to home
    Navigator.pushNamedAndRemoveUntil(
      context,
      homeScreenRoute,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getTestResultAppBar(context),
      body: WillPopScope(
        onWillPop: onWillPopHelper,
        child: Container(
          padding: appSettingsPagePadding,
          child: Column(
            children: [
              // child | main content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      // child | header
                      testViewTestResultScreenHeaderWidget(
                        widget.selectedAnswersData.rightAnswersPercentage,
                      ),
                      const SizedBox(height: 30),

                      // child | progress circle
                      testViewTestResultProgressWidget(
                        widget.selectedAnswersData,
                      ),
                      const SizedBox(height: 25),

                      // child | test's more info
                      testViewTestResultTestsMoreInfo(
                        context,
                        widget.selectedAnswersData,
                        widget.passPercentage,
                        widget.completedTestDetails,
                      ),
                    ],
                  ),
                ),
              ),

              // child | bottom section
              testViewTestResultBottomSectionWidget(
                widget.selectedAnswersData,
                widget.passPercentage,
                onRetryBtnPress,
                onExploreBtnPress,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
