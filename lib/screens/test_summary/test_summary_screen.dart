import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/models/test_models.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';

// -- screen
import 'package:forfreshers_app/screens/test_summary/components/app_bar/app_bar.dart';
import 'package:forfreshers_app/screens/test_summary/widgets/list_view_item_widget.dart';
import 'package:forfreshers_app/screens/test_summary/widgets/screen_header_widget.dart';

class TestSummaryScreen extends StatefulWidget {
  final CompletedTestModel completedTestModal;

  const TestSummaryScreen({
    Key? key,
    required this.completedTestModal,
  }) : super(key: key);

  @override
  State<TestSummaryScreen> createState() => _TestSummaryScreenState();
}

class _TestSummaryScreenState extends State<TestSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getPageAppBar(context),
      body: Container(
        padding: appSettingsPagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // child | heading
            testSummaryScreenHeaderWidget(widget.completedTestModal),
            const SizedBox(height: 20),

            // child | selected questions and answers
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: widget.completedTestModal.selectedAnswers.length,
                itemBuilder: ((context, index) {
                  final SelectedAnswerModel selectedAnswerDataItem = widget.completedTestModal.selectedAnswers[index];

                  return testSummaryScreenListViewItemWidget(selectedAnswerDataItem);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
