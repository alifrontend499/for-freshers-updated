import 'package:flutter/material.dart';
import 'package:forfreshers_app/global/colors/app_colors.dart';

// -- global
import 'package:forfreshers_app/global/models/test_models.dart';

// -- screen
import 'package:forfreshers_app/screens/test_summary/styles/screen_styles.dart';

Widget testSummaryScreenListViewItemWidget(
  SelectedAnswerModel selectedAnswerDataItem,
) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // child | question heading
        questionHeadingWidget(selectedAnswerDataItem),
        const SizedBox(height: 5),

        // child | question name
        Text(
          selectedAnswerDataItem.questionData.name,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 10),

        // child | answers heading
        answerHeadingWidget(selectedAnswerDataItem),
        const SizedBox(height: 5),

        // child | options list
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: selectedAnswerDataItem.questionData.options.length,
          itemBuilder: ((context, index) {
            final OptionsDataModel optionsDataItem =
                selectedAnswerDataItem.questionData.options[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                optionItemWidget(selectedAnswerDataItem, optionsDataItem),
                const SizedBox(height: 3),
              ],
            );
          }),
        ),
        const SizedBox(height: 20),
      ],
    );

// question container
Widget questionHeadingWidget(SelectedAnswerModel dataItem) => Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        // child | icon
        Icon(
          Icons.question_answer_rounded,
          size: 17,
          color: appColorPrimary,
        ),
        SizedBox(width: 5),
        Text(
          'Question: ',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: appColorPrimary,
            fontSize: 16,
          ),
        ),
      ],
    );

Widget answerHeadingWidget(SelectedAnswerModel dataItem) => Row(
      children: [
        const Text(
          'Your Answers: ',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: appColorPrimary,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          dataItem.wasRight ? 'Right' : 'Wrong',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: dataItem.wasRight ? Colors.green : Colors.red,
            fontSize: 16,
          ),
        ),
      ],
    );

Widget optionItemWidget(SelectedAnswerModel selectedAnswerDataItem,
    OptionsDataModel optionsDataItem) {
  final bool selectedOption =
      selectedAnswerDataItem.selectedOption.id == optionsDataItem.id;
  final String textToShow = '${optionsDataItem.name} ${selectedOption ? ' (selected)' : ''}';
  return Text(
    textToShow,
    style: TextStyle(
      fontSize: 15,
      color: optionsDataItem.isRight ? Colors.green : Colors.black,
      fontWeight:
      (optionsDataItem.isRight || selectedOption) ? FontWeight.w600 : FontWeight.w100,
    ),
  );
}
