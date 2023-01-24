import 'package:flutter/material.dart';
import 'package:forfreshers_app/global/models/auth_models.dart';

Widget userProfileImgWidget(
  AuthUserModel userDetails,
) =>
    Stack(
      children: [
        // child | image
        userDetails.userProfileImg.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  userDetails.userProfileImg,
                  height: 120,
                  width: 120,
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
      ],
    );
