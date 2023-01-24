import 'package:flutter/material.dart';

const TextStyle topViewTextSignInStyles = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w600,
);
const TextStyle topViewTextViewAccountStyles = TextStyle(
  fontSize: 13,
);

TextStyle linkTextStyles({bool isActive = false}) => TextStyle(
      fontSize: 15,
      color: isActive ? Colors.white : Colors.black,
    );
