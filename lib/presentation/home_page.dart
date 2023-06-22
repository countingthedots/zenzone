import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../application/locator.dart';

class HomePage extends StatelessWidget {
  String monsterAsset = 'm${1 +  locator.get<GetStorage>().read('monsterNumber')}.png';

  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: 300, child: Image.asset('lib/assets/images/$monsterAsset')),
    );
  }
}
