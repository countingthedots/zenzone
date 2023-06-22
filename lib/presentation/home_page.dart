import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zenzone/domain/quotes_controller.dart';

import '../application/locator.dart';

class HomePage extends StatelessWidget {
  String monsterAsset =
      'm${1 + locator.get<GetStorage>().read('monsterNumber')}.png';

  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 90),
        Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Stack(
              children: <Widget> [
                Container(
                  alignment: Alignment.center,
                  child: Image.asset('lib/assets/images/cloud.png', fit: BoxFit.cover),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 83,),
                    child: SizedBox(
                      width: 300,
                      height: 50,
                      child: Text(
                        QuotesController.getRandomQuote(),
                        style: const TextStyle(
                          fontSize: 14,
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

        // Align(
        //     alignment: Alignment.centerRight,
        //     child: SizedBox(
        //       height: 100,
        //       width: MediaQuery.of(context).size.width * 0.7,
        //       child: Text(
        //         QuotesController.getRandomQuote(),
        //         style: const TextStyle(
        //           fontSize: 20,
        //           fontFamily: 'BraahOne',
        //           color: Colors.black54,
        //           // Set text color
        //         ),
        //       ),
        //     )),
        SizedBox(height: 90),
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
