import 'package:flutter/material.dart';
import 'package:forfreshers_app/global/dialogs/premium_test_dialog.dart';

// -- global
import 'package:forfreshers_app/global/models/test_models.dart';
import 'package:forfreshers_app/global/colors/app_colors.dart';
import 'package:forfreshers_app/global/state/app_state.dart';
import 'package:forfreshers_app/global/styles/app_styles.dart';

// -- packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

// -- utilities
import 'package:forfreshers_app/utilities/routing/routing_consts.dart';
import 'package:forfreshers_app/utilities/helpers/app_helpers.dart';

class TestCard extends ConsumerWidget {
  final TestModel testDetails;
  bool showDescription;

  TestCard({
    Key? key,
    required this.testDetails,
    this.showDescription = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: appColorPrimary,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage(
              testDetails.testImg != ''
                  ? testDetails.testImg
                  : 'https://cdn.pixabay.com/photo/2014/06/03/19/38/board-361516__340.jpg',
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.2),
              BlendMode.modulate,
            ),
          ),
          border: Border.all(
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
        child: Stack(
          children: [
            // child | test type
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // child | header
                Text(
                  getCapitalizeTextHelper(testDetails.testType),
                  style: appTestCardTestTypeStyles,
                ),
                const SizedBox(height: 35),

                // child | test name
                Text(
                  testDetails.testName,
                  style: appTestCardTestNameStyles,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 7),

                // child | test description
                if (showDescription) ...[
                  Text(
                    testDetails.testDescription,
                    style: appTestCardTestDescriptionStyles,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 7),
                ],

                // child | test questions
                Text(
                  "${testDetails.totalQuestions} Questions",
                  style: appTestCardTestQuestionsStyles,
                ),
              ],
            ),

            // child | is premium icon
            if (testDetails.isTestPremium) ...[
              const Positioned(
                right: 0,
                child: Icon(
                  Icons.lock,
                  size: 17,
                  color: appColorPrimary,
                ),
              ),
            ],
          ],
        ),
      ),
      onTap: () {
        if (testDetails.isTestPremium) {
          // showing dialog
          showDialog(
            context: context,
            builder: (context) => const PremiumTestDialog(),
          );
        } else {
          // setting global state
          ref.watch(ongoingTestProvider.notifier).state = testDetails;

          // moving to details screen
          Navigator.pushNamed(context, testDetailsScreenRoute);
        }
      },
    );
  }
}
