import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/models/test_models.dart';
import 'package:forfreshers_app/global/consts/app_consts.dart';
import 'package:forfreshers_app/global/colors/app_colors.dart';
import 'package:forfreshers_app/global/styles/app_styles.dart';

// -- screen
import 'package:forfreshers_app/screens/home/styles/screen_styles.dart';
import 'package:forfreshers_app/screens/view_all_tests/view_all_tests_screen.dart';

// -- utilities
import 'package:forfreshers_app/utilities/helpers/app_helpers.dart';

// -- packages
import 'package:page_transition/page_transition.dart';

class TestCardHeader extends StatelessWidget {
  final int testsCount;
  final String testType;
  final List<TestModel> allTests;

  const TestCardHeader({
    Key? key,
    required this.testsCount,
    required this.testType,
    required this.allTests,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // child | heading
        Text(
          getCapitalizeTextHelper(testType),
          style: testCardHeaderHeadingStyles,
        ),

        // child | all tests
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: appColorInkWellHighlight,
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
            child: Text(
              '$APP_CONST_VIEW_ALL ($testsCount)',
              style: appLinkStyles,
            ),
          ),
          // onTap: () {},
          onTap: () => Navigator.of(context).push(
            PageTransition(
              type: PageTransitionType.rightToLeft,
              child: ViewAllTestsScreen(
                testType: testType,
                allTests: allTests,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
