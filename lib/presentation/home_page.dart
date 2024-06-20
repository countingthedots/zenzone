import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:zenzone/domain/quotes_controller.dart';

import '../application/getter.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.homeShowcase, required this.diaryShowase, required this.exerciseShowcase, required this.breathShowcase});

  final GlobalKey homeShowcase;
  final GlobalKey diaryShowase;
  final GlobalKey exerciseShowcase;
  final GlobalKey breathShowcase;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String monsterAsset =
      'm${1 + getter.get<GetStorage>().read('monsterNumber')}.png';
  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();
  @override
  void initState() {
    super.initState();
    if(getter.get<GetStorage>().read('homepageTutorialShown') != 'true'){
      WidgetsBinding.instance.addPostFrameCallback((_) =>
        ShowCaseWidget.of(context).startShowCase([_one, _two, widget.homeShowcase, widget.diaryShowase, widget.exerciseShowcase, widget.breathShowcase])
      );
      getter.get<GetStorage>().write('homepageTutorialShown', 'true');
    }
  }

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
                          color: Color.fromRGBO(62, 140, 175, 1.0),
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
                      child: Showcase(
                        key: _two,
                        description: 'Here you will find a new quote every day',
                        child: Text(
                          QuotesController.todaysQuote,
                          style: const TextStyle(
                            fontSize: 22,
                            fontFamily: 'BraahOne',
                            color: Color.fromRGBO(62, 140, 175, 1.0),
                            // Set text color
                          ),
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
                          child: Showcase(
                            key: _one,
                            description: 'Welcome to ZenZone! Let me guide you through the app',
                            child: Image.asset('lib/assets/images/$monsterAsset'))),
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
