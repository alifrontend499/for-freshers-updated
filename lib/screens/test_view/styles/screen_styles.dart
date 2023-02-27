import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/colors/app_colors.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';

ButtonStyle testViewAppBarActionCancelButtonStyles = ElevatedButton.styleFrom(
  backgroundColor: Colors.redAccent,
  splashFactory: NoSplash.splashFactory,
  elevation: 0,
  textStyle: const TextStyle(
    fontSize: 15,
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
  ),
);

ButtonStyle testViewBottomViewButtonStyles(bool isEnabled) =>
    ElevatedButton.styleFrom(
      minimumSize:
          const Size(double.minPositive, appSettingsDefaultButtonHeight),
      backgroundColor:
          isEnabled ? appColorPrimary : appColorPrimary.withOpacity(.4),
      splashFactory: NoSplash.splashFactory,
      textStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );

const TextStyle testViewTestScreenQuestionCountStyles = TextStyle(
  color: appColorPrimary,
  fontWeight: FontWeight.w600,
  fontSize: 15,
);
const TextStyle testViewTestScreenQuestionNameStyles = TextStyle(
  color: Colors.black,
  fontSize: 17,
  fontWeight: FontWeight.w600,
);

const TextStyle testViewTestScreenAppBarTitleStyles = TextStyle(
  color: Colors.black,
  fontSize: 19,
);

const TextStyle testViewTestResultScreenHeading1Styles = TextStyle(
  color: Colors.black,
  fontSize: 19,
);
const TextStyle testViewTestResultScreenHeading2Styles = TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: 21,
  color: appColorPrimary,
);

TextStyle testViewTestResultScreenProgressCircleTextStyles(
        double fontSize, FontWeight fontWeight) =>
    TextStyle(
      fontWeight: fontWeight,
      color: Colors.black,
      fontSize: fontSize,
    );
const TextStyle testViewTestResultScreenProgressRightQuestionsTextStyles =
    TextStyle(
  fontSize: 14,
);

TextStyle testViewTestResultScreenTestPassOrFailTextStyles(bool isRight) =>
    TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 25,
      color: isRight ? Colors.green : Colors.redAccent,
    );

const TextStyle testViewTestResultScreenTestPassOrFailMsgStyles = TextStyle(
  fontSize: 16,
  color: Colors.black87,
);
ButtonStyle testViewTestResultScreenRetryTestsBtnStyles =
    ElevatedButton.styleFrom(
  minimumSize: const Size(
    double.minPositive,
    appSettingsDefaultButtonHeight,
  ),
  backgroundColor: Colors.white.withOpacity(.7),
  foregroundColor: Colors.black,
  splashFactory: NoSplash.splashFactory,
  textStyle: const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
  ),
);
ButtonStyle testViewTestResultScreenExploreOtherTestsBtnStyles =
    ElevatedButton.styleFrom(
  minimumSize: const Size(
    double.minPositive,
    appSettingsDefaultButtonHeight,
  ),
  backgroundColor: appColorPrimary,
  splashFactory: NoSplash.splashFactory,
  textStyle: const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
  ),
);
