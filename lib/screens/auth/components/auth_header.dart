import 'package:flutter/material.dart';
import 'package:forfreshers_app/global/colors/app_colors.dart';
import 'package:forfreshers_app/global/settings/app_settings.dart';
import 'package:forfreshers_app/utilities/routing/routing_consts.dart';

AppBar getAuthAppBar(
  BuildContext context,
) =>
    AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.cancel_outlined,
          size: appSettingsBarLeadingSize,
        ),
        onPressed: () => Navigator.pushNamed(context, homeScreenRoute),
        color: appColorPrimary,
        splashColor: Colors.transparent,
        splashRadius: appSettingsBarLeadingSplashRadius,
      ),
    );
