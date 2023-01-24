import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/settings/app_settings.dart';
import 'package:forfreshers_app/global/styles/app_styles.dart';

PreferredSize getPageAppBar(BuildContext context, String testName) {
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
        testName,
        style: appBarTitleStyles,
      ),
      titleSpacing: 0,
    ),
  );
}
