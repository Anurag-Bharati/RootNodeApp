import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rootnode/app/app.dart';
import 'package:rootnode/helper/objectbox.dart';
import 'package:rootnode/state/objectbox_state.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  // ObjectBoxInstance.deleteDatabase();
  // Create an Object for ObjectBoxInstance
  ObjectBoxState.objectBoxInstance = await ObjectBoxInstance.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (value) => runApp(const MyApp()),
  );
}
