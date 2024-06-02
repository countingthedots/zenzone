import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({Key? key}) : super(key: key);

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  //const ExercisePage({Key? key}) : super(key: key);
  final dataKey = GlobalKey();

  final List<String> _myList = [
    '5 things you can see',
    '4 things you can touch',
    '3 things you can hear',
    '2 things you can smell',
    '1 thing you can taste',
  ];
  int currentIndex = 0;
  final ItemScrollController _scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Center(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/home');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(50, 50),
                    ),
                    child: const Icon(Icons.arrow_back_rounded),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 150,
            ),
            const Center(
              child: Text('FIND',
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'BraahOne',
                    color: Colors.blueGrey,
                  )),
            ),
            Center(
              child: SizedBox(
                height: 350,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Center(
                  child: ScrollablePositionedList.builder(
                    itemScrollController: _scrollController,
                    itemCount: _myList.length,
                    itemBuilder: (context, index) {
                      return AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 400),
                        style: TextStyle(
                          fontFamily: 'BraahOne',
                          color: index == currentIndex
                              ? Colors.black
                              : Colors.grey,
                          fontWeight: index == currentIndex
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: index == currentIndex ? 34 : 30,
                        ),
                        child: Text(
                          _myList[index],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blueGrey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(200, 50),
              ),
              onPressed: () => setState(() {
                currentIndex = (currentIndex + 1) % _myList.length;
                _scrollController.scrollTo(
                  index: currentIndex,
                  duration: const Duration(milliseconds: 400),
                );
              }),
              child: const Text(
                'Next',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
