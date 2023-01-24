import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/colors/app_colors.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';

ButtonStyle userProfileEditProfileButtonStyles = ElevatedButton.styleFrom(
  backgroundColor: appColorPrimary,
  padding: const EdgeInsets.only(
    top: 9,
    bottom: 7,
    left: 24,
    right: 24,
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
);

ButtonStyle userProfileSubmitButtonStyles(bool isLoading) => ElevatedButton.styleFrom(
      minimumSize: const Size(
        double.infinity,
        appSettingsDefaultButtonHeight,
      ),
      backgroundColor:
          isLoading ? appColorPrimary.withOpacity(0.5) : appColorPrimary,
      splashFactory: NoSplash.splashFactory,
      textStyle: const TextStyle(
          fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: 1.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );
