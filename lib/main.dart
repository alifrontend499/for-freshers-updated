import 'package:flutter/material.dart';

// -- packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

// -- global
import 'package:forfreshers_app/global/theme/app_theme_data.dart';

// -- utilities
import 'package:forfreshers_app/utilities/routing/routing.dart' as router;
import 'package:forfreshers_app/utilities/routing/routing_consts.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'For Freshers',
      onGenerateRoute: router.generatedRoutes,
      initialRoute: homeScreenRoute,
      theme: getAppThemeData(context),
    );
  }
}
