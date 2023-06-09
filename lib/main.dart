import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zenzone/application/locator.dart';
import 'package:zenzone/application/router.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  // if(!Platform.isWindows){
  //   await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // }
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  if(kIsWeb || Platform.isAndroid || Platform.isIOS)
    {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
        );
    }

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
