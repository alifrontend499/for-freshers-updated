import 'package:flutter/material.dart';

// -- global
import 'package:forfreshers_app/global/consts/app_consts.dart';

// snack bar | api error
final appSnackBarApiError = SnackBar(
  content: Text(APP_CONST_SNACKBAR_API_ERROR),
  backgroundColor: Colors.red,
);

appSnackBarApiErrorCustomMsg(String msg) => SnackBar(
  content: Text(msg),
  backgroundColor: Colors.red,
);

// snack bar | api error
appSnackBarSuccess(String msg) => SnackBar(
      content: Text(msg),
      backgroundColor: Colors.greenAccent,
    );
