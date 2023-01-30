import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String message, Color color,
    {dismissable = true}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      // width: MediaQuery.of(context).size.width * 0.8,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
      content: Text(message),
      duration: const Duration(milliseconds: 1500),
      margin: const EdgeInsets.all(20),
      action: dismissable
          ? SnackBarAction(
              label: "OK",
              onPressed: () {},
              textColor: Colors.white,
            )
          : null,
    ),
  );
}
