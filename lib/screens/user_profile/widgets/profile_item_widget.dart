import 'package:flutter/material.dart';
import 'package:forfreshers_app/global/colors/app_colors.dart';
import 'package:forfreshers_app/screens/user_profile/pages/edit_password_page.dart';
import 'package:page_transition/page_transition.dart';

Widget profileItemWidget(
  BuildContext context,
  String itemName,
  String itemValue,
  IconData icon, {
  bool isPasswordField = false,
}) =>
    InkWell(
      child: Container(
        padding: const EdgeInsets.only(
          top: 15,
          bottom: 15,
          left: 20,
          right: 20,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // child | right part
            Container(
              height: 37,
              width: 37,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: appColorPrimary,
              ),
              child: Icon(
                icon,
                size: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 15),

            // child | left part
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    itemName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    itemValue,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            // child | password content
            if (isPasswordField) ...[
              InkWell(
                onTap: () => Navigator.of(context).push(
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const EditPasswordPage(),
                  ),
                ),
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  height: 37,
                  width: 37,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: appColorLightGrey,
                  ),
                  child: const Icon(
                    Icons.edit,
                    size: 18,
                    color: appColorPrimary,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
