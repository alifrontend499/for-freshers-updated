import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/models/test_models.dart';
import 'package:forfreshers_app/screens/test_view/components/test_option.dart';

// -- screen
import 'package:forfreshers_app/screens/test_view/widgets/test_screen_top_part_widget.dart';

class TestViewTestScreen extends StatelessWidget {
  final String pageTitle;
  final PageController controller;
  final int pagesCount;
  final int pagesPosition;
  final QuestionDataModel questionData;

  const TestViewTestScreen({
    Key? key,
    required this.pageTitle,
    required this.controller,
    required this.pagesCount,
    required this.pagesPosition,
    required this.questionData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          // child | top part
          testViewTestScreenTopPartWidget(
            context,
            pagesCount,
            pagesPosition,
            questionData,
          ),
          const SizedBox(height: 30),

          // child | options
          TestViewTestScreenOptions(
            questionData: questionData,
          ),
        ],
      ),
    );
  }
}
