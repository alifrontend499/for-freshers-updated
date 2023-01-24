import 'package:flutter/material.dart';
// -- global
import 'package:forfreshers_app/global/models/test_models.dart';
import 'package:forfreshers_app/screens/test_details/styles/screen_styles.dart';

Widget testDetailsScreenTestAllDetailsWidget(TestModel onGoingTest) => Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Image.network(
        // widget.testImg,
        'https://cdn.pixabay.com/photo/2014/06/03/19/38/board-361516__340.jpg',
        fit: BoxFit.fill,
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