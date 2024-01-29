import 'package:flutter/material.dart';
import 'dart:convert';

// -- packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

// -- global
import 'package:forfreshers_app/global/consts/test_view_screen_consts.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';
import 'package:forfreshers_app/screens/test_view/screens/test_view_test_result_screen.dart';
import 'package:forfreshers_app/screens/test_view/styles/screen_styles.dart';

// -- utilities
import 'package:forfreshers_app/utilities/helpers/json_helpers.dart';
import 'package:forfreshers_app/utilities/helpers/saving_tests_progress_helpers.dart';
import 'package:forfreshers_app/utilities/helpers/state_helpers.dart';
import 'package:forfreshers_app/utilities/helpers/tests_helpers.dart';
import 'package:http/http.dart' as http;

// -- global
import 'package:forfreshers_app/global/dialogs/cancel_test_dialog.dart';
import 'package:forfreshers_app/global/state/app_state.dart';

import 'package:forfreshers_app/global/models/test_models.dart';

// -- screen
import 'package:forfreshers_app/screens/test_view/components/app_bar/app_bar.dart';
import 'package:forfreshers_app/screens/test_view/components/content_loading.dart';
import 'package:forfreshers_app/screens/test_view/helpers/test_view_helpers.dart';

// -- utilities
import 'package:forfreshers_app/utilities/helpers/app_snackbars.dart';
import 'package:forfreshers_app/utilities/apis/app_apis.dart';

class TestViewScreen extends ConsumerStatefulWidget {
  final bool isTestContinued;
  final InCompleteTestsDataModel? inCompleteTestDetails;

  const TestViewScreen({
    Key? key,
    this.isTestContinued = false,
    this.inCompleteTestDetails,
  }) : super(key: key);

  @override
  ConsumerState<TestViewScreen> createState() => _TestViewScreenState();
}

class _TestViewScreenState extends ConsumerState<TestViewScreen> {
  late PageController controller = PageController(initialPage: 0);
  late List<Widget> children = [];
  late List<QuestionDataModel> allQuestions = [];
  late int pagesCount = 0;
  int currentPage = 0;
  bool contentLoading = false;

  // for result screen
  int passPercentage = 80;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // getting questions
    getTestQuestions();

