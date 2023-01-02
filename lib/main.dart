import 'package:flutter/material.dart';
import 'package:rootnode/helper/objectbox.dart';
import 'package:rootnode/screen/splash_screen.dart';
import 'package:rootnode/state/objectbox_state.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  // Create an Object for ObjectBoxInstance
  ObjectBoxState.objectBoxInstance = await ObjectBoxInstance.init();
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
      home: const SplashScreen()));
}
