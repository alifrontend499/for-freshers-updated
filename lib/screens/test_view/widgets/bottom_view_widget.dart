import 'package:flutter/material.dart';
import 'package:forfreshers_app/global/consts/test_view_screen_consts.dart';
import 'package:forfreshers_app/screens/test_view/styles/screen_styles.dart';

Widget testViewScreenBottomViewWidget(
  bool isAnswerSelected,
  int currentPage,
  Function onPressed,
  int pagesCount,
) =>
    Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // child | next button
          Expanded(
            child: ElevatedButton(
                style: testViewBottomViewButtonStyles(isAnswerSelected),
                onPressed: onPressed(),
                child: currentPage == (pagesCount - 1)
                    ? Text(TEST_VIEW_SCREEN_CONST_BUTTON_SUBMIT_TEXT)
                    : Text(TEST_VIEW_SCREEN_CONST_BUTTON_NEXT_TEXT)),
          ),
        ],
      ),
    );
