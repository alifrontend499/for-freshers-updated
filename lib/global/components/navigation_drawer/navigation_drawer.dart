import 'package:flutter/material.dart';
import 'package:forfreshers_app/global/dialogs/logout_dialog.dart';

// -- global
import 'package:forfreshers_app/global/models/auth_models.dart';
import 'package:forfreshers_app/global/components/navigation_drawer/widgets/link_widget.dart';
import 'package:forfreshers_app/global/consts/auth_consts.dart';
import 'package:forfreshers_app/global/consts/navigation_drawer_consts.dart';

// -- packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

// -- component
import 'package:forfreshers_app/global/components/navigation_drawer/widgets/top_view_widget.dart';
import 'package:forfreshers_app/global/components/navigation_drawer/settings/navigation_drawer_settings.dart';

// -- utilities
import 'package:forfreshers_app/utilities/helpers/app_snackbars.dart';
import 'package:forfreshers_app/utilities/helpers/auth_helpers.dart';
import 'package:forfreshers_app/utilities/routing/routing_consts.dart';

class AppNavigationDrawer extends ConsumerStatefulWidget {
  const AppNavigationDrawer({Key? key}) : super(key: key);

  @override
  ConsumerState<AppNavigationDrawer> createState() =>
      _AppNavigationDrawerState();
}

class _AppNavigationDrawerState extends ConsumerState<AppNavigationDrawer> {
  bool isUserLoggedIn = false;
  AuthUserModel? userDetails;

  @override
  void initState() {
    super.initState();
    // checking user
    getUserDetails();
  }

  // get logged in user details
  void getUserDetails() async {
    bool isLoggedIn = await isUserLoggedInHelper();
    AuthUserModel userDetailsRaw = await getUserDetailsHelper();
    print('userDetailsRaw $userDetailsRaw');
    print('isLoggedIn $isLoggedIn');

    if (isLoggedIn) {
      // setting value
      setState(() {
        isUserLoggedIn = isLoggedIn;
        userDetails = userDetailsRaw;
      });
    }
  }

  // log user out
  void logUserOut() async {
    // closing the dialog
    Navigator.pop(context);
    // closing the left drawer
    Navigator.of(context).pop();

    // logging user out
    appLogoutHelper(context, mounted);

    // hide all existing snack bars
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    // showing snack bar
    ScaffoldMessenger.of(context).showSnackBar(
      appSnackBarSuccess(AUTH_CONST_SNACKBAR_MSG_LOGOUT_SUCCESS),
    );

    // closing the drawer
    Navigator.pop(context);
  }

  // when user presses log out button
  void onLogout() {
    showDialog(
      context: context,
      builder: (context) =>
          LogoutTestDialog(logUserOut: logUserOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final activeRouteName = ref.watch(activeRouteNameProvider);

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // child | top bar
          const SizedBox(height: 10),
          navigationDrawerTopViewWidget(context, isUserLoggedIn, userDetails),
          const SizedBox(height: 10),

          // child | navigation links
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: defaultGap - 5,
                right: defaultGap - 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // child | links top view
                  Expanded(
                    child: Column(
                      children: [
                        // child | link widget
                        navigationDrawerLinkWidget(
                          () {
                            // closing the drawer
                            Navigator.pop(context);

                            // moving to page
                            Navigator.pushNamed(context, homeScreenRoute);
                          },
                          Icons.home_outlined,
                          NAVIGATION_DRAWER_CONSTS_LINK_TEXT_HOME,
                          isActive: false,
                        ),

                        // child | link widget
                        navigationDrawerLinkWidget(
                          () {
                            // closing the drawer
                            Navigator.pop(context);

                            // moving to page
                            Navigator.pushNamed(
                                context, listAllTestsScreenRoute);
                          },
                          Icons.lightbulb_circle_outlined,
                          NAVIGATION_DRAWER_CONSTS_LINK_TEXT_ALL_TESTS,
                          isActive: false,
                        ),

                        // child | link widget
                        navigationDrawerLinkWidget(
                          () {
                            // closing the drawer
                            Navigator.pop(context);

                            // moving to page
                            Navigator.pushNamed(
                                context, completedTestScreenRoute);
                          },
                          Icons.lightbulb_circle_outlined,
                          NAVIGATION_DRAWER_CONSTS_LINK_TEXT_COMPLETED_TESTS,
                          isActive: false,
                        ),

                        // child | link widget
                        navigationDrawerLinkWidget(
                          () {
                            // closing the drawer
                            Navigator.pop(context);
                          },
                          Icons.star_outline,
                          NAVIGATION_DRAWER_CONSTS_LINK_TEXT_GET_PREMIMUM,
                          isActive: false,
                        ),
                      ],
                    ),
                  ),

                  // child | logout

                  if (isUserLoggedIn) ...[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: defaultGap - 5,
                        right: defaultGap - 5,
                      ),
                      child: navigationDrawerLinkWidget(
                        () => onLogout(),
                        Icons.logout_outlined,
                        NAVIGATION_DRAWER_CONSTS_LINK_TEXT_LOGOUT,
                        isActive: false,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
