import 'dart:convert';
import 'package:flutter/material.dart';

// -- packages
import 'package:http/http.dart' as http;

/// -- global
import 'package:forfreshers_app/global/consts/app_consts.dart';
import 'package:forfreshers_app/global/consts/user_profile_screen_consts.dart';
import 'package:forfreshers_app/global/models/auth_models.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';
import 'package:forfreshers_app/global/styles/app_styles.dart';

/// -- screens
import 'package:forfreshers_app/screens/user_profile/components/edit_profile/edit_profile_app_bar.dart';
import 'package:forfreshers_app/screens/user_profile/style/screen_styles.dart';

/// -- utilities
import 'package:forfreshers_app/utilities/helpers/auth_helpers.dart';
import 'package:forfreshers_app/utilities/apis/app_apis.dart';
import 'package:forfreshers_app/utilities/helpers/app_snackbars.dart';
import 'package:forfreshers_app/utilities/helpers/json_helpers.dart';
import 'package:forfreshers_app/utilities/routing/routing_consts.dart';

class EditProfilePage extends StatefulWidget {
  final AuthUserModel userDetails;

  const EditProfilePage({
    Key? key,
    required this.userDetails,
  }) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final formKey = GlobalKey<FormState>();
  String fieldFulName = '';
  String fieldEmail = '';
  String fieldPhone = '';
  String fieldPassword = '';
  String fieldConfirmPassword = '';
  bool submitBtnLoading = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      fieldFulName = widget.userDetails.userName;
      fieldEmail = widget.userDetails.userEmail;
      fieldPhone = widget.userDetails.userPhone;
    });
  }

  // on save changes button clicked
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
          Uri.parse(appApiEditProfile),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $userToken'
          },
          body: jsonEncode(
            <String, String>{
              'name': fieldFulName,
              'email': fieldEmail,
              'phone': fieldPhone,
            },
          ),
        );
        final responseStatusCode = response.statusCode;
        final responseBody = response.body;
        final responseBodyJson = jsonDecode(responseBody);
        // print('responseBodyJson $responseBodyJson');

        if (responseStatusCode == 200) {
          final responseData = responseBodyJson['data'][0];
          final jsonData = convertUserDataFromProfileApiJson(responseData, userToken);
          final AuthUserModel authUserToStore = AuthUserModel.fromJson(jsonData);
          // // setting auth user
          setUserDetailsHelper(authUserToStore);
          // // setting user token
          setUserTokenHelper(authUserToStore.userToken);

          if (mounted) {
            // showing message
            ScaffoldMessenger.of(context).showSnackBar(
              appSnackBarSuccess(
                APP_CONST_AUTH_RESPONSE_PROFILE_EDIT_SUCCESS,
              ),
            );

            // redirecting back
            Navigator.pop(context);
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
        print('err occurred on EditProfilePage $err');
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
      appBar: getEditProfilePageAppBar(context),
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
                        fieldFullNameFieldWidget(),
                        const SizedBox(height: 20),

                        // password
                        fieldEmailFieldWidget(),
                        const SizedBox(height: 20),

                        // confirm password
                        fieldPhoneFieldWidget(),
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
                        : const Text(USER_PROFILE_CONST_SAVE_DETAILS_TEXT),
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
  // user name
  Widget fieldFullNameFieldWidget() {
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
      initialValue: fieldFulName,
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

  // phone
  Widget fieldPhoneFieldWidget() {
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
      initialValue: fieldPhone,
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

  //  email
  Widget fieldEmailFieldWidget() {
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
      initialValue: fieldEmail,
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
}
