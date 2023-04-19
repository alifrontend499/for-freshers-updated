import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forfreshers_app/global/colors/app_colors.dart';

// external packages
import 'package:google_fonts/google_fonts.dart';

ThemeData getAppThemeData(BuildContext context) {
  return ThemeData(
    splashColor: Colors.transparent,
    textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: appColorLightGrey,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    // highlightColor: Colors.red
  );
}