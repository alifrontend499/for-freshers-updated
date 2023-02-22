import 'package:flutter/material.dart';
import 'package:forfreshers_app/global/colors/app_colors.dart';
import 'package:forfreshers_app/global/modal_bottom_sheets/widgets/bottom_sheet_top_indicator.dart';
import 'package:image_picker/image_picker.dart';

Widget selectImageBottomSheetContent(
  Function pickImage,
) =>
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // child | top indicator
        bottomSheetTopIndicator(),

        // child | link
        InkWell(
          onTap: () {
            pickImage(ImageSource.camera);
          },
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: appColorPrimary,
                  ),
                  child: const Icon(
                    Icons.camera,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 15),
                const Text(
                  'Use Camera',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    letterSpacing: .7,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 1),

        // child | link
        InkWell(
          onTap: () {
            pickImage(ImageSource.gallery);
          },
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: appColorPrimary,
                  ),
                  child: const Icon(
                    Icons.perm_media_outlined,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 15),
                const Text(
                  'Choose from Gallery',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    letterSpacing: .7,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 15),
      ],
    );
