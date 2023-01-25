// to convert api data into readable properties
Map<String, dynamic> convertTestsJson(Map<String, dynamic> json) {
  return {
    'testId': json['id'],
    'testType': json['type'],
    'testName': json['name'],
    'totalQuestions': json['total_questions'].toString(),
    'testDescription': json['text'],
    'isTestPremium': json['is_premium'] == 'true' ? true : false,
    'testImg': json['img'],
  };
}

Map<String, dynamic> convertQuestionDataModelJson(Map<String, dynamic> json) {
  final List<Map<String, dynamic>> options = [];
  json['answers'].forEach((e) => options.add(convertOptionsDataModelJson(e)));
  return {
    'id': json['id'].toString(),
    'quizId': json['quiz_id'].toString(),
    'name': json['name'],
    'imgUrl': json['imgUrl'] ?? '',
    'options': options,
  };
}

Map<String, dynamic> convertOptionsDataModelJson(Map<String, dynamic> json) {
  return {
    'id': json['id'].toString(),
    'optionId': json['question_id'].toString(),
    'name': json['name'],
    'description': json['description'],
    'isRight': json['is_right'] == null ? false : true,
  };
}

Map<String, dynamic> convertUserDataFromApiJson(Map<String, dynamic> json) {
  return {
    'userToken': json['token'],
    'userId': json['userid'].toString(),
    'userName': json['name'],
    'userEmail': json['email'],
    'userPhone': json['phone'].toString(),
    'userProfileImg': json['image'] ?? '',
  };
}

Map<String, dynamic> convertUserDataFromProfileApiJson(Map<String, dynamic> json, String token) {
  return {
    'userToken': token,
    'userId': json['id'].toString(),
    'userName': json['name'],
    'userEmail': json['email'],
    'userPhone': json['phone'].toString(),
    'userProfileImg': json['image'] ?? '',
  };
}