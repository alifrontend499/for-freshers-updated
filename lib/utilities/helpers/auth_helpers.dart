// -- packages
import 'dart:convert';

// -- packages
import 'package:flutter/material.dart';

// -- global
import 'package:shared_preferences/shared_preferences.dart';
import 'package:forfreshers_app/global/consts/shared_preferences_consts.dart';
import 'package:forfreshers_app/global/models/auth_models.dart';

// utilities
import 'package:forfreshers_app/utilities/routing/routing_consts.dart';

void appLogoutHelper(BuildContext context, bool mounted) async {
  // shared preferences
  final sharedPrefs = await SharedPreferences.getInstance();
  await sharedPrefs.remove(SHARED_PREF_KEY_TO_STORE_IS_USER_LOGGED_IN);
  await sharedPrefs.remove(SHARED_PREF_KEY_TO_STORE_USER_TOKEN);
  await sharedPrefs.remove(SHARED_PREF_KEY_TO_STORE_USER_DETAILS);

  // pushing to homepage
  if (mounted) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      homeScreenRoute,
      (route) => false,
    );
  }
}

// check if user is logged in
Future<bool> isUserLoggedInHelper() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  return sharedPrefs.getBool(SHARED_PREF_KEY_TO_STORE_IS_USER_LOGGED_IN) ??
      false;
}

// setting user details
Future<void> setUserDetailsHelper(AuthUserModel userDetails) async {
  final sharedPrefs = await SharedPreferences.getInstance();
  final encodedUserDetails = jsonEncode(userDetails.toJson());
  // setting user to shared preferences
  sharedPrefs.setString(
      SHARED_PREF_KEY_TO_STORE_USER_DETAILS, encodedUserDetails);
  sharedPrefs.setBool(SHARED_PREF_KEY_TO_STORE_IS_USER_LOGGED_IN, true);
}

// getting user details if logged int
Future<AuthUserModel> getUserDetailsHelper() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  final String userDetails =
      sharedPrefs.getString(SHARED_PREF_KEY_TO_STORE_USER_DETAILS)!;
  final Map<String, dynamic> userDetailsData = jsonDecode(userDetails);

  return AuthUserModel.fromJson(userDetailsData);
}

// setter | user details
Future<void> setUserTokenHelper(String userToken) async {
  final sharedPrefs = await SharedPreferences.getInstance();
  // setting user to shared preferences
  sharedPrefs.setString(SHARED_PREF_KEY_TO_STORE_USER_TOKEN, userToken);
}
// getter | user details
Future<String> getUserTokenHelper() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  // setting user to shared preferences
  final userToken = sharedPrefs.getString(SHARED_PREF_KEY_TO_STORE_USER_TOKEN)!;
  return userToken;
}
