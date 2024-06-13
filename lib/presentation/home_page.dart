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
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/images/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 50),
          Align(
            alignment: Alignment.centerRight,
            child: Stack(
              children: <Widget> [
                Container(
                  alignment: Alignment.topRight,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 50, left: 6.0, right: 0),
                    child: SizedBox(
                      width: 300,
                      height: 100,
                      child: Text(
                        'ADVICE OF THE DAY',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 36,
                          fontFamily: 'BraahOne',
                          color: Color.fromARGB(255, 	207, 177, 125),
                          // Set text color
                        ),
                      ),
                    ),
                  
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.29, left: 0.0, right: 40),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 100,
                      child: Text(
                        QuotesController.todaysQuote,
                        style: const TextStyle(
                          fontSize: 22,
                          fontFamily: 'BraahOne',
                          color: Color.fromARGB(255, 	207, 177, 125),
                          // Set text color
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.35, left: 0.0, right: 0.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Image.asset('lib/assets/images/$monsterAsset')),
                    ),
                  ),
                ),
             ],
                ),
          ),
    
          
        ],
      ),
    );
  }
}
