import 'package:flutter/material.dart';
import 'package:forfreshers_app/global/consts/incomplete_tests_screen_consts.dart';

// -- global
import 'package:forfreshers_app/global/settings/app_settings.dart';
import 'package:forfreshers_app/global/styles/app_styles.dart';

PreferredSize getPageAppBar(BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
  return PreferredSize(
    preferredSize: appSettingsBarSize,
    child: AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          size: appSettingsBarLeadingSize,
        ),
        onPressed: () => scaffoldKey.currentState?.openDrawer(),
        color: Colors.black,
        splashColor: Colors.transparent,
        splashRadius: appSettingsBarLeadingSplashRadius,
      ),
      title: Text(
        INCOMPLETE_TESTS_CONST_APPBAR_TITLE,
        style: appBarTitleStyles,
      ),
      titleSpacing: 0,
    ),
  );
}
