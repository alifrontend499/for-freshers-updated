// functions | questions
import 'dart:convert';
import 'dart:io';

import 'package:forfreshers_app/global/models/test_models.dart';
import 'package:path_provider/path_provider.dart';

const String inCompleteTestsFileName = 'inProgressTestsByUser.txt';

// -- function | get in progress test file
Future<File> getInCompleteTestsFile() async {
  Directory tempDir = await getApplicationDocumentsDirectory();
  return File("${tempDir.path}/$inCompleteTestsFileName");
}

// -- function | check if file exist
Future<bool> isInCompleteTestsFileExist() async {
  File completedTestFile = await getInCompleteTestsFile();
  return completedTestFile.exists();
}

// -- function | to delete all the tests
Future<void> deleteIncompleteTestsFile() async {
  final isFileExist = await isInCompleteTestsFileExist();
  if (isFileExist) {
    File completedTestFile = await getInCompleteTestsFile();
    completedTestFile.delete();
    print('delete complete');
  } else {
    print('no file exist');
  }
}

// -- helper | get all the tests
Future<String> getInCompleteTestsStringHelper() async {
  final isFileExist = await isInCompleteTestsFileExist();
  if (isFileExist) {
    File inCompleteTestsFile = await getInCompleteTestsFile();
    final String stringDataRaw = await inCompleteTestsFile.readAsString();
    return stringDataRaw;
  }
  return '';
}

// -- helper | get all the tests
Future<List<InCompleteTestsDataModel>> getInCompleteTestsHelper() async {
  final isFileExist = await isInCompleteTestsFileExist();
  if (isFileExist) {
    File inCompleteTestsFile = await getInCompleteTestsFile();
    final String stringDataRaw = await inCompleteTestsFile.readAsString();
    if (stringDataRaw.isNotEmpty) {
      final List<dynamic> dataRaw = jsonDecode(stringDataRaw);
      final List<InCompleteTestsDataModel> inCompleteTests = [];
      for (var e in dataRaw) {
        inCompleteTests.add(InCompleteTestsDataModel.fromJson(e));
      }
      return inCompleteTests;
    }
  }
  return [];
}

// -- helper | get all the tests
Future<InCompleteTestsDataModel?> getInCompleteTestByIdHelper(
  String testId,
) async {
  InCompleteTestsDataModel? foundTest;
  final isFileExist = await isInCompleteTestsFileExist();
  if (isFileExist && testId.isNotEmpty) {
    final List<InCompleteTestsDataModel> inCompletedTests =
        await getInCompleteTestsHelper();
    for (final singleTest in inCompletedTests) {
      if (singleTest.testId == testId) {
        foundTest = singleTest;
        break;
      }
    }
  }
  return foundTest;
}

// -- helper | check if the text exists by id
Future<bool> isInCompleteTestExistHelper(String testId) async {
  bool isTextExist = false;
  final isFileExist = await isInCompleteTestsFileExist();
  final List<InCompleteTestsDataModel> inCompletedTests =
      await getInCompleteTestsHelper();
  if (isFileExist && testId.isNotEmpty && inCompletedTests.isNotEmpty) {
    for (final singleTest in inCompletedTests) {
      if (singleTest.testId == testId) {
        isTextExist = true;
        break;
      }
    }
  }
  return isTextExist;
}

// updated Existing in complete list
Future<List<Map<String, dynamic>>> updateExistingInCompleteTestList(
  InCompleteTestsDataModel currentTest,
) async {
  final List<InCompleteTestsDataModel> existingInCompletedTests =
      await getInCompleteTestsHelper();
  if (existingInCompletedTests.isNotEmpty) {
    final String testId = currentTest.testId;
    // getting all other tests except the existing one
    final List<InCompleteTestsDataModel> otherTests = existingInCompletedTests
        .where((item) => item?.testId != testId)
        .toList();

    // adding updated tests to existing one
    otherTests.add(currentTest);

    return otherTests.map((e) => e.toJson()).toList();
  }

  return [];
}

// -- helper | set test
Future<void> setInCompleteTestHelper(
  InCompleteTestsDataModel inCompleteTest,
) async {
  String dataToSave = '';
  final List<InCompleteTestsDataModel> existingInCompletedTests =
      await getInCompleteTestsHelper();

  if (existingInCompletedTests.isNotEmpty) {
    final String testId = inCompleteTest.testId;
    final SelectedAnswerModel answerData = inCompleteTest.selectedAnswers[0];

    // finding if the new test is already in the existing list
    final bool isTestExist =
        existingInCompletedTests.any((item) => item.testId == testId);
    // final InCompleteTestsDataModel? existingTest =
    //     existingInCompletedTests.firstWhere((item) => item?.testId == testId);
    InCompleteTestsDataModel? existingTest;
    for (final testItem in existingInCompletedTests) {
      if (testItem.testId == testId) {
        existingTest = testItem;
      }
    }

    // if test already existed in the current tests then updating the questions only
    if (isTestExist && existingTest != null) {
      final InCompleteTestsDataModel currentTest = existingTest;
      final String newAnswerDatasQuestionId = answerData.questionId;
      final bool isAnswerDataAlreadyExist = currentTest.selectedAnswers
          .any((e) => e.questionId == newAnswerDatasQuestionId);

      // if new answer data is not present already
      if (!isAnswerDataAlreadyExist) {
        // add to current test questions
        currentTest.selectedAnswers.add(answerData);
        final List<Map<String, dynamic>> updatedData =
            await updateExistingInCompleteTestList(currentTest);
        // print('updatedData $updatedData');
        // updating updated test to the main list
        dataToSave = jsonEncode(updatedData);
      }
    } else {
      // adding to existing data
      existingInCompletedTests.add(inCompleteTest);
      // converting to json
      dataToSave = jsonEncode(existingInCompletedTests);
    }
  } else {
    // converting to json
    dataToSave = jsonEncode([inCompleteTest.toJson()]);
  }

  // saving data
  updateInCompletedTestsFile(dataToSave);
}

// -- helper | delete test
Future<void> deleteInCompleteTestHelper(String testId) async {
  final isFileExist = await isInCompleteTestsFileExist();
  if (isFileExist) {
    String dataToSave = '';
    final List<InCompleteTestsDataModel> inCompletedTests =
        await getInCompleteTestsHelper();
    print('count one ${inCompletedTests.length}');
    final List<InCompleteTestsDataModel> otherTests =
        inCompletedTests.where((e) => e.testId != testId).toList();
    print('otherTests $otherTests');
    if (otherTests.isNotEmpty) {
      dataToSave = jsonEncode(otherTests);
    } else {
      dataToSave = jsonEncode([]);
    }

    // saving to file
    await updateInCompletedTestsFile(dataToSave);
    print('test deleted successfully');
  } else {
    print('no test found to delete');
  }
}

// -- helper | delete all tests
Future<void> deleteAllInCompleteTestsHelper() async {
  final isFileExist = await isInCompleteTestsFileExist();
  if (isFileExist) {
    String dataToSave = jsonEncode([]);
    // saving to file
    await updateInCompletedTestsFile(dataToSave);
    print('all tests deleted successfully');
  }
}

// -- function | save data to completed test file
Future<void> updateInCompletedTestsFile(String dataToSave) async {
  // writing to file
  final File completedTestFile = await getInCompleteTestsFile();
  completedTestFile.writeAsString(dataToSave);
  print('data saved');
}
