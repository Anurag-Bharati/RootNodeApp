import 'package:flutter/material.dart';

void switchRouteByPush(BuildContext context, Widget screen) async {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => screen,
      ));
}

void switchRouteByPushReplace(BuildContext context, Widget screen) async {
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => screen,
      ));
}
