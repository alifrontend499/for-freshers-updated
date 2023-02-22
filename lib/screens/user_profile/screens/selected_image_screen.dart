import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:forfreshers_app/utilities/helpers/app_snackbars.dart';

// -- packages
import 'package:http/http.dart' as http;

// -- global
import 'package:forfreshers_app/global/consts/user_profile_screen_consts.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';

// -- screens
import 'package:forfreshers_app/screens/user_profile/components/selected_image_app_bar/selected_image_app_bar.dart';
import 'package:forfreshers_app/screens/user_profile/style/screen_styles.dart';

// -- utilities
import 'package:forfreshers_app/utilities/helpers/auth_helpers.dart';
import 'package:forfreshers_app/utilities/apis/app_apis.dart';

class SelectedImageScreen extends StatefulWidget {
  final File selectedImage;

  const SelectedImageScreen({
    Key? key,
    required this.selectedImage,
  }) : super(key: key);

  @override
  State<SelectedImageScreen> createState() => _SelectedImageScreenState();
}

class _SelectedImageScreenState extends State<SelectedImageScreen> {
  bool imageUploadingLoading = false;

  Future<void> uploadImage() async {
    // loading
    setState(() => imageUploadingLoading = true);

    try {
      print('appApiChangeProfileImage $appApiChangeProfileImage');
      final String userToken = await getUserTokenHelper();
      // creating request
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(appApiChangeProfileImage),
      )..headers.addAll(<String, String>{
        'Content-type': 'multipart/form-data',
        'Authorization': 'Bearer $userToken'
      })..files.add(http.MultipartFile(
        'image',
        widget.selectedImage.readAsBytes().asStream(),
        widget.selectedImage.lengthSync(),
      ));
      print('request headers ${request.headers}');
      print('request files ${request.files.length}');

      final http.StreamedResponse response = await request.send();

      final responseStatusCode = response.statusCode;

      print('responseStatusCode $responseStatusCode');
      // print('isBroadcast ${response.stream.isBroadcast}');
      // print('length ${response.stream.length}');
      // print('first ${response.stream.first}');
      // print('isEmpty ${response.stream.isEmpty}');
      // print('single ${response.stream.single}');

      if (responseStatusCode == 200) {
      } else {
        // showing error message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(appSnackBarApiError);
        }
      }
    } catch (err) {
      // ignore: avoid_print
      print('err occurred on EditPasswordPage $err');
      // showing error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(appSnackBarApiError);
      }
    }

    // loading
    setState(() => imageUploadingLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getSelectedImageAppBar(context),
      body: Container(
        padding: appSettingsPagePadding,
        child: Column(
          children: [
            const SizedBox(height: 50),
            // child | image container
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox.fromSize(
                  size: Size.infinite,
                  child: Image.file(
                    widget.selectedImage,
                    // fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),

            // child | button
            ElevatedButton(
              onPressed: uploadImage,
              style: uploadImageButtonStyles,
              child: imageUploadingLoading
                  ? const SizedBox(
                      height: 17,
                      width: 17,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(USER_PROFILE_CONSTS_UPLOAD_IMAGE_BUTTON_TEXT),
            )
          ],
        ),
      ),
    );
  }
}
