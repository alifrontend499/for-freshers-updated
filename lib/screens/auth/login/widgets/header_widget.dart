import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/consts/auth_consts.dart';

// -- screens
import 'package:forfreshers_app/screens/auth/styles/screen_styles.dart';

Widget headerWidget() => Column(
  children: [
    // child | head
    Text(
      AUTH_CONST_LOGIN_PAGE_HEADING,
      // style: stylesPageHeaderHeading,
      style: authPageHeadingStyles,
      textAlign: TextAlign.left,
    ),
    const SizedBox(height: 8),

    // child | desc
    Text(
      AUTH_CONST_LOGIN_PAGE_DESCRIPTION,
      // style: stylesPageHeaderDescription,
      style: authPageDescriptionStyles,
      textAlign: TextAlign.left,
    ),
  ],
);