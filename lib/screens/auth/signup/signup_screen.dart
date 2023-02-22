import 'dart:convert';
import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/colors/app_colors.dart';
import 'package:forfreshers_app/global/consts/app_consts.dart';
import 'package:forfreshers_app/global/consts/auth_consts.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';
import 'package:forfreshers_app/global/styles/app_styles.dart';

// -- screens
import 'package:forfreshers_app/screens/auth/signup/widgets/header_widget.dart';
import 'package:forfreshers_app/screens/auth/styles/screen_styles.dart';

// -- utilities
import 'package:forfreshers_app/utilities/apis/app_apis.dart';
import 'package:forfreshers_app/utilities/helpers/app_snackbars.dart';
import 'package:forfreshers_app/utilities/routing/routing_consts.dart';

// -- packages
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  String fieldFulName = '';
  String fieldEmail = '';
  String fieldPhone = '';
  String fieldPassword = '';
  String fieldConfirmPassword = '';
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;
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
          Uri.parse(appApiRegister),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            <String, String>{
              'email': fieldEmail,
              'phone': fieldEmail,
              'password': fieldPassword,
              'name': fieldFulName,
            },
          ),
        );
        final responseStatusCode = response.statusCode;
        final responseBody = response.body;
        final responseBodyJson = jsonDecode(responseBody);
        print('responseBodyJson $responseBodyJson');
        if (responseStatusCode == 200) {
          if (mounted) {
            // showing error
            ScaffoldMessenger.of(context).showSnackBar(
              appSnackBarSuccess(APP_CONST_AUTH_RESPONSE_SIGNUP_SUCCESS),
            );

            // navigation to homepage
            Navigator.pushNamed(context, loginScreenRoute);
          }
        } else {
          final String message = responseBodyJson['message'];
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
                                fieldFullNameWidget(),
                                const SizedBox(height: 20),
                                fieldEmailWidget(),
                                const SizedBox(height: 20),
                                fieldPhoneWidget(),
                                const SizedBox(height: 20),
                                fieldPasswordWidget(),
                                const SizedBox(height: 20),
                                fieldConfirmPasswordWidget(),
                                const SizedBox(height: 20),
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
                : Text(AUTH_CONST_SIGNUP_PAGE_SUBMIT_BUTTON),
          ),
          const SizedBox(height: 15),
          InkWell(
            onTap: () => !submitBtnLoading
                ? Navigator.pushNamed(context, loginScreenRoute)
                : false,
            highlightColor: appColorInkWellHighlight,
            borderRadius: BorderRadius.circular(5),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 8,
              ),
              child: Text(
                AUTH_CONST_ALREADY_HAVE_ACCOUNT,
                style: appLinkTextStyles,
              ),
            ),
          ),
        ],
      );

  // input field full name
  Widget fieldFullNameWidget() {
    return TextFormField(
      style: appTextFormFieldStyles,
      decoration: InputDecoration(
        hintText: APP_CONST_INPUT_HINT_FULL_NAME,
        border: appTextFormFieldInputBorderStyles,
        focusedBorder: appTextFormFieldInputBorderFocusedStyles,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
        // errorStyle: stylesInputError,
      ),
      onChanged: (value) => setState(() => fieldFulName = value!),
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

  // input field phone
  Widget fieldPhoneWidget() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      style: appTextFormFieldStyles,
      decoration: InputDecoration(
        hintText: APP_CONST_INPUT_HINT_PHONE,
        border: appTextFormFieldInputBorderStyles,
        focusedBorder: appTextFormFieldInputBorderFocusedStyles,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
        // errorStyle: stylesInputError,
      ),
      onChanged: (value) => setState(() => fieldPhone = value!),
      validator: (value) {
        // final RegExp pattern = RegExp(r"^(\+0?1\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$");
        if (value!.isEmpty) {
          // checking for empty value
          return APP_CONST_VALIDATION_ERROR_EMPTY_FIELD;
        } else if (value.length != 10) {
          return APP_CONST_VALIDATION_ERROR_VALID_PHONE;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  // input field email
  Widget fieldEmailWidget() {
    return TextFormField(
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
      onChanged: (value) => setState(() => fieldEmail = value!),
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
  }

  // input field password
  Widget fieldPasswordWidget() {
    return TextFormField(
      style: appTextFormFieldStyles,
      obscureText: isPasswordVisible,
      decoration: InputDecoration(
        hintText: APP_CONST_INPUT_HINT_PASSWORD,
        border: appTextFormFieldInputBorderStyles,
        focusedBorder: appTextFormFieldInputBorderFocusedStyles,
        contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
          icon: isPasswordVisible
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
        ),
      ),
      onChanged: (value) => setState(() => fieldPassword = value!),
      validator: (value) {
        if (value!.isEmpty) {
          // checking for empty value
          return APP_CONST_VALIDATION_ERROR_EMPTY_FIELD;
        } else if (fieldPassword.length < 6) {
          // checking for empty value
          return APP_CONST_VALIDATION_ERROR_6_CHARACTERS_LONG;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  // input field confirm password
  Widget fieldConfirmPasswordWidget() {
    return TextFormField(
      style: appTextFormFieldStyles,
      obscureText: isConfirmPasswordVisible,
      decoration: InputDecoration(
        hintText: APP_CONST_INPUT_HINT_CONFIRM_PASSWORD,
        border: appTextFormFieldInputBorderStyles,
        focusedBorder: appTextFormFieldInputBorderFocusedStyles,
        contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isConfirmPasswordVisible = !isConfirmPasswordVisible;
            });
          },
          icon: isConfirmPasswordVisible
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
        ),
      ),
      onChanged: (value) => setState(() => fieldConfirmPassword = value!),
      validator: (value) {
        if (value!.isEmpty) {
          // checking for empty value
          return APP_CONST_VALIDATION_ERROR_EMPTY_FIELD;
        } else if (fieldConfirmPassword.length < 6) {
          // checking for empty value
          return APP_CONST_VALIDATION_ERROR_6_CHARACTERS_LONG;
        } else if(fieldConfirmPassword != fieldPassword) {
          // checking for empty value
          return APP_CONST_VALIDATION_ERROR_VALID_CONFIRM_PASSWORD;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
