import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/styles/app_styles.dart';
import 'package:forfreshers_app/global/consts/app_consts.dart';

class LogoutTestDialog extends StatelessWidget {
  final Function logUserOut;

  const LogoutTestDialog({
    Key? key,
    required this.logUserOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding:
          const EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 10),
      contentPadding: const EdgeInsets.only(left: 25, right: 25, bottom: 15),
      actionsPadding:
          const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 10),
      title: Text(
        APP_CONST_DIALOG_LOGOUT_TITLE,
        style: appDialogCancelBtnStyles,
      ),
      content: Text(
        APP_CONST_DIALOG_LOGOUT_CONTENT,
        style: appDialogLogoutContentStyles,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: appDialogLogoutCancelBtnStyles,
                child: Text(APP_CONST_DIALOG_LOGOUT_BTN_CANCEL),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () => logUserOut(),
                style: appDialogLogoutOkBtnStyles,
                child: Text(APP_CONST_DIALOG_LOGOUT_BTN_OK),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
