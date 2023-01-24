import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/colors/app_colors.dart';

// -- component
import 'package:forfreshers_app/global/components/navigation_drawer/styles/navigation_drawer_styles.dart';

Widget navigationDrawerLinkWidget(
  Function onTapFunc,
  IconData linkIcon,
  String linkText, {
  double iconSize = 22,
  bool isActive = false,
}) =>
    InkWell(
      onTap: () => onTapFunc(),
      highlightColor: appColorInkWellHighlight,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? appColorPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // child | icon
            Container(
              width: 35,
              // color: Colors.red,
              alignment: Alignment.centerLeft,
              child: Icon(
                linkIcon,
                size: iconSize,
                color: isActive ? Colors.white : Colors.black,
              ),
            ),

            // child | text
            Text(
              linkText,
              style: linkTextStyles(isActive: isActive),
            ),
          ],
        ),
      ),
    );
