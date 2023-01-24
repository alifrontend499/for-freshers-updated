import 'package:flutter/material.dart';

// -- packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forfreshers_app/global/colors/app_colors.dart';

// -- global
import 'package:forfreshers_app/global/models/test_models.dart';
import 'package:forfreshers_app/global/state/app_state.dart';
import 'package:forfreshers_app/utilities/helpers/state_helpers.dart';

class TestViewTestScreenOptions extends ConsumerStatefulWidget {
  final QuestionDataModel questionData;

  const TestViewTestScreenOptions({Key? key, required this.questionData})
      : super(key: key);

  @override
  ConsumerState<TestViewTestScreenOptions> createState() =>
      _TestViewTestScreenOptionsState();
}

class _TestViewTestScreenOptionsState extends ConsumerState<TestViewTestScreenOptions> {
  List<OptionsDataModel> optionsData = [];
  bool isSelected = false;
  String selectedOptionId = '';
  Color selectedOptionColor = appColorPrimary;
  Color containerColor = Colors.white;

  @override
  void initState() {
    super.initState();

    // setting options data
    setState(() => optionsData = widget.questionData.options);
  }

  // when user selects any option
  void checkAnswer(String id) {
    final OptionsDataModel selectedOption =
    optionsData.firstWhere((item) => item.id == id);

    // setting selected option
    setState(() => selectedOptionId = id);

    if (selectedOption.isRight == true) {
      setState(() => selectedOptionColor = Colors.greenAccent);
    } else {
      setState(() => selectedOptionColor = Colors.redAccent);
    }

    // setting global button enable/disable
    ref.watch(isAnswerSelectedProvider.notifier).state = true;

    // setting global state for
    updateSelectedAnswersProviderGlobalHelper(
      ref,
      SelectedAnswerModel(
        questionId: widget.questionData.id,
        questionData: widget.questionData,
        selectedOn: DateTime.now(),
        selectedOption: selectedOption,
        wasRight: selectedOption.isRight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: optionsData.length,
      itemBuilder: ((context, index) {
        final OptionsDataModel optionItem = optionsData[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                final isAnswerSelected = ref.watch(isAnswerSelectedProvider);
                if (isAnswerSelected == false) {
                  checkAnswer(optionItem.id);
                }
              },
              highlightColor: appColorInkWellHighlight,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: selectedOptionId.isNotEmpty
                      ? optionItem.isRight == true
                          ? Colors.greenAccent
                          : selectedOptionId == optionItem.id
                              ? Colors.redAccent
                              : containerColor
                      : containerColor,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.1),
                      offset: const Offset(1, 1),
                      blurRadius: 6,
                      // spreadRadius: 1
                    )
                  ],
                ),
                child: Text(
                  optionItem.name,
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    color: selectedOptionId.isNotEmpty
                        ? optionItem.isRight == true
                            ? Colors.white
                            : selectedOptionId == optionItem.id
                                ? Colors.white
                                : Colors.black
                        : Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
            ),

            // child | option description
            if (selectedOptionId.isNotEmpty && optionItem.isRight == true) ...[
              const SizedBox(height: 15),
              Text(
                optionItem.description,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
            ],

            const SizedBox(height: 25),
          ],
        );
      }),
    );
  }
}
