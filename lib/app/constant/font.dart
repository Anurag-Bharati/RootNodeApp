import 'package:flutter/material.dart';

class RootNodeFontStyle {
  static TextStyle get title => const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        overflow: TextOverflow.ellipsis,
        fontFamily: 'Poppins',
        height: 0,
        color: Colors.white70,
      );

  static TextStyle get body => const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
        height: 1.8,
        color: Colors.white70,
      );
  static TextStyle get subtitle => const TextStyle(
        fontSize: 14.0,
        fontFamily: 'Poppins',
        overflow: TextOverflow.ellipsis,
        height: 0,
        fontWeight: FontWeight.w400,
        color: Colors.white70,
      );
  static TextStyle get caption => const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        fontFamily: 'Poppins',
        height: 0,
        color: Colors.white70,
      );
  static TextStyle get label => const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        fontFamily: 'Poppins',
        height: 1.8,
        color: Colors.white54,
        overflow: TextOverflow.fade,
      );
}
