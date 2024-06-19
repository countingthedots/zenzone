import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:zenzone/presentation/breathe_page.dart';
import 'package:zenzone/presentation/home_page.dart';
import 'package:zenzone/presentation/game_page.dart';
import 'package:zenzone/presentation/diary_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key /*, this.selectedPageIndex*/}) : super(key: key);
  //final int? selectedPageIndex;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedPageIndex = 0;
  final List<Widget> Pages = [
    HomePage(),
    DiaryPage(),
    GamePage(),
    BreathePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 241, 229),
      resizeToAvoidBottomInset: false,
      body: ShowCaseWidget(
        onStart: (index, key) {
            print('onStart: $index, $key');
          },
          onComplete: (index, key) {
            print('onComplete: $index, $key');
          },
          blurValue: 1,
          autoPlayDelay: const Duration(seconds: 3),
          builder: (context) => Pages[selectedPageIndex!]),
      bottomNavigationBar: BottomAppBar(
        height: 80,
          color: Color.fromARGB(255, 229, 197, 141),
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () => setState(() {
                    selectedPageIndex = 0;
                  }),
              icon: selectedPageIndex == 0
                  ? Icon(Icons.home, size: 35, color: Colors.black45,)
                  : Icon(Icons.home_outlined, size: 35, color: Colors.black45,)),
          IconButton(
            icon: selectedPageIndex == 1
                ? Icon(Icons.book, size: 35, color: Colors.black45,)
                : Icon(Icons.book_outlined, size: 35, color: Colors.black45,),
            onPressed: () {
              setState(() {
                selectedPageIndex = 1;
              });
            },
          ),
          IconButton(
            icon: selectedPageIndex == 2
                ? Icon(Icons.lightbulb, size: 35, color: Colors.black45,)
                : Icon(Icons.lightbulb_outline, size: 35, color: Colors.black45,),
            onPressed: () {
              setState(() {
                selectedPageIndex = 2;
              });
            },
          ),
          IconButton(
            icon: selectedPageIndex == 3
                ? Icon(Icons.healing, size: 35, color: Colors.black45,)
                : Icon(Icons.healing_outlined, size: 35, color: Colors.black45,),
            onPressed: () {
              setState(() {
                selectedPageIndex = 3;
              });
            },
          ),
        ],
      )),
    );
  }
}
