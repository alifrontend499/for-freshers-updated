import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/consts/user_profile_screen_consts.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';
import 'package:forfreshers_app/global/styles/app_styles.dart';
import 'package:forfreshers_app/screens/user_profile/style/screen_styles.dart';

PreferredSize getSelectedImageAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: appSettingsBarSize,
    child: AppBar(
      automaticallyImplyLeading: false,
      title: const Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Text(
          USER_PROFILE_CONST_SELECTED_IMAGE_APPBAR_TITLE,
          style: appBarTitleStyles,
        ),
      ),
      // centerTitle: true,
      titleSpacing: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: cancelUploadButtonStyles,
            child:
                const Text(USER_PROFILE_CONSTS_UPLOAD_IMAGE_CANCEL_UPLOADING),
          ),
        )
      ],
    ),
  );
}
