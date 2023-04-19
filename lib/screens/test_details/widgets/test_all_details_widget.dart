import 'package:flutter/material.dart';
// -- global
import 'package:forfreshers_app/global/models/test_models.dart';
import 'package:forfreshers_app/screens/test_details/styles/screen_styles.dart';
import 'package:forfreshers_app/utilities/apis/app_apis.dart';

Widget testDetailsScreenTestAllDetailsWidget(TestModel onGoingTest) => Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Image.network(
        // widget.testImg,
        getTestImagePathAPI(onGoingTest.testId.toString()),
        fit: BoxFit.cover,
        height: 250,
      ),
    ),
    const SizedBox(height: 15),
    Text(
      onGoingTest.testName,
      style: testDetailsHeadingStyles,
    ),
    const SizedBox(height: 10),
    Text(
      onGoingTest.testDescription,
      style: testDetailsDescriptionStyles,
    ),
  ],
);