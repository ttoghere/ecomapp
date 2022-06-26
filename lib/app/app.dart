import 'package:ecomapp/presentation/management/management_shelf.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  // const MyApp({Key? key}) : super(key: key); // Default Constructor
  MyApp._internal(); // Private Named Constructor
  static final instance = MyApp._internal(); // Single İnstance == Singleton
  factory MyApp() => instance; // Factory for the singleton
  int appState = 0;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Tut Ecom App",
      theme: getApplicationTheme(),
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
    );
  }
}
