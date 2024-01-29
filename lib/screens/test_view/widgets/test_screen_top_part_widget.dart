import 'package:flutter/material.dart';
import 'package:forfreshers_app/global/colors/app_colors.dart';

// -- global
import 'package:forfreshers_app/global/models/test_models.dart';

// -- screen
import 'package:forfreshers_app/screens/test_view/styles/screen_styles.dart';
import 'package:forfreshers_app/screens/test_view/widgets/report_question_widget.dart';

const String imgPath = 'https://quiz.knowtherules.ca/api/v1/question_edit_img/';

Widget testViewTestScreenTopPartWidget(
  BuildContext context,
  int pagesCount,
  int pagesPosition,
  QuestionDataModel questionData,
) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // child | report question
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            reportQuestionWidget(
              context,
              questionData,
            ),
          ],
        ),

        Text(
          'Questions ${pagesPosition + 1}/$pagesCount',
          style: testViewTestScreenQuestionCountStyles,
        ),
        const SizedBox(height: 5),

        // child | question
        Text(
          questionData.name,
          style: testViewTestScreenQuestionNameStyles,
        ),
        if (questionData.imgUrl.isNotEmpty) ...[
          const SizedBox(height: 15),
          Container(
            constraints: const BoxConstraints(
              maxHeight: 150,
            ),
            child: Image.network(
              '$imgPath${questionData.imgUrl}',
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const SizedBox(
                  // height: 48,
                  // width: 48,
                  child: Text('image loading...'),
                );
              },
            ),
          ),
        ],
      ],
    );
