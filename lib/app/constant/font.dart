import 'package:flutter/material.dart';

class RootNodeFontStyle {
  static TextStyle get title => const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        fontFamily: 'Poppins',
        height: 1.8,
        color: Color(0xFFEEEEEE),
      );

  static TextStyle get body => const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
        height: 1.8,
        color: Color(0xFFEEEEEE),
      );
  static TextStyle get subtitle => const TextStyle(
        fontSize: 12.0,
        fontFamily: 'Poppins',
        height: 1.8,
        color: Color(0xFFEEEEEE),
      );
  static TextStyle get caption => const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        fontFamily: 'Poppins',
        height: 0,
        color: Color(0xFFEEEEEE),
      );
  static TextStyle get label => const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        fontFamily: 'Poppins',
        height: 1.8,
        color: Colors.white54,
      );
}
