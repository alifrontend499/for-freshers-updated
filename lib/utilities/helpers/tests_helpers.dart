import 'dart:convert';
import 'dart:io';

// -- global
import 'package:forfreshers_app/global/models/test_models.dart';

// -- packages
import 'package:path_provider/path_provider.dart';

// functions | questions
const String completedTestsFileName = 'completedTestsByUser.txt';
// -- function | get complete test file
Future<File> getCompletedTestsFile() async {
  Directory tempDir = await getApplicationDocumentsDirectory();
  return File("${tempDir.path}/$completedTestsFileName");
}

// -- function | check if file exist
Future<bool> isCompletedTestsFileExist() async {
  File completedTestFile = await getCompletedTestsFile();
  return completedTestFile.exists();
}

// -- function | to delete all the tests
Future<void> deleteCompletedTestsFile() async {
  final isFileExist = await isCompletedTestsFileExist();
  if (isFileExist) {
    File completedTestFile = await getCompletedTestsFile();
    completedTestFile.delete();
    print('delete complete');
  } else {
    print('no file exist');
  }
}

// -- function | save data to completed test file
Future<void> updateCompletedTestsFile(String dataToSave) async {
  // writing to file
  final File completedTestFile = await getCompletedTestsFile();
  completedTestFile.writeAsString(dataToSave);
  print('data saved');
}

// -- helper | check if the test exist according to id
Future<bool> checkIfCompletedTestExistHelper(String testId) async {
  final isFileExist = await isCompletedTestsFileExist();
  if (isFileExist) {
    final List<CompletedTestModel> completedTests = await getCompletedTestsHelper();
    final isThere = completedTests.where((e) => e.testId == testId);
    if(isThere.isNotEmpty) {
      return true;
    }
  }
  return false;
}
// -- helper | check if the test exist according to id
Future<CompletedTestModel?> getCompletedTestByIdHelper(String testId) async {
  final isFileExist = await isCompletedTestsFileExist();
  if (isFileExist) {
    final List<CompletedTestModel> completedTests = await getCompletedTestsHelper();
    final completedTestSingle = completedTests.where((e) => e.testId == testId);
    if(completedTestSingle.isNotEmpty) {
      return completedTestSingle.first;
    }
  }
  return null;
}

// -- helper | get all the tests
Future<List<CompletedTestModel>> getCompletedTestsHelper() async {
  final isFileExist = await isCompletedTestsFileExist();
  if (isFileExist) {
    File completedTestFile = await getCompletedTestsFile();
    final String stringDataRaw = await completedTestFile.readAsString();
    if (stringDataRaw.isNotEmpty) {
      final List<dynamic> dataRaw = jsonDecode(stringDataRaw);
      final List<CompletedTestModel> completedTests = [];
      for (var e in dataRaw) {
        completedTests.add(CompletedTestModel.fromJson(e));
      }
      return completedTests;
    }
  }
  return [];
}

// -- helper | set completed test
Future<void> setCompletedTestHelper(CompletedTestModel completedTest) async {
  String dataToSave = '';
  final List<CompletedTestModel> existingCompletedTests = await getCompletedTestsHelper();
  if (existingCompletedTests.isNotEmpty) {
    // adding to existing data
    existingCompletedTests.add(completedTest);

    // converting to json
    dataToSave = jsonEncode(existingCompletedTests);
  } else {
    // converting to json
    dataToSave = jsonEncode([completedTest.toJson()]);
  }
  // saving to file
  await updateCompletedTestsFile(dataToSave);
}

// -- helper | delete single completed test
Future<void> deleteSingleCompletedTestHelper(String testId) async {
  final isFileExist = await isCompletedTestsFileExist();
  if (isFileExist) {
    String dataToSave = '';
    final List<CompletedTestModel> completedTests = await getCompletedTestsHelper();
    final List<CompletedTestModel> otherTests = completedTests.where((e) => e.testId != testId).toList();
    if(otherTests.isNotEmpty) {
      dataToSave = jsonEncode(otherTests);
    } else {
      dataToSave = jsonEncode([]);
    }
    // saving to file
    await updateCompletedTestsFile(dataToSave);
    print('test deleted');
  } else {
    print('no data found');
  }
}
