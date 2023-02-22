import 'dart:io';

import 'package:flutter/material.dart';
import 'package:forfreshers_app/global/components/test_card/test_card.dart';

// -- global
import 'package:forfreshers_app/screens/home/components/test_card_header/test_card_header.dart';
import 'package:forfreshers_app/global/models/test_models.dart';

Widget homeScreenTestCardViewWidget(TestViewModel testItemData, List<TestModel> firstTwoTestItems) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // child | header
        TestCardHeader(
          testsCount: testItemData.allTests.length,
          testType: testItemData.type,
          allTests: testItemData.allTests,
        ),
        const SizedBox(height: 15),

        // child | content
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: firstTwoTestItems.length,
          itemBuilder: ((context, index) {
            final TestModel testItem = firstTwoTestItems[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TestCard(
                  testDetails: TestModel.fromJson(
                    testItem.toJson(),
                  ),
                ),
                if (index < 1) ...[
                  const SizedBox(height: 15),
                ],
              ],
            );
          }),
        ),
        if(Platform.isAndroid) ...[
          const SizedBox(height: 15),
        ],
      ],
    );
