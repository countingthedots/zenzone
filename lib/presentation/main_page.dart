import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:zenzone/application/auth_service.dart';
import 'package:zenzone/application/getter.dart';
import 'package:zenzone/presentation/breathe_page.dart';
import 'package:zenzone/presentation/home_page.dart';
import 'package:zenzone/presentation/game_page.dart';
import 'package:zenzone/presentation/diary_page_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key /*, this.selectedPageIndex*/}) : super(key: key);
  //final int? selectedPageIndex;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedPageIndex = 0;
  final GlobalKey _homeShowcase = GlobalKey();
  final GlobalKey _diaryShowcase = GlobalKey();
  final GlobalKey _exerciseShowcase = GlobalKey();
  final GlobalKey _breathShowcase = GlobalKey();
  late final List<Widget> Pages; // Step 2: Declare Pages as late

  @override
  void initState() {
    super.initState();
    // Step 3: Initialize Pages inside initState
    Pages = [
      HomePage(homeShowcase: _homeShowcase, diaryShowase: _diaryShowcase, exerciseShowcase: _exerciseShowcase, breathShowcase: _breathShowcase),
      DiaryPage(),
      GamePage(),
      BreathePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
        onStart: (index, key) {
            print('onStart: $index, $key');
          },
          onComplete: (index, key) {
            print('onComplete: $index, $key');
          },
          blurValue: 1,
          autoPlayDelay: const Duration(seconds: 3),
          builder: (context) => Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 241, 229),
      resizeToAvoidBottomInset: false,
      body: Pages[selectedPageIndex!],
      bottomNavigationBar: BottomAppBar(
        height: 80,
          color: Color.fromARGB(255, 231, 203, 154),
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          Showcase(
            key: _homeShowcase,
            description: 'Hold home icon to log out',
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: selectedPageIndex == 0
                    ? Color.fromARGB(255, 224, 173, 85)
                    : Colors.transparent,
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedPageIndex = 0;
                  });
                },
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Sign Out'),
                        content: Text('Are you sure you want to sign out?'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                          ),
                          TextButton(
                            child: Text('Sign Out'),
                            onPressed: () {
                              // Close the dialog
                              Navigator.of(context).pop();
                              // Erase data and sign out
                              getter.get<GetStorage>().erase();
                              AuthService.signOut(context: context);
                              context.go('/auth');
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Ink(
                    child: Icon(
                      selectedPageIndex == 0
                          ? Icons.home
                          : Icons.home_outlined,
                      size: 35, color: Colors.black45
                      
                    ),
                  ),
                ),
              ),
            ),
          ),
          Showcase(
            key: _diaryShowcase,
            description: 'Here is you diary page',
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: selectedPageIndex == 1
                    ? Color.fromARGB(255, 224, 173, 85)
                    : Colors.transparent,
              ),
              child: IconButton(
                  onPressed: () => setState(() {
                        selectedPageIndex = 1;
                      }),
                  icon: selectedPageIndex == 1
                      ? Icon(Icons.book, size: 35, color: Colors.black45,)
                      : Icon(Icons.book_outlined, size: 35, color: Colors.black45,)),
            ),
          ),
          Showcase(
            key: _exerciseShowcase,
            description: 'Exercise page..',
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: selectedPageIndex == 2
                    ? Color.fromARGB(255, 224, 173, 85)
                    : Colors.transparent,
              ),
              child: IconButton(
              icon: selectedPageIndex == 2
                  ? Icon(Icons.lightbulb, size: 35, color: Colors.black45,)
                  : Icon(Icons.lightbulb_outline, size: 35, color: Colors.black45,),
              onPressed: () {
                setState(() {
                  selectedPageIndex = 2;
                });
              },
            )
            ),
          ),
          Showcase(
            key: _breathShowcase,
            description: 'Aaand.. breath page!',
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: selectedPageIndex == 3
                    ? Color.fromARGB(255, 224, 173, 85)
                    : Colors.transparent,
              ),
              child: IconButton(
              icon: selectedPageIndex == 3
                  ? Icon(Icons.healing, size: 35, color: Colors.black45,)
                  : Icon(Icons.healing_outlined, size: 35, color: Colors.black45,),
              onPressed: () {
                setState(() {
                  selectedPageIndex = 3;
                });
              },
            )
            ),
          ),
        ],
      )),
    ));
  }
}
