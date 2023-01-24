import 'package:flutter/material.dart';
import 'package:forfreshers_app/global/components/test_card/test_card.dart';

// -- global
import 'package:forfreshers_app/screens/home/components/test_card_header/test_card_header.dart';
import 'package:forfreshers_app/global/models/test_models.dart';

Widget viewAllTestsScreenTestCardViewWidget(TestModel testItem) => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TestCard(
          testDetails: TestModel.fromJson(testItem.toJson()),
          showDescription: true,
        ),
        const SizedBox(height: 15),
      ],
    );
