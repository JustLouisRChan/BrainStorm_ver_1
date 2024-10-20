import 'package:flutter/material.dart';

class AppTypography {
  static const String fontFamily =
      'Poppins'; // You can replace with your desired font

  static TextStyle light = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(86, 63, 232, 1),
    fontFamily: fontFamily,
  );

  static TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontFamily: fontFamily,
  );

  static TextStyle bodyText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.grey[800],
    fontFamily: fontFamily,
  );

  static TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.grey[600],
    fontFamily: fontFamily,
  );

  static TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: fontFamily,
  );
}
