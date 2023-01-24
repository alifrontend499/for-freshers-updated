import 'package:flutter/material.dart';
import 'package:forfreshers_app/global/consts/test_view_screen_consts.dart';

// -- global
import 'package:forfreshers_app/global/settings/app_settings.dart';

// -- screen
import 'package:forfreshers_app/screens/test_view/styles/screen_styles.dart';

PreferredSize getTestResultAppBar(BuildContext context) {
  PreferredSize appBar = PreferredSize(
    preferredSize: appSettingsBarSize,
    child: AppBar(
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Text(
          TEST_VIEW_TEST_RESULT_SCREEN_CONST_APPBAR_TITLE,
          style: testViewTestScreenAppBarTitleStyles,
        ),
      ),
      titleSpacing: 0,
      centerTitle: true,
    ),
  );

  return appBar;
}