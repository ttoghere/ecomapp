import 'dart:async';
import 'package:ecomapp/presentation/management/management_shelf.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  _goNext() {
    Navigator.of(context).pushReplacementNamed(Routes.onBoardRoute);
  }

  _startDelay() {
    _timer = Timer(const Duration(milliseconds: DurationConstants.d1000), () {
      _goNext();
    });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageManagement.appLogo,
            ),
          ],
        ),
      ),
    );
  }
}
