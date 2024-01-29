// snackbars
String APP_CONST_SNACKBAR_API_ERROR = "Unknown error occured. please try again";

// common
String APP_CONST_VIEW_ALL = "View All";
String APP_CONST_NO_DATA = "No data found";
String APP_CONST_NO_TESTS = "(No tests found)";
const String APP_CONST_VIEW_TEST_SUMMARY = "View Summary";
const String APP_CONST_VIEW_TEST_DETAILS = "View Details";

// dialogs
// premium test
String APP_CONST_DIALOG_PREMIUM_TEST_HEADING = "Premium Test";
String APP_CONST_DIALOG_PREMIUM_TEST_DESCRIPTION =
    "A premium account is required to access this test";
String APP_CONST_DIALOG_PREMIUM_TEST_BTN_PREMIUM = "Get Premium";
String APP_CONST_DIALOG_PREMIUM_TEST_TEXT_CONTINUE = "Continue Without Premium";
// logout
String APP_CONST_DIALOG_LOGOUT_TITLE = "Logging out";
String APP_CONST_DIALOG_LOGOUT_CONTENT = "Are you sure you want to logout?";
String APP_CONST_DIALOG_LOGOUT_BTN_CANCEL = "Cancel";
String APP_CONST_DIALOG_LOGOUT_BTN_OK = "Ok";
// starting over test
String APP_CONST_DIALOG_START_TEST_OVER_HEADING = "Starting Over";
String APP_CONST_DIALOG_START_TEST_OVER_DESCRIPTION =
    "You have already completed this test. Starting over will remove all the previous progress.";
String APP_CONST_DIALOG_START_TEST_OVER_BTN_START_NOW = "Start Over Now";
String APP_CONST_DIALOG_START_TEST_OVER_TEXT_CANCEL = "Cancel Now";
// cancel test
String APP_CONST_DIALOG_CANCEL_TEST_HEADING = "Confirm Cancel";
String APP_CONST_DIALOG_CANCEL_TEST_DESCRIPTION =
    "Are you sure you want to cancel? All your progress will be lost.";
String APP_CONST_DIALOG_CONTINUE_CANCEL_TEST = "Continue with the test";
String APP_CONST_DIALOG_CONFIRM_CANCEL_TEST = "Confirm Cancel";
// continue test
String APP_CONST_DIALOG_CONTINUE_TEST_HEADING = "Continue Test";

String APP_CONST_DIALOG_CONTINUE_TEST_DESCRIPTION(String DateString) =>
    "You last attempted this test on $DateString. would you like to continue or start over";
String APP_CONST_DIALOG_CONTINUE_TEST_BTN_TEXT_CONTINUE = "Continue Test";
String APP_CONST_DIALOG_CONTINUE_TEST_TEXT_START_OVER = "Start Over";

// forms
String APP_CONST_VALIDATION_ERROR_EMPTY_FIELD = "The field can not be empty";
String APP_CONST_VALIDATION_ERROR_VALID_EMAIL1 = "Email should be valid";
String APP_CONST_VALIDATION_ERROR_VALID_PHONE = "Phone number should be valid";
String APP_CONST_VALIDATION_ERROR_VALID_CONFIRM_PASSWORD =
    "Confirm password should be same as the password";
String APP_CONST_VALIDATION_ERROR_6_CHARACTERS_LONG =
    "The value should be atleast 6 characters long";

// RESPONSES
const String APP_CONST_AUTH_RESPONSE_INVALID_USER = "Invalid User";
const String APP_CONST_AUTH_RESPONSE_USER_NOT_FOUND = "User not found";
const String APP_CONST_AUTH_RESPONSE_SIGNUP_SUCCESS =
    "User create successful. please login";
const String APP_CONST_AUTH_RESPONSE_LOGIN_SUCCESS = "Login successful";
const String APP_CONST_AUTH_RESPONSE_PASSWORD_CHANGED_SUCCESS =
    "Password changed successfully";
const String APP_CONST_AUTH_RESPONSE_PROFILE_EDIT_SUCCESS =
    "Profile updated successfully";
const String APP_CONST_REPORTED_SUCCESSFULLY = "Reported Successfully";

// INPUT HINTS
const String APP_CONST_INPUT_HINT_EMAIL = "Email";
const String APP_CONST_INPUT_HINT_OLD_PASSWORD = "Old Password";
const String APP_CONST_INPUT_HINT_PASSWORD = "Password";
const String APP_CONST_INPUT_HINT_CONFIRM_PASSWORD = "Confirm Password";
const String APP_CONST_INPUT_HINT_NEW_PASSWORD = "New Password";
const String APP_CONST_INPUT_HINT_CONFIRM_NEW_PASSWORD = "Confirm New Password";
const String APP_CONST_INPUT_HINT_FULL_NAME = "Full Name";
const String APP_CONST_INPUT_HINT_FIRST_NAME = "First Name";
const String APP_CONST_INPUT_HINT_LAST_NAME = "Last Name";
const String APP_CONST_INPUT_HINT_PHONE = "Phone Number";
const String APP_CONST_INPUT_HINT_DESCRIPTION = "Description";
