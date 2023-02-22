import 'dart:io';

import 'package:flutter/material.dart';
import 'package:forfreshers_app/screens/user_profile/screens/selected_image_screen.dart';

// -- packages
import 'package:image_picker/image_picker.dart';

// -- global
import 'package:forfreshers_app/global/models/auth_models.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';
import 'package:forfreshers_app/global/consts/user_profile_screen_consts.dart';

// -- screens
import 'package:forfreshers_app/screens/user_profile/widgets/user_img_widget.dart';
import 'package:forfreshers_app/screens/user_profile/components/app_bar/app_bar.dart';
import 'package:forfreshers_app/screens/user_profile/widgets/edit_profile_widget.dart';
import 'package:forfreshers_app/screens/user_profile/widgets/profile_item_widget.dart';

// -- utilities
import 'package:forfreshers_app/utilities/helpers/auth_helpers.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late AuthUserModel userDetails;
  File? selectedImage;

  @override
  void initState() {
    super.initState();

    // getting details
    getUserDetails();
  }

  // Function
  void getUserDetails() async {
    AuthUserModel userDetailsRaw = await getUserDetailsHelper();
    setState(() => userDetails = userDetailsRaw);
  }

  // to pick image
  Future<void> pickImage(ImageSource imageSource) async {
    final XFile? image = await ImagePicker().pickImage(source: imageSource);
    if (image == null) return;
    final File imageTemp = File(image.path);
    setState(() => selectedImage = imageTemp);
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectedImageScreen(selectedImage: imageTemp),
        ),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getPageAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: appSettingsPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // child | profile image
              userProfileImgWidget(
                context,
                userDetails,
                pickImage,
              ),
              const SizedBox(height: 20),

              editProfileWidget(context, userDetails),
              const SizedBox(height: 15),

              // child | profile name
              profileItemWidget(
                context,
                USER_PROFILE_CONST_PROFILE_ITEM_TEXT_NAME,
                userDetails.userName,
                Icons.person,
              ),

              // child | profile email
              profileItemWidget(
                context,
                USER_PROFILE_CONST_PROFILE_ITEM_TEXT_EMAIL,
                userDetails.userEmail,
                Icons.alternate_email_outlined,
              ),

              // child | profile phone
              profileItemWidget(
                context,
                USER_PROFILE_CONST_PROFILE_ITEM_TEXT_PHONE,
                userDetails.userPhone,
                Icons.local_phone_sharp,
              ),

              // child | profile phone
              profileItemWidget(
                context,
                USER_PROFILE_CONST_PROFILE_ITEM_TEXT_PASSWORD,
                '**********',
                Icons.password,
                isPasswordField: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
