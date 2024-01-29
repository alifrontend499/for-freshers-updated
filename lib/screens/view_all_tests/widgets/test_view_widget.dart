import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/models/test_models.dart';
import 'package:forfreshers_app/global/components/test_card/test_card.dart';

Widget viewAllTestsScreenTestCardViewWidget(TestModel testItem) => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TestCard(
          testDetails: TestModel.fromJson(testItem.toJson()),
          showDescription: testItem.testDescription.isNotEmpty,
        ),
        const SizedBox(height: 15),
      ],
    );
