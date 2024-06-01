import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zenzone/domain/quotes_controller.dart';

import '../application/getter.dart';

class HomePage extends StatelessWidget {
  String monsterAsset =
      'm${1 + getter.get<GetStorage>().read('monsterNumber')}.png';

  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Stack(
              children: <Widget> [
                Container(
                  alignment: Alignment.center,
                  child: Image.asset('lib/assets/images/cloud.png', fit: BoxFit.cover),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 90, left: 6.0, right: 0),
                    child: SizedBox(
                      width: 300,
                      height: 100,
                      child: Text(
                        QuotesController.getRandomQuote(),
                        style: const TextStyle(
                          fontSize: 22,
                          fontFamily: 'BraahOne',
                          color: Colors.black54,
                          // Set text color
                        ),
                      ),
                    ),
                  ),
                ),
             ],
                ),
          ),
        ),

        Center(
          child: Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
                width: 300,
                child: Image.asset('lib/assets/images/$monsterAsset')),
          ),
        ),
      ],
    );
  }
}
