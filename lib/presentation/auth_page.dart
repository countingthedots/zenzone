import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:zenzone/application/auth_service.dart';
import 'package:zenzone/application/getter.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              const Text('Log in to get\n  into ZenZone',
                  style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                      fontSize: 37,
                      fontFamily: 'BraahOne',
                      height: 1.41),
              
        ),
        const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical:20),
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        setState(() {});
              
                        User? user = await AuthService.signInWithGoogle(context: context);
              
                        setState(() {});
              
                        if (user != null) {
                          print('user signed in');
                          if(getter.get<GetStorage>().read('isIntroDone') == true)
                            context.go('/home');
                          else
                            context.go('/intro');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: const Color.fromARGB(235, 215, 156, 55),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      icon: const FaIcon(FontAwesomeIcons.google, color: Colors.white),
                      label: const Text(
                            'Sign in with Google',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                height: 1.41),
                          )
                    ),
                    const SizedBox(height: 10,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(235, 184, 162, 125),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        getter.get<GetStorage>().write('skippedAuth', true);
                        if(getter.get<GetStorage>().read('isIntroDone') == true)
                            context.go('/home');
                        else
                          context.go('/intro');
                      }, 
                      child: const Text(
                              'Skip',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  height: 1.41),
                            )),
                  ],
                ),
              ),
            ],
          ),
      ),
      ),
    );
  }
}