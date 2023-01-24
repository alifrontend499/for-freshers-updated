import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/colors/app_colors.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';

const TextStyle testDetailsHeadingStyles = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  color: appColorPrimary,
);

const TextStyle testDetailsDescriptionStyles = TextStyle(
  color: Colors.black,
  fontSize: 14.5,
);

final ButtonStyle testDetailsSubmitBtnStyles = ElevatedButton.styleFrom(
  minimumSize: const Size(
    double.infinity,
    appSettingsDefaultButtonHeight,
  ),
  backgroundColor: appColorPrimary,
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
