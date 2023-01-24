import 'package:flutter/material.dart';

// -- packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forfreshers_app/global/consts/test_view_screen_consts.dart';

// -- global
import 'package:forfreshers_app/global/dialogs/cancel_test_dialog.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';
import 'package:forfreshers_app/screens/test_view/styles/screen_styles.dart';

PreferredSize getPageAppBar(
  BuildContext context,
  String testName,
  WidgetRef parentRef,
  bool loading,
) {
  return PreferredSize(
    preferredSize: appSettingsBarSize,
    child: AppBar(
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Text(
          testName,
          style: testViewAppBarTitleStyles,
        ),
      ),
      titleSpacing: 0,
      actions: [
        if (loading == false) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            child: ElevatedButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => CancelTestDialog(parentRef: parentRef),
              ),
              style: testViewAppBarActionCancelButtonStyles,
              child: Text(TEST_VIEW_SCREEN_CONST_APPBAR_ACTION_CANCEL_TEST),
            ),
          ),
        ],
      ],
    ),
  );
}