    // initial checks
    initialStateSetup();
  }

  // initializing initial state
  Future<void> initialStateSetup() async {
    // setting default for | setting global button enable/disable
    ref.read(isAnswerSelectedProvider.notifier).state = false;
    ref.read(isAnswerSelectedProvider.notifier).state = false;
  }

  // getting questions data from network
  Future<void> getTestQuestions() async {
    // loading
    setState(() => contentLoading = true);

    try {
      final onGoingTest = ref.read(ongoingTestProvider);
      final response = await http.get(
        Uri.parse(
          apiGetTestQuestionsDetails(onGoingTest?.testId ?? ''),
        ),
      );
      final responseStatusCode = response.statusCode;
      final responseBody = response.body;
      final responseBodyData = jsonDecode(responseBody);
      final responseData = responseBodyData['data'];

      if (responseStatusCode == 200) {
        if (responseData.isNotEmpty) {
          final List<dynamic> questionsData = responseData['question'];
          final List<QuestionDataModel> questions = [];
          for (final questionItem in questionsData) {
            final Map<String, dynamic> convertedQuestionItem =
                convertQuestionDataModelJson(questionItem['question']);
            questions.add(QuestionDataModel.fromJson(convertedQuestionItem));
          }

          // generating views
          List<Widget> widgetsList = getTestScreenWidgetsHelper(
            questions,
            controller,
          );

          // getting widgets list
          // if test already attempted earlier
          if (widget.isTestContinued && widget.inCompleteTestDetails != null) {
            final InCompleteTestsDataModel inCompleteTestDetails =
                widget.inCompleteTestDetails!;

            final int completedQuestionsCount =
                inCompleteTestDetails.selectedAnswers.length;

            // setting global state for selected answer
            updateAllSelectedAnswersProviderGlobalHelper(
              ref,
              inCompleteTestDetails.selectedAnswers,
            );

            // moving to the page after the last completed questions
            setState(
              () {
                controller = PageController(
                  initialPage: completedQuestionsCount,
                );
                currentPage = completedQuestionsCount;
                allQuestions = questions;
                pagesCount = questions.length;
                children = widgetsList;
              },
            );
          } else {
            setState(() {
              currentPage = 0;
              allQuestions = questions;
              pagesCount = questions.length;
              children = widgetsList;
            });
          }
        }
      } else {
        // showing error message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(appSnackBarApiError);
        }
      }
    } catch (err) {
      // ignore: avoid_print
      print('err occurred on TestDetailsScreen $err');
      // showing error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(appSnackBarApiError);
      }
    }

    // loading
    setState(() => contentLoading = false);
  }

  // on back pressed
  Future<bool> onWillPop() async {
    showDialog(
      context: context,
      builder: (context) => CancelTestDialog(parentRef: ref),
    );
    return false;
  }

  // when user clicks on next or submit
  Future<void> onScreenButtonPresses() async {
    final bool isAnswerSelected = ref.watch(isAnswerSelectedProvider);
    final TestModel? onGoingTestData = ref.read(ongoingTestProvider);
    if (onGoingTestData != null) {
      final TestModel onGoingTest = onGoingTestData;
      final List<SelectedAnswerModel> selectedAnswers =
          ref.read(selectedAnswersProvider);
      if (isAnswerSelected) {
        // -- if it's not the last question
        if (currentPage < (pagesCount - 1)) {
          // setting current page
          setState(() => currentPage = currentPage + 1);

          // changing page
          controller.jumpToPage(currentPage);

          // saving question in the incomplete tests
          final InCompleteTestsDataModel dataToSaveFoIncompleteTest =
              InCompleteTestsDataModel(
            testId: onGoingTest.testId,
            testType: onGoingTest.testType,
            testName: onGoingTest.testName,
            totalQuestions: onGoingTest.totalQuestions,
            testDescription: onGoingTest.testDescription,
            isTestPremium: onGoingTest.isTestPremium,
            testImg: onGoingTest.testImg,
            selectedAnswers: [selectedAnswers.last],
          );

          await setInCompleteTestHelper(dataToSaveFoIncompleteTest);

          // disabling submit button
          ref.read(isAnswerSelectedProvider.notifier).state = false;
        } else {
          // when it's the last question
          // getting selected answers data
          final TestViewSelectedAnswersDataModel selectedAnswersData =
              calculatingAnswersDataHelper(ref);

          // saving completed test details
          final CompletedTestModel completedTestDetails =
              saveCompletedTestDetailsHelper(ref, selectedAnswersData);

          // setting completed test
          await setCompletedTestHelper(completedTestDetails);

          // delete test from incomplete tests list if the user completes the test
          deleteInCompleteTestHelper(onGoingTest?.testId ?? '');

          // moving to result page
          if (mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TestViewTestResultScreen(
                  selectedAnswersData: selectedAnswersData,
                  passPercentage: passPercentage,
                  completedTestDetails: completedTestDetails,
                ),
              ),
            );
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isAnswerSelected = ref.watch(isAnswerSelectedProvider);
    final TestModel? onGoingTest = ref.read(ongoingTestProvider);

    return Scaffold(
      appBar: getPageAppBar(
        context,
        onGoingTest?.testName ?? '',
        ref,
        contentLoading,
      ),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: contentLoading
            ? testViewScreenContentLoading()
            : Column(
                children: [
                  // child | page view
                  Expanded(
                    child: PageView(
                      controller: controller,
                      physics: const NeverScrollableScrollPhysics(),
                      children: children,
                    ),
                  ),

                  // child | bottom view
                  Padding(
                    padding: appSettingsPagePadding,
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: testViewBottomViewButtonStyles(
                                isAnswerSelected),
                            onPressed: onScreenButtonPresses,
                            child: currentPage == (pagesCount - 1)
                                ? Text(
                                    TEST_VIEW_SCREEN_CONST_BUTTON_SUBMIT_TEXT,
                                  )
                                : Text(
                                    TEST_VIEW_SCREEN_CONST_BUTTON_NEXT_TEXT,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
      ),
    );
  }
}
