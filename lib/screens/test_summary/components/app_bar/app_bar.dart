import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/settings/app_settings.dart';
import 'package:forfreshers_app/global/styles/app_styles.dart';
import 'package:forfreshers_app/global/consts/test_summary_screen_consts.dart';

PreferredSize getPageAppBar(BuildContext context) {
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
      title: const Text(
        TEST_SUMMARY_CONST_APPBAR_TITLE,
        style: appBarTitleStyles,
      ),
      titleSpacing: 0,
    ),
  );
}
