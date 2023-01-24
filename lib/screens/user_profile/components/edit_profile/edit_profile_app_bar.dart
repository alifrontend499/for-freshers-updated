import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/consts/user_profile_screen_consts.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';
import 'package:forfreshers_app/global/styles/app_styles.dart';

PreferredSize getEditProfilePageAppBar(BuildContext context) {
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
        USER_PROFILE_EDIT_PROFILE_PAGE_CONST_APPBAR_TITLE,
        style: appBarTitleStyles,
      ),
      titleSpacing: 0,
    ),
  );
}
