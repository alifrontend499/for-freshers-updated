const String path = 'https://quiz.knowtherules.ca/api/v1/';

// apis | common
const String appApiListAllTests = '${path}get_question_answers';
String apiGetTestQuestionsDetails(String id) => '${path}get_quiz_questions_by_category/$id';

const String apiAllTypeTestsEndPoint = 'quizes';
const String apiAllTypeTests = path + apiAllTypeTestsEndPoint;

// apis | auth
const String appApiLoginEndPoint = 'user/login';
const String appApiLogin = path + appApiLoginEndPoint;
const String appApiRegisterEndPoint = 'user/register';
const String appApiRegister = path + appApiRegisterEndPoint;
const String appApiChangePasswordEndPoint = 'resetpassword';
const String appApiChangePassword = path + appApiChangePasswordEndPoint;
const String appApiEditProfileEndPoint = 'editprofile';
const String appApiEditProfile = path + appApiEditProfileEndPoint;
const String appApiChangeProfileImageEndPoint = 'saveuserimage';
const String appApiChangeProfileImage = path + appApiChangeProfileImageEndPoint;

// apis | report
const String appApiReportQuestionEndPoint = 'question_report';
const String appApiReportQuestion = path + appApiReportQuestionEndPoint;

// user image
const String getUserImagePathAPI = 'https://quiz.knowtherules.ca/api/v1/getprofileimage';
String getTestImagePathAPI(String id) => 'https://quiz.knowtherules.ca/api/v1/images/quizImages/$id';