import 'package:ecomapp/app/app_shelf.dart';
import 'package:ecomapp/app/di.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
}
