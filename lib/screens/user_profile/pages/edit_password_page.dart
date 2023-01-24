import 'dart:convert';
import 'package:flutter/material.dart';


// -- packages
import 'package:http/http.dart' as http;

// -- global
import 'package:forfreshers_app/global/consts/app_consts.dart';
import 'package:forfreshers_app/global/consts/user_profile_screen_consts.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';
import 'package:forfreshers_app/global/styles/app_styles.dart';

// -- screen
import 'package:forfreshers_app/screens/user_profile/components/edit_password/edit_password_app_bar.dart';
import 'package:forfreshers_app/screens/user_profile/style/screen_styles.dart';

// -- utilities
import 'package:forfreshers_app/utilities/helpers/auth_helpers.dart';
import 'package:forfreshers_app/utilities/apis/app_apis.dart';
import 'package:forfreshers_app/utilities/helpers/app_snackbars.dart';

class EditPasswordPage extends StatefulWidget {
  const EditPasswordPage({Key? key}) : super(key: key);

  @override
  State<EditPasswordPage> createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  final formKey = GlobalKey<FormState>();
  String fieldOldPassword = '';
  String fieldNewPassword = '';
  String fieldConfirmNewPassword = '';
  bool isOldPasswordVisible = true;
  bool isNewPasswordVisible = true;
  bool isConfirmNewPasswordVisible = true;
  bool submitBtnLoading = false;

  // on change password button clicked
  void onSubmit() async {

    final form = formKey.currentState;
    // closing the keyboard
    FocusManager.instance.primaryFocus?.unfocus();

    // if form is valid
    if (form != null && form.validate()) {
      form.save();

      // loading
      setState(() => submitBtnLoading = true);

      try {
        // getting current user details
        final String userToken = await getUserTokenHelper();
        final response = await http.post(
          Uri.parse(appApiChangePassword),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $userToken'
          },
          body: jsonEncode(
            <String, String>{
              'old_password': fieldOldPassword,
              'new_password': fieldNewPassword,
            },
          ),
        );
        final responseStatusCode = response.statusCode;
        final responseBody = response.body;
        final responseBodyData = jsonDecode(responseBody);

        if (responseStatusCode == 200) {
          if (mounted) {
            // showing message
            ScaffoldMessenger.of(context).showSnackBar(
              appSnackBarSuccess(
                APP_CONST_AUTH_RESPONSE_PASSWORD_CHANGED_SUCCESS,
              ),
            );

            // redirecting back
            Navigator.pop(context);
          }
        } else {
          final String message = responseBodyData['message'];
          // showing error message
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              message.isNotEmpty
                  ? appSnackBarApiErrorCustomMsg(message)
                  : appSnackBarApiError,
            );
          }
        }
      } catch (err) {
        // ignore: avoid_print
        print('err occurred on EditPasswordPage $err');
        // showing error message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(appSnackBarApiError);
        }
      }

      // loading
      setState(() => submitBtnLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getEditPasswordPageAppBar(context),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
          padding: appSettingsPagePadding,
          child: Column(
            children: [
              // child | form fields
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        // old password
                        fieldOldPasswordWidget(),
                        const SizedBox(height: 20),

                        // password
                        fieldPasswordWidget(),
                        const SizedBox(height: 20),

                        // confirm password
                        fieldConfirmPasswordWidget(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),

              // child | submit button
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: userProfileSubmitButtonStyles(submitBtnLoading),
                    onPressed: () => !submitBtnLoading ? onSubmit() : false,
                    child: submitBtnLoading
                        ? const SizedBox(
                            height: 17,
                            width: 17,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(USER_PROFILE_CONST_RESET_PASSWORD_TEXT),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // FORM FIELDS
  // old password
  Widget fieldOldPasswordWidget() {
    return TextFormField(
      style: appTextFormFieldStyles,
      obscureText: isOldPasswordVisible,
      decoration: InputDecoration(
        hintText: APP_CONST_INPUT_HINT_OLD_PASSWORD,
        border: appTextFormFieldInputBorderStyles,
        focusedBorder: appTextFormFieldInputBorderFocusedStyles,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isOldPasswordVisible = !isOldPasswordVisible;
            });
          },
          icon: isNewPasswordVisible
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
        ),
      ),
      onChanged: (value) => setState(() => fieldOldPassword = value!),
      validator: (value) {
        if (value!.isEmpty) {
          // checking for empty value
          return APP_CONST_VALIDATION_ERROR_EMPTY_FIELD;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  // password
  Widget fieldPasswordWidget() {
    return TextFormField(
      style: appTextFormFieldStyles,
      obscureText: isNewPasswordVisible,
      decoration: InputDecoration(
        hintText: APP_CONST_INPUT_HINT_NEW_PASSWORD,
        border: appTextFormFieldInputBorderStyles,
        focusedBorder: appTextFormFieldInputBorderFocusedStyles,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isNewPasswordVisible = !isNewPasswordVisible;
            });
          },
          icon: isNewPasswordVisible
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
        ),
      ),
      onChanged: (value) => setState(() => fieldNewPassword = value!),
      validator: (value) {
        if (value!.isEmpty) {
          // checking for empty value
          return APP_CONST_VALIDATION_ERROR_EMPTY_FIELD;
        } else if (fieldNewPassword.length < 6) {
          // checking for empty value
          return APP_CONST_VALIDATION_ERROR_6_CHARACTERS_LONG;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  // confirm password
  Widget fieldConfirmPasswordWidget() {
    return TextFormField(
      style: appTextFormFieldStyles,
      obscureText: isConfirmNewPasswordVisible,
      decoration: InputDecoration(
        hintText: APP_CONST_INPUT_HINT_CONFIRM_NEW_PASSWORD,
        border: appTextFormFieldInputBorderStyles,
        focusedBorder: appTextFormFieldInputBorderFocusedStyles,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isConfirmNewPasswordVisible = !isConfirmNewPasswordVisible;
            });
          },
          icon: isConfirmNewPasswordVisible
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
        ),
      ),
      onChanged: (value) => setState(() => fieldConfirmNewPassword = value!),
      validator: (value) {
        if (value!.isEmpty) {
          // checking for empty value
          return APP_CONST_VALIDATION_ERROR_EMPTY_FIELD;
        } else if (fieldConfirmNewPassword.length < 6) {
          // checking for empty value
          return APP_CONST_VALIDATION_ERROR_6_CHARACTERS_LONG;
        } else if (fieldConfirmNewPassword != fieldNewPassword) {
          // checking for empty value
          return APP_CONST_VALIDATION_ERROR_VALID_CONFIRM_PASSWORD;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
