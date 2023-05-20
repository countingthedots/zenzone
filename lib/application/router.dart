import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:zenzone/presentation/intro_page.dart';
import 'package:zenzone/presentation/home_page.dart';
import 'package:zenzone/presentation/splash_screen_page.dart';
import 'package:zenzone/presentation/diary_page.dart';

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
    builder: (context, state) => const IntroPage(),
  ),
  GoRoute(
    name: 'home',
    path: '/home',
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    name: 'diary',
    path: '/diary',
    builder: (context, state) => const DiaryPage(),
  )
]);
