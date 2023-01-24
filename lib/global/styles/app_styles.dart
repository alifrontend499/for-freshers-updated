import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/colors/app_colors.dart';

// appbar styles
const TextStyle appBarTitleStyles = TextStyle(
  color: Colors.black,
  fontSize: 19,
);

const TextStyle appLinkStyles = TextStyle(
  color: Colors.black,
  fontSize: 13,
  fontWeight: FontWeight.w600,
);

// test card
const TextStyle appTestCardTestTypeStyles = TextStyle(
  color: Colors.black,
  fontSize: 14,
  fontWeight: FontWeight.w600,
);
const TextStyle appTestCardTestNameStyles = TextStyle(
  color: appColorPrimary,
  fontSize: 16,
  fontWeight: FontWeight.w600,
);
const TextStyle appTestCardTestDescriptionStyles = TextStyle(
  // color: Colors.grey,
  fontSize: 13,
);
const TextStyle appTestCardTestQuestionsStyles = TextStyle(
  color: Colors.black87,
  fontSize: 12,
);

// dialogs
// premium
const TextStyle appDialogPremiumTestHeadingStyles = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w800,
  color: Colors.black,
);
const TextStyle appDialogPremiumTestDescriptionStyles = TextStyle(
  fontSize: 15,
  color: Colors.black54,
);
const TextStyle appDialogOkBtnStyles = TextStyle(
  fontSize: 14,
  color: appColorPrimary,
  fontWeight: FontWeight.w600,
);
// logout
const TextStyle appDialogCancelBtnStyles = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w600,
);
const TextStyle appDialogLogoutContentStyles = TextStyle(
  fontSize: 15,
);
ButtonStyle appDialogLogoutCancelBtnStyles = ElevatedButton.styleFrom(
  splashFactory: NoSplash.splashFactory,
  minimumSize: const Size(80, 37),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
  elevation: 0,
  backgroundColor: Colors.grey.withOpacity(.8),
  textStyle: const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  ),
);
ButtonStyle appDialogLogoutOkBtnStyles = ElevatedButton.styleFrom(
  splashFactory: NoSplash.splashFactory,
  minimumSize: const Size(80, 37),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
  elevation: 0,
  backgroundColor: appColorPrimary,
  textStyle: const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  ),
);
// starting over test
const TextStyle appDialogStartingTestOverHeadeingStyles = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w800,
  color: Colors.black,
);
const TextStyle appDialogStartingTestOverDescriptionStyles = TextStyle(
  fontSize: 15,
  color: Colors.black54,
);


// links
const TextStyle appLinkTextStyles = TextStyle(
  fontWeight: FontWeight.w600,
  color: appColorPrimary,
);
const TextStyle appLinkTextSmallStyles = TextStyle(
  fontWeight: FontWeight.w600,
  color: appColorPrimary,
  fontSize: 13,
);

// forms
const TextStyle appTextFormFieldStyles = TextStyle(
  fontSize: 14.5,
  height: 1.6,
);
final OutlineInputBorder appTextFormFieldInputBorderStyles = OutlineInputBorder(
  borderRadius: BorderRadius.circular(5),
  borderSide: const BorderSide(
    color: appColorPrimary,
    width: 2,
  ),
);
final OutlineInputBorder appTextFormFieldInputBorderFocusedStyles = OutlineInputBorder(
  borderRadius: BorderRadius.circular(5),
  borderSide: const BorderSide(
    color: appColorPrimary,
    width: 2,
  ),
);
