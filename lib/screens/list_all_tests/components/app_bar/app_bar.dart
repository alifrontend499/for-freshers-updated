import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/consts/list_all_tests_screen_consts.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';
import 'package:forfreshers_app/global/styles/app_styles.dart';

PreferredSize getPageAppBar(
    BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
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
        LIST_ALL_TESTS_CONST_APPBAR_TITLE,
        style: appBarTitleStyles,
      ),
      titleSpacing: 0,
    ),
  );
}
