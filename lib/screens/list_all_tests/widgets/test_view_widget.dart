import 'package:flutter/material.dart';
import 'package:forfreshers_app/global/components/test_card/test_card.dart';

// -- global
import 'package:forfreshers_app/global/models/test_models.dart';

Widget listAllTestsScreenTestCardViewWidget(List<TestModel> testItems) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // child | content
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: testItems.length,
          itemBuilder: ((context, index) {
            final TestModel testItem = testItems[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TestCard(
                  testDetails: TestModel.fromJson(
                    testItem.toJson(),
                  ),
                  showDescription: true,
                ),
                const SizedBox(height: 15),
              ],
            );
          }),
        ),
      ],
    );
