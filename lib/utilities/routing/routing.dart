import 'package:flutter/material.dart';

// -- utilities
import 'package:forfreshers_app/utilities/routing/routing_consts.dart';

// all screens
import 'package:forfreshers_app/screens/home/home_screen.dart';
import 'package:forfreshers_app/screens/test_details/test_details_screen.dart';
import 'package:forfreshers_app/screens/list_all_tests/list_all_tests_screen.dart';
import 'package:forfreshers_app/screens/test_view/test_view_screen.dart';
import 'package:forfreshers_app/screens/completed_tests/completed_tests_screen.dart';
import 'package:forfreshers_app/screens/auth/login/login_screen.dart';
import 'package:forfreshers_app/screens/user_profile/user_profile_screen.dart';
import 'package:forfreshers_app/screens/auth/signup/signup_screen.dart';
import 'package:forfreshers_app/screens/auth/forgot_password/forgot_password_screen.dart';


Route<dynamic> generatedRoutes(RouteSettings settings) {
  switch(settings.name) {
    case homeScreenRoute:
      return MaterialPageRoute(builder: (context) => const HomeScreen());

    case testDetailsScreenRoute:
      return MaterialPageRoute(builder: (context) => const TestDetailsScreen());

    case listAllTestsScreenRoute:
      return MaterialPageRoute(builder: (context) => const ListAllTestsScreen());

    case testViewScreenRoute:
      return MaterialPageRoute(builder: (context) => const TestViewScreen());

    case completedTestScreenRoute:
      return MaterialPageRoute(builder: (context) => const CompletedTestsScreen());

    case userProfileScreenRoute:
      return MaterialPageRoute(builder: (context) => const UserProfileScreen());

    case loginScreenRoute:
      return MaterialPageRoute(builder: (context) => const LoginScreen());

    case signUpScreenRoute:
      return MaterialPageRoute(builder: (context) => const SignUpScreen());

    case forgotPasswordScreenRoute:
      return MaterialPageRoute(builder: (context) => const ForgotPasswordScreen());

    default:
      return MaterialPageRoute(builder: (context) => const HomeScreen());
  }
}