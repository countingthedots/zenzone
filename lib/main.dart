import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:zenzone/application/router.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const ZenZone());
}

class ZenZone extends StatelessWidget {
  const ZenZone({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'ZenZone',
        routerDelegate: goRouter.routerDelegate,
        routeInformationParser: goRouter.routeInformationParser,
        routeInformationProvider: goRouter.routeInformationProvider,
      );
}
