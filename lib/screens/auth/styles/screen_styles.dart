import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/colors/app_colors.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';

const TextStyle authPageHeadingStyles = TextStyle(
  fontSize: 27,
  fontWeight: FontWeight.w600,
  color: appColorPrimary,
);
const TextStyle authPageDescriptionStyles = TextStyle(
  fontSize: 17,
  color: Colors.black54,
);

ButtonStyle authPageButtonStyles(bool isLoading) => ElevatedButton.styleFrom(
  minimumSize: const Size(
    double.infinity,
    appSettingsDefaultButtonHeight,
  ),
  backgroundColor: isLoading ? appColorPrimary.withOpacity(0.5) : appColorPrimary,
  splashFactory: NoSplash.splashFactory,
  textStyle: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.1
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
  ),
);