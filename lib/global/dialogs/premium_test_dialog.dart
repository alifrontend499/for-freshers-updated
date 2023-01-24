import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/styles/app_styles.dart';
import 'package:forfreshers_app/global/consts/app_consts.dart';
import 'package:forfreshers_app/global/colors/app_colors.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';

class PremiumTestDialog extends StatelessWidget {
  const PremiumTestDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.all(20),
      children: [
        // child | heading
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.lock,
              size: 20,
              color: Colors.black,
            ),
            const SizedBox(width: 10),
            Text(
              APP_CONST_DIALOG_PREMIUM_TEST_HEADING,
              style: appDialogPremiumTestHeadingStyles,
            ),
          ],
        ),
        const SizedBox(height: 10),

        // child | description
        Text(
          APP_CONST_DIALOG_PREMIUM_TEST_DESCRIPTION,
          style: appDialogPremiumTestDescriptionStyles,
        ),
        const SizedBox(height: 20),

        // child | button | get premium
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            elevation: 0,
            minimumSize: const Size(
              double.infinity,
              appSettingsDefaultButtonHeight,
            ),
            backgroundColor: appColorPrimary,
            splashFactory: NoSplash.splashFactory,
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text(APP_CONST_DIALOG_PREMIUM_TEST_BTN_PREMIUM),
        ),
        const SizedBox(height: 15),

        Column(
          children: [
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              highlightColor: appColorInkWellHighlight,
              borderRadius: BorderRadius.circular(5),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                child: Text(
                  APP_CONST_DIALOG_PREMIUM_TEST_TEXT_CONTINUE,
                  textAlign: TextAlign.center,
                  style: appDialogOkBtnStyles,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
