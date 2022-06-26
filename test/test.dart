import 'package:ecomapp/app/app.dart';
import 'package:flutter/material.dart';

class UiTests extends StatefulWidget {
  const UiTests({Key? key}) : super(key: key);
  //How to change state of variable from another widget with methods
  void updateAppState() {
    MyApp.instance.appState = 10;
  }
  void printAppState() {
    print(MyApp.instance.appState);
  }

  @override
  State<UiTests> createState() => _UiTestsState();
}

class _UiTestsState extends State<UiTests> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
