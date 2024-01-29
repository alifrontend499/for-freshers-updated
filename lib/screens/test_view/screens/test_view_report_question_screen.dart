import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forfreshers_app/global/consts/app_consts.dart';
import 'package:forfreshers_app/global/models/test_models.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';
import 'package:forfreshers_app/global/styles/app_styles.dart';
import 'package:forfreshers_app/screens/auth/styles/screen_styles.dart';
import 'package:forfreshers_app/screens/test_view/components/app_bar/report_question_app_bar.dart';
import 'package:forfreshers_app/utilities/apis/app_apis.dart';
import 'package:forfreshers_app/utilities/helpers/app_snackbars.dart';

// -- packages
import 'package:http/http.dart' as http;

// styles
const TextStyle formLabelStyles = TextStyle(
  fontWeight: FontWeight.w600,
);

class TestViewReportQuestionScreen extends StatefulWidget {
  final QuestionDataModel questionData;

  const TestViewReportQuestionScreen({
    Key? key,
    required this.questionData,
  }) : super(key: key);

  @override
  State<TestViewReportQuestionScreen> createState() =>
      _TestViewReportQuestionScreenState();
}

class _TestViewReportQuestionScreenState
    extends State<TestViewReportQuestionScreen> {
  final formKey = GlobalKey<FormState>();
  String fieldQuestion = '';
  String fieldDescription = '';
  bool submitBtnLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() => fieldQuestion = widget.questionData.name);
  }

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
          Uri.parse(appApiReportQuestion),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            {
              'question_id': widget.questionData.id,
              'report_description': fieldDescription,
            },
          ),
        );
        final responseStatusCode = response.statusCode;
        final responseBodyJson = response.body;
        final responseBody = jsonDecode(responseBodyJson);
        if (responseStatusCode == 200) {
          if (mounted) {
            // showing error
            ScaffoldMessenger.of(context).showSnackBar(
              appSnackBarSuccess(APP_CONST_REPORTED_SUCCESSFULLY),
            );

            // navigation to homepage
            Navigator.pop(context);
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
      appBar: getReportQuestionAppBar(context),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: appSettingsPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Question',
                      style: formLabelStyles,
                    ),
                    const SizedBox(height: 3),
                    fieldQuestionWidget(),
                    const SizedBox(height: 20),
                    const Text(
                      'Description',
                      style: formLabelStyles,
                    ),
                    const SizedBox(height: 3),
                    fieldDescriptionWidget(),
                    const SizedBox(height: 30),
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
                          : const Text('Submit'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // input field email
  Widget fieldQuestionWidget() => TextFormField(
        style: appTextFormFieldStyles,
        readOnly: true,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          hintText: 'Question Name',
          border: appTextFormFieldInputBorderStyles,
          focusedBorder: appTextFormFieldInputBorderFocusedStyles,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
          // errorStyle: stylesInputError,
        ),
        onSaved: (value) => setState(() => fieldQuestion = value!),
        initialValue: fieldQuestion,
        validator: (value) {
          if (value!.isEmpty) {
            // checking for empty value
            return APP_CONST_VALIDATION_ERROR_EMPTY_FIELD;
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      );

  // input field email
  Widget fieldDescriptionWidget() => TextFormField(
        style: appTextFormFieldStyles,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          hintText: APP_CONST_INPUT_HINT_DESCRIPTION,
          border: appTextFormFieldInputBorderStyles,
          focusedBorder: appTextFormFieldInputBorderFocusedStyles,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
          // errorStyle: stylesInputError,
        ),
        onSaved: (value) => setState(() => fieldDescription = value!),
        initialValue: fieldDescription,
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
