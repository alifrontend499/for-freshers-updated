import 'package:flutter/material.dart';

Widget bottomSheetTopIndicator() => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // child | top indicator
        Container(
          height: 6,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
