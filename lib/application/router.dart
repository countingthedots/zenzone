import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:zenzone/presentation/intro_page.dart';
import 'package:zenzone/presentation/main_page.dart';
import 'package:zenzone/presentation/splash_screen_page.dart';
import 'package:zenzone/presentation/auth_page.dart';

GoRouter goRouter = GoRouter(initialLocation: '/splash_screen', observers: [
  HeroController()
], routes: [
  GoRoute(
    name: 'splash_screen',
    path: '/splash_screen',
    builder: (context, state) => SplashScreenPage(),
  ),
  GoRoute(
    name: 'intro',
    path: '/intro',
    builder: (context, state) => IntroPage(),
  ),
  GoRoute(
    name: 'home',
    path: '/home',
    builder: (context, state) => MainPage(),
  ),
  GoRoute(
    name: 'auth',
    path: '/auth',
    builder: (context, state) => AuthPage(),
  ),
]);
