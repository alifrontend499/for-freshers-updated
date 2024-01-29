import 'package:flutter/material.dart';

// -- packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forfreshers_app/global/consts/test_view_screen_consts.dart';

// -- global
import 'package:forfreshers_app/global/dialogs/cancel_test_dialog.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';
import 'package:forfreshers_app/global/styles/app_styles.dart';

// -- screens
import 'package:forfreshers_app/screens/test_view/styles/screen_styles.dart';

PreferredSize getReportQuestionAppBar(
  BuildContext context,
) {
  return PreferredSize(
    preferredSize: appSettingsBarSize,
    child: AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(
          Icons.chevron_left,
          size: appSettingsBarLeadingSize,
        ),
        onPressed: () => Navigator.pop(context),
        color: Colors.black,
        splashColor: Colors.transparent,
        splashRadius: appSettingsBarLeadingSplashRadius,
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Text(
          'Report Question',
          style: appBarTitleStyles,
        ),
      ),
      titleSpacing: 0,
    ),
  );
}
