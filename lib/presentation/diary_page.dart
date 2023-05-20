import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DiaryPage extends StatelessWidget{
  const DiaryPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Diary Page'),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.book_outlined),
                onPressed: () {
                  // GoRouter.of(context).go('/home');
                },
              ),
              IconButton(
                icon: Icon(Icons.lightbulb_outline),
                onPressed: () {
                  // GoRouter.of(context).go('/home');
                },
              ),
              IconButton(
                icon: Icon(Icons.healing_outlined),
                onPressed: () {
                  // GoRouter.of(context).go('/home');
                },
              ),
            ],
          )
      ),
    );
  }
}
