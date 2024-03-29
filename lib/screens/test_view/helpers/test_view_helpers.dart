import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forfreshers_app/global/models/test_models.dart';
import 'package:forfreshers_app/global/state/app_state.dart';
import 'package:forfreshers_app/screens/test_view/screens/test_view_test_screen.dart';
import 'package:forfreshers_app/utilities/helpers/app_helpers.dart';

// getting data from the selection answers like questions total, questions right and percentage
// model
class TestViewSelectedAnswersDataModel {
  final int totalAnswersCount;
  final int rightAnswersCount;
  final double rightAnswersPercentage;

  TestViewSelectedAnswersDataModel({
    required this.totalAnswersCount,
    required this.rightAnswersCount,
    required this.rightAnswersPercentage,
  });
}

// function
TestViewSelectedAnswersDataModel calculatingAnswersDataHelper(
  WidgetRef ref,
) {
  final List<SelectedAnswerModel> selectedAnswersList =
      ref.read(selectedAnswersProvider);
  final List<SelectedAnswerModel> rightAnswersList =
      selectedAnswersList.where((element) => element.wasRight == true).toList();
  final int totalAnswersCountRaw = selectedAnswersList.length;
  final int rightAnswersCountRaw = rightAnswersList.length;

  return TestViewSelectedAnswersDataModel(
    totalAnswersCount: totalAnswersCountRaw,
    rightAnswersCount: rightAnswersCountRaw,
    rightAnswersPercentage: getPercentageHelper(
      selectedAnswersList.length,
      rightAnswersList.length,
    ),
  );
}

// saving the completed test details
CompletedTestModel saveCompletedTestDetailsHelper(
  WidgetRef ref,
  TestViewSelectedAnswersDataModel selectedAnswersData,
) {
  final TestModel? onGoingTest = ref.read(ongoingTestProvider);
  final List<SelectedAnswerModel> selectedAnswers =
      ref.read(selectedAnswersProvider);
  final CompletedTestModel completedTest = CompletedTestModel(
    testDetails: TestModel(
      testId: onGoingTest!.testId,
      testType: onGoingTest!.testType,
      testName: onGoingTest!.testName,
      totalQuestions: onGoingTest!.totalQuestions,
      testDescription: onGoingTest!.testDescription,
      isTestPremium: onGoingTest!.isTestPremium,
      testImg: onGoingTest!.testImg,
    ),
    selectedAnswers: selectedAnswers,
    completedOn: DateTime.now(),
    rightAnswersCount: selectedAnswersData.rightAnswersCount,
  );
  return completedTest;
}

// remove already completed tests
List<QuestionDataModel> removeCompletedQuestions(
  List<QuestionDataModel> allQuestionsData,
  InCompleteTestsDataModel inCompleteTestDetails,
) {
  List<QuestionDataModel> questionsData = [];
  final List<SelectedAnswerModel> selectedAnswers =
      inCompleteTestDetails.selectedAnswers;
  for (final questionItem in allQuestionsData) {
    final bool isValid = selectedAnswers.any(
      (answerItem) => answerItem.questionId == questionItem.id,
    );
    if (!isValid) {
      questionsData.add(questionItem);
    }
  }
  return questionsData;
}

class RemoveCompletedQuestionsModel {
  final List<QuestionDataModel> allQuestionsData;
  final InCompleteTestsDataModel inCompleteTestDetails;

  RemoveCompletedQuestionsModel({
    required this.allQuestionsData,
    required this.inCompleteTestDetails,
  });

  // get questions after removing all the completed questions
  List<QuestionDataModel> get getQuestionAfterRemovingCompletedQuestions {
    List<QuestionDataModel> questionsData = [];
    final List<SelectedAnswerModel> selectedAnswers =
        inCompleteTestDetails.selectedAnswers;
    for (final questionItem in allQuestionsData) {
      final bool isValid = selectedAnswers.any(
        (answerItem) => answerItem.questionId == questionItem.id,
      );
      if (isValid) {
        questionsData.add(questionItem);
      }
    }
    return questionsData;
  }

  // count of completed questions
  int getCountOfCompletedQuestions() {
    final List<QuestionDataModel> questionsData =
        getQuestionAfterRemovingCompletedQuestions;
    return questionsData.length;
  }
}

// to get the widgets list to show it on the app
List<Widget> getTestScreenWidgetsHelper(
  List<QuestionDataModel> questions,
  PageController controller,
) {
  List<Widget> widgetList = [];
  // shuffling questionsData
  // questions.shuffle();
  int index = 0;
  for (final questionItem in questions) {
    widgetList.add(
      TestViewTestScreen(
        pageTitle: 'Page $index',
        controller: controller,
        pagesCount: questions.length,
        pagesPosition: index,
        questionData: questionItem,
      ),
    );
    index++;
  }

  return widgetList;
}
