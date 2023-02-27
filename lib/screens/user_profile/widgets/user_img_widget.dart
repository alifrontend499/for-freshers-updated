import 'package:flutter/material.dart';
import 'package:forfreshers_app/global/colors/app_colors.dart';

// -- global
import 'package:forfreshers_app/global/models/auth_models.dart';
import 'package:forfreshers_app/screens/user_profile/modal_bottom_sheets/select_image_bottom_sheet.dart';
import 'package:forfreshers_app/utilities/apis/app_apis.dart';

Widget userProfileImgWidget(
  BuildContext context,
  AuthUserModel userDetails,
  Function pickImage,
  String userToken,
) =>
    Stack(
      children: [
        // child | image
        true
            ? ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  getUserImagePathAPI,
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                  headers: <String, String>{
                    'Authorization': 'Bearer $userToken'
                  },
                ),
              )
            : SizedBox(
                height: 120,
                width: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    color: Colors.grey.withOpacity(.4),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              ),

        // child | icon
        Positioned(
          right: 0,
          bottom: 7,
          child: InkWell(
            onTap: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => Container(
                padding: const EdgeInsets.only(
                  top: 15,
                  bottom: 15,
                  left: 15,
                  right: 15,
                ),
                child: selectImageBottomSheetContent(pickImage),
              ),
            ),
            borderRadius: BorderRadius.circular(50),
            child: Container(
              height: 35,
              width: 35,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: appColorPrimary,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.4),
                    // spreadRadius: 10,
                    offset: const Offset(2, 2),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: const Icon(
                Icons.edit_outlined,
                size: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
