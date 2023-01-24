import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/consts/view_all_tests_screen_consts.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';
import 'package:forfreshers_app/global/styles/app_styles.dart';

PreferredSize getPageAppBar(
  BuildContext context,
  String testType,
) {
  return PreferredSize(
    preferredSize: appSettingsBarSize,
    child: AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.chevron_left,
          size: appSettingsBarLeadingSize,
        ),
        onPressed: () => Navigator.of(context).pop(),
        color: Colors.black,
        splashColor: Colors.transparent,
        splashRadius: appSettingsBarLeadingSplashRadius,
      ),
      title: Text(
        VIEW_ALL_TESTS_CONST_APPBAR_TITLE(testType),
        style: appBarTitleStyles,
      ),
      titleSpacing: 0,
    ),
  );
}
