import 'dart:convert';
import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/colors/app_colors.dart';
import 'package:forfreshers_app/global/consts/app_consts.dart';
import 'package:forfreshers_app/global/consts/auth_consts.dart';
import 'package:forfreshers_app/global/models/auth_models.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';
import 'package:forfreshers_app/global/styles/app_styles.dart';

// -- screens
import 'package:forfreshers_app/screens/auth/login/widgets/header_widget.dart';
import 'package:forfreshers_app/screens/auth/styles/screen_styles.dart';

// -- utilities
import 'package:forfreshers_app/utilities/apis/app_apis.dart';
import 'package:forfreshers_app/utilities/helpers/app_snackbars.dart';
import 'package:forfreshers_app/utilities/helpers/auth_helpers.dart';
import 'package:forfreshers_app/utilities/helpers/json_helpers.dart';
import 'package:forfreshers_app/utilities/routing/routing_consts.dart';

// -- packages
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  String fieldEmail = '';
  String fieldPassword = '';
  bool isPasswordVisible = true;
  bool submitBtnLoading = false;

  void onSubmit() async {
    final form = formKey.currentState;

    // closing the keyboard
    FocusManager.instance.primaryFocus?.unfocus();

    if (form != null && form.validate()) {
      form.save();

      // loading
      setState(() => submitBtnLoading = true);

      try {
        final response = await http.post(
          Uri.parse(appApiLogin),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            <String, String>{'email': fieldEmail, 'password': fieldPassword},
          ),
        );
        final responseStatusCode = response.statusCode;
        final responseBodyJson = response.body;
        final responseBody = jsonDecode(responseBodyJson);
        if (responseStatusCode == 200) {
          final responseData = responseBody['data'];
          final jsonData = convertUserDataFromApiJson(responseData);
          final AuthUserModel authUserToStore =
              AuthUserModel.fromJson(jsonData);
          // setting auth user
          setUserDetailsHelper(authUserToStore);
          // setting user token
          setUserTokenHelper(authUserToStore.userToken);

          if (mounted) {
            // showing error
            ScaffoldMessenger.of(context).showSnackBar(
              appSnackBarSuccess(APP_CONST_AUTH_RESPONSE_LOGIN_SUCCESS),
            );

            // navigation to homepage
            Navigator.pushNamed(context, homeScreenRoute);
          }
        } else {
          final String message = responseBody['message'];
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
        print('err occurred on HomeScreen $err');
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
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: appSettingsPagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // child | scroll view
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // child | header
                          headerWidget(),
                          const SizedBox(height: 25),

                          // child | form
                          Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                fieldEmailWidget(),
                                const SizedBox(height: 20),
                                fieldPasswordWidget(),
                                const SizedBox(height: 15),
                                forgotPasswordWidget(),
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),

                          // child | buttons
                          buttonsWidget(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // WIDGETS
  // page's buttons widget
  Widget buttonsWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            style: authPageButtonStyles(submitBtnLoading),
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
                : Text(AUTH_CONST_LOGIN_PAGE_SUBMIT_BUTTON),
          ),
          const SizedBox(height: 15),
          InkWell(
            onTap: () => !submitBtnLoading
                ? Navigator.pushNamed(context, signUpScreenRoute)
                : false,
            highlightColor: appColorInkWellHighlight,
            borderRadius: BorderRadius.circular(5),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 8,
              ),
              child: Text(
                AUTH_CONST_NO_ACCOUNT,
                style: appLinkTextStyles,
              ),
            ),
          ),
        ],
      );

  // forgot password link widget
  Widget forgotPasswordWidget() => InkWell(
        onTap: () => Navigator.pushNamed(context, forgotPasswordScreenRoute),
        highlightColor: appColorInkWellHighlight,
        borderRadius: BorderRadius.circular(5),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 2,
            horizontal: 8,
          ),
          child: Text(
            AUTH_CONST_FORGOT_PASSWORD_TEXT,
            // style: authStylesLinkText,
          ),
        ),
      );

  // input field email
  Widget fieldEmailWidget() => TextFormField(
        keyboardType: TextInputType.emailAddress,
        style: appTextFormFieldStyles,
        decoration: InputDecoration(
          hintText: APP_CONST_INPUT_HINT_EMAIL,
          border: appTextFormFieldInputBorderStyles,
          focusedBorder: appTextFormFieldInputBorderFocusedStyles,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
          // errorStyle: stylesInputError,
        ),
        onSaved: (value) => setState(() => fieldEmail = value!),
        initialValue: fieldEmail,
        validator: (value) {
          const emailPattern = r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$";
          final regExpEmail = RegExp(emailPattern);

          if (value!.isEmpty) {
            // checking for empty value
            return APP_CONST_VALIDATION_ERROR_EMPTY_FIELD;
          } else if (!regExpEmail.hasMatch(value)) {
            // checking for valid email
            return APP_CONST_VALIDATION_ERROR_VALID_EMAIL1;
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      );

  // input field password
  Widget fieldPasswordWidget() => TextFormField(
        style: appTextFormFieldStyles,
        obscureText: isPasswordVisible,
        decoration: InputDecoration(
          hintText: APP_CONST_INPUT_HINT_PASSWORD,
          border: appTextFormFieldInputBorderStyles,
          focusedBorder: appTextFormFieldInputBorderFocusedStyles,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
          // errorStyle: stylesInputError,
        ),
        initialValue: fieldPassword,
        onSaved: (value) => setState(() => fieldPassword = value!),
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
