
String checkString(dynamic data) {
  if(data is int) {
    return data.toString();
  }
  if(data is String) {
    return data;
  }
  return '';
}

// to convert api data into readable properties
Map<String, dynamic> convertTestsJson(Map<String, dynamic> json) {
  return {
    'testId': checkString(json['id']),
    'testType': checkString(json['type']),
    'testName': checkString(json['name']),
    'totalQuestions': checkString(json['total_questions']),
    'testDescription': checkString(json['text']),
    'isTestPremium': json['is_premium'] == 'true' ? true : false,
    'testImg': checkString(''),
  };
}

Map<String, dynamic> convertQuestionDataModelJson(Map<String, dynamic> json) {
  // print('json her e$json');
  final List<Map<String, dynamic>> options = [];
  json['answers'].forEach((e) => options.add(convertOptionsDataModelJson(e)));
  return {
    'id': checkString(json['id']),
    'quizId': checkString(json['quiz_id']),
    'name': checkString(json['name']),
    'imgUrl': checkString(json['image']),
    'options': options,
    'myProp': 'hello',
  };
}

Map<String, dynamic> convertOptionsDataModelJson(Map<String, dynamic> json) {
  // print('jsong here $json');
  return {
    'id': checkString(json['id']),
    'optionId': checkString(json['question_id']),
    'name': checkString(json['name']),
    'description': checkString(json['description']),
    'isRight': json['is_right'] == '0' ? true : false,
  };
}

Map<String, dynamic> convertUserDataFromApiJson(Map<String, dynamic> json) {
  return {
    'userToken': checkString(json['token']),
    'userId': checkString(json['userid']),
    'userName': checkString(json['name']),
    'userEmail': checkString(json['email']),
    'userPhone': checkString(json['phone']),
    'userProfileImg': checkString(json['image']),
  };
}

Map<String, dynamic> convertUserDataFromProfileApiJson(Map<String, dynamic> json, String token) {
  return {
    'userToken': token,
    'userId': checkString(json['id']),
    'userName': checkString(json['name']),
    'userEmail': checkString(json['email']),
    'userPhone': checkString(json['phone']),
    'userProfileImg': checkString(json['image']),
  };
}