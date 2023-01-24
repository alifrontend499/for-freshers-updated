import 'package:flutter/material.dart';
import 'dart:convert';

// -- packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forfreshers_app/global/consts/test_view_screen_consts.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';
import 'package:forfreshers_app/screens/test_view/screens/test_view_test_result_screen.dart';
import 'package:forfreshers_app/screens/test_view/styles/screen_styles.dart';
import 'package:forfreshers_app/utilities/helpers/json_helpers.dart';
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
import 'package:forfreshers_app/screens/test_view/widgets/bottom_view_widget.dart';

// -- utilities
import 'package:forfreshers_app/utilities/helpers/app_snackbars.dart';
import 'package:forfreshers_app/utilities/apis/app_apis.dart';

class TestViewScreen extends ConsumerStatefulWidget {
  const TestViewScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TestViewScreen> createState() => _TestViewScreenState();
}

class _TestViewScreenState extends ConsumerState<TestViewScreen> {
  late PageController controller = PageController(initialPage: 0);
  late List<Widget> children = [];
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
      final responseData = responseBodyData['data']['quiz'];

      if (responseStatusCode == 200) {
        if (responseData.isNotEmpty) {
          final List<dynamic> questionsData = responseData['question'];
          final List<QuestionDataModel> questions = [];
          for (final questionItem in questionsData) {
            final Map<String, dynamic> convertedQuestionItem =
                convertQuestionDataModelJson(questionItem);
            questions.add(QuestionDataModel.fromJson(convertedQuestionItem));
          }

          // getting widgets list
          List<Widget> widgetsList =
              getTestScreenWidgetsHelper(questions, controller);

          // updating state
          setState(() {
            pagesCount = questions.length;
            children = widgetsList;
            currentPage = 0;
          });
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
    if (isAnswerSelected) {
      if (currentPage < (pagesCount - 1)) {
        // setting current page
        setState(() => currentPage = currentPage + 1);

        // changing page
        controller.jumpToPage(currentPage);

        // setting global button enable/disable
        ref.read(isAnswerSelectedProvider.notifier).state = false;
      } else {
        // getting answers data
        final TestViewSelectedAnswersDataModel selectedAnswersData =
            calculatingAnswersDataHelper(ref);

        // saving completed test details
        final CompletedTestModel completedTestDetails =
            saveCompletedTestDetailsHelper(ref, selectedAnswersData);

        // setting completed test
        await setCompletedTestHelper(completedTestDetails);

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
