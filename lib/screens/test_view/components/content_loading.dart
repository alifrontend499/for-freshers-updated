import 'package:flutter/material.dart';

// -- loading
import 'package:forfreshers_app/screens/test_view/loading/test_view_options_loading.dart';
import 'package:forfreshers_app/screens/test_view/loading/test_view_question_loading.dart';

Widget testViewScreenContentLoading() => Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    // loading | question
    const TestViewQuestionLoading(),

    // loading | options
    Expanded(
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return const TestViewOptionsLoading();
        },
      ),
    ),
  ],
);