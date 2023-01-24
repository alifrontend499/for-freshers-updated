import 'package:flutter/material.dart';

// -- packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

// -- global
import 'package:forfreshers_app/global/styles/app_styles.dart';
import 'package:forfreshers_app/global/consts/app_consts.dart';
import 'package:forfreshers_app/global/colors/app_colors.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';

// -- utilities
import 'package:forfreshers_app/utilities/helpers/state_helpers.dart';
import 'package:forfreshers_app/utilities/routing/routing_consts.dart';

class CancelTestDialog extends StatelessWidget {
  final WidgetRef parentRef;

  const CancelTestDialog({
    Key? key,
    required this.parentRef,
  }) : super(key: key);

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
            Text(
              APP_CONST_DIALOG_CANCEL_TEST_HEADING,
              style: appDialogPremiumTestHeadingStyles,
            ),
          ],
        ),
        const SizedBox(height: 10),

        // child | description
        Text(
          APP_CONST_DIALOG_CANCEL_TEST_DESCRIPTION,
          style: appDialogPremiumTestDescriptionStyles,
        ),
        const SizedBox(height: 20),

        // child | button | get premium
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
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
          child: Text(APP_CONST_DIALOG_CONTINUE_CANCEL_TEST),
        ),
        const SizedBox(height: 15),

        Column(
          children: [
            InkWell(
              onTap: () {
                // deleting selected answer state
                testCanceledGlobalHelper(parentRef);

                Navigator.pop(context);
                Navigator.pushNamed(context, homeScreenRoute);
              },
              highlightColor: appColorInkWellHighlight,
              borderRadius: BorderRadius.circular(5),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                child: Text(
                  APP_CONST_DIALOG_CONFIRM_CANCEL_TEST,
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
