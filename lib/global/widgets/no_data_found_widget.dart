import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/consts/app_consts.dart';

Widget noDataFoundWidget() => Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Text(
        APP_CONST_NO_TESTS,
        textAlign: TextAlign.center,
      ),
    );
