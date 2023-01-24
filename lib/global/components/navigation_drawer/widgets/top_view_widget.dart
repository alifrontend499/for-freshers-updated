import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/colors/app_colors.dart';
import 'package:forfreshers_app/global/consts/navigation_drawer_consts.dart';
import 'package:forfreshers_app/global/models/auth_models.dart';

// -- component
import 'package:forfreshers_app/global/components/navigation_drawer/settings/navigation_drawer_settings.dart';
import 'package:forfreshers_app/global/components/navigation_drawer/styles/navigation_drawer_styles.dart';
import 'package:forfreshers_app/utilities/routing/routing_consts.dart';

Widget navigationDrawerTopViewWidget(
  BuildContext context,
  bool isUserLoggedIn,
  AuthUserModel? userDetails,
) =>
    Padding(
      padding: const EdgeInsets.only(
        top: 45,
        bottom: 8,
        left: defaultGap - 5,
        right: defaultGap - 5,
      ),
      child: InkWell(
        onTap: () {
          // closing the drawer
          Navigator.pop(context);

          if (isUserLoggedIn &&
              userDetails != null &&
              userDetails.userProfileImg.isNotEmpty) {
            Navigator.pushNamed(context, userProfileScreenRoute);
          } else {
            Navigator.pushNamed(context, loginScreenRoute);
          }
        },
        highlightColor: appColorInkWellHighlight,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // child | user profile
              (isUserLoggedIn &&
                      userDetails != null &&
                      userDetails.userProfileImg.isNotEmpty)
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.network(
                        userDetails.userProfileImg,
                        height: 48,
                        width: 48,
                        fit: BoxFit.fill,
                      ),
                    )
                  : Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: appColorPrimary,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
              const SizedBox(width: 15),

              // child | user details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isUserLoggedIn && userDetails != null
                        ? userDetails.userName
                        : NAVIGATION_DRAWER_CONSTS_TOP_VIEW_TEXT_SIGN_IN,
                    style: topViewTextSignInStyles,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    NAVIGATION_DRAWER_CONSTS_TOP_VIEW_TEXT_VIEW_ACCOUNT,
                    style: topViewTextViewAccountStyles,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
