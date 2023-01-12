import 'package:flutter/cupertino.dart';
import 'package:rootnode/screen/home_screen.dart';
import 'package:rootnode/screen/login_screen.dart';
import 'package:rootnode/screen/register_screen.dart';
import 'package:rootnode/screen/splash_screen.dart';

var getAppRoutes = <String, WidgetBuilder>{
  SplashScreen.route: (context) => const SplashScreen(),
  LoginScreen.route: (context) => const LoginScreen(),
  RegisterScreen.route: (context) => const RegisterScreen(),
  HomeScreen.route: (context) => const HomeScreen(),
};
