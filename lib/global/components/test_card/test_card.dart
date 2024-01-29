import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/models/test_models.dart';
import 'package:forfreshers_app/global/colors/app_colors.dart';
import 'package:forfreshers_app/global/state/app_state.dart';
import 'package:forfreshers_app/global/styles/app_styles.dart';
import 'package:forfreshers_app/global/dialogs/premium_test_dialog.dart';

// -- packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forfreshers_app/utilities/apis/app_apis.dart';

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
      highlightColor: appColorInkWellHighlight,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
          color: appColorLightGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.grey.withOpacity(.2),
                  child: Image.network(
                    getTestImagePathAPI(testDetails.testId.toString()),
                    fit: BoxFit.fill,
                    key: UniqueKey(),
                    // loadingBuilder: (context, child, loadingProgress) {
                    //   if (loadingProgress == null) return child;
                    //   return const SizedBox(
                    //     height: 10,
                    //     width: 10,
                    //     child: Center(
                    //       child: CircularProgressIndicator(
                    //         color: appColorSecondary,
                    //       ),
                    //     ),
                    //   );
                    // },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Stack(
                children: [
                  // child | test type
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // child | header
                      // Text(
                      //   getCapitalizeTextHelper(testDetails.testType),
                      //   style: appTestCardTestTypeStyles,
                      // ),
                      // const SizedBox(height: 35),

                      // child | test name
                      Text(
                        testDetails.testName,
                        style: appTestCardTestNameStyles,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // child | test description
                      if (showDescription) ...[
                        const SizedBox(height: 5),
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
          ],
        ),
      ),
      onTap: () async {
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
