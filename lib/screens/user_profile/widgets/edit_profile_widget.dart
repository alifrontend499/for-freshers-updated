import 'package:flutter/material.dart';
import 'package:forfreshers_app/global/consts/user_profile_screen_consts.dart';
import 'package:forfreshers_app/global/models/auth_models.dart';

// -- packages
import 'package:page_transition/page_transition.dart';

// -- screens
import 'package:forfreshers_app/screens/user_profile/style/screen_styles.dart';
import 'package:forfreshers_app/screens/user_profile/pages/edit_profile_page.dart';

Widget editProfileWidget(
    BuildContext context,
    AuthUserModel userDetails,
    ) => ElevatedButton(
  onPressed: () => Navigator.of(context).push(
    PageTransition(
      type: PageTransitionType.rightToLeft,
      child: EditProfilePage(
        userDetails: userDetails,
      ),
    ),
  ),
  style: userProfileEditProfileButtonStyles,
  child: const Text(USER_PROFILE_CONST_EDIT_PROFILE_TEXT),
);