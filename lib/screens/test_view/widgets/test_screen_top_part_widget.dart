import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/models/test_models.dart';

// -- screen
import 'package:forfreshers_app/screens/test_view/styles/screen_styles.dart';

Widget testViewTestScreenTopPartWidget(
  int pagesCount,
  int pagesPosition,
  QuestionDataModel questionData,
) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          Image.network(
            'https://miro.medium.com/max/1400/1*DvJgeV_GHPkkA2aXq3Vr5g.png',
          )
        ],
      ],
    );
