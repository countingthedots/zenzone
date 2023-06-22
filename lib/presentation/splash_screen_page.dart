import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:zenzone/application/locator.dart';
import 'dart:io' show Platform;

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    navigateToNextPage();
  }

  void navigateToNextPage() async {
    // Simulating a delay of 7 seconds for the splash screen
    await Future.delayed(const Duration(seconds: 7));

    if (FirebaseAuth.instance.currentUser != null) {
      if (locator.get<GetStorage>().read('isIntroDone') == 'true')
        context.go('/home');
      else
        context.go('/intro');
    }
    else {
      context.go('/auth');
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color.fromRGBO(189, 204, 173, 1), // Sage green background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You have entered the',
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(
                fontFamily: 'BraahOne',
                color: const Color.fromRGBO(187, 173, 204, 1.0),
              ),
            ),
            _textLiquidFillAnimation()
          ],
        ),
      ),
    );
  }


  Widget _textLiquidFillAnimation() {
    return SizedBox(
      child: Center(
        child: TextLiquidFill(
          text: 'ZENZONE',
          waveDuration: const Duration(seconds: 4),
          // loadDuration: Duration(seconds: 4),
          waveColor: const Color.fromRGBO(187, 173, 204, 1.0),
          boxBackgroundColor: const Color.fromRGBO(189, 204, 173, 1),
          textStyle: const TextStyle(
            fontFamily: 'BraahOne',
            fontSize: 80.0,
          ),
        ),
      ),
    );
  }
}