import 'package:flutter/material.dart';
import 'package:rootnode/screen/home_screen.dart';

void main(List<String> args) {
  runApp(MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          // For OverScroll Glow Effect
          accentColor: const Color(0xFFF1F1F1),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: const Color(0xFF111111),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen()));
}
