import 'package:flutter/material.dart';
import 'package:forfreshers_app/global/models/test_models.dart';
import 'package:forfreshers_app/screens/test_view/screens/test_view_report_question_screen.dart';
import 'package:page_transition/page_transition.dart';

// consts
final CONST_REPORT_QUESTION = 'Report Question';

// styles
const TextStyle textStyle = TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: 13,
);

Widget reportQuestionWidget(
  BuildContext context,
  QuestionDataModel questionData,
) {
  return InkWell(
    onTap: () => Navigator.of(context).push(
      PageTransition(
        type: PageTransitionType.bottomToTop,
        child: TestViewReportQuestionScreen(
          questionData: questionData,
        ),
      ),
    ),
    borderRadius: BorderRadius.circular(5),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 7),
      child: Row(
        children: [
          const Icon(Icons.report, size: 21),
          const SizedBox(width: 5),
          Text(
            CONST_REPORT_QUESTION,
            style: textStyle,
          ),
        ],
      ),
    ),
  );
}
