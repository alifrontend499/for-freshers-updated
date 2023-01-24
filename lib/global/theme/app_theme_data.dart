import 'package:flutter/material.dart';

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
    )
    // highlightColor: Colors.red
  );
}