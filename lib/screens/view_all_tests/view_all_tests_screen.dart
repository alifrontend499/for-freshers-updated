import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/models/test_models.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';

// -- screen
import 'package:forfreshers_app/screens/view_all_tests/components/app_bar/app_bar.dart';
import 'package:forfreshers_app/screens/view_all_tests/widgets/test_view_widget.dart';

class ViewAllTestsScreen extends StatelessWidget {
  final String testType;
  final List<TestModel> allTests;
  const ViewAllTestsScreen({
    Key? key,
    required this.testType,
    required this.allTests,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getPageAppBar(context, testType),
      body: ListView.builder(
        padding: appSettingsPagePadding,
        physics: const BouncingScrollPhysics(),
        itemCount: allTests.length,
        itemBuilder: (context, index) {
          final TestModel testItem = allTests[index];
          return viewAllTestsScreenTestCardViewWidget(testItem);
        },
      ),
    );
  }
}

