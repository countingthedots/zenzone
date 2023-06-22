import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:zenzone/application/auth_service.dart';
import 'package:zenzone/application/locator.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Center(
          child: Text('Register Page'),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 12),
          child: ElevatedButton.icon(
            onPressed: () async {
              setState(() {});

              User? user = await AuthService.signInWithGoogle(context: context);

              setState(() {});

              if (user != null) {
                print('user signed in');
                if(locator.get<GetStorage>().read('isIntroDone') == true)
                  context.go('/home');
                else
                  context.go('/intro');
              }
            },
            style: ButtonStyle(
              elevation: MaterialStateProperty.all<double>(6.0),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              backgroundColor:
              MaterialStateProperty.all<Color>(Colors.white),
            ),
            icon: const FaIcon(FontAwesomeIcons.google, color: Colors.red),
            label: const Text(
                  'Sign in with Google',
                  style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      height: 1.41),
                )
          ),
        ),
      ),
    );
  }
}