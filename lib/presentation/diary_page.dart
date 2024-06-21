import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zenzone/application/getter.dart';
import 'package:zenzone/domain/models/diary_entry.dart';
import 'package:intl/intl.dart';
import 'package:zenzone/presentation/diary_page/emotion_selector.dart';
import 'package:zenzone/presentation/diary_page/new_entry_widget.dart';
import '../domain/diary_domain_controller.dart';
import 'diary_page/emotion_calendar.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({Key? key}) : super(key: key);
  
  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  String today = DateFormat('dd.MM.yyyy').format(DateTime.now());
  bool isCalendarVisible = false;
  String? selectedDate;
  final TextEditingController _controller = TextEditingController();
  DiaryEntry? _entry;
  bool shouldUpdatePage = true;
  
  Future<List<DiaryEntry>>? futureDiary;

  @override
  Widget build(BuildContext context) {
    if(shouldUpdatePage || futureDiary == null) {
      futureDiary = getter.get<DiaryDomainController>().getDiary();
    }
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height - 80,
        child: Column(
          children: [
            const SizedBox(height: 20),
            FutureBuilder<List<DiaryEntry>>(
              key: ValueKey(shouldUpdatePage),
              future: futureDiary,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator());
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      
                      if(selectedDate != null) {
                          _entry = snapshot.data!.firstWhere(
                            (entry) => entry.date == selectedDate,
                            orElse: () => DiaryEntry(
                              date: selectedDate!,
                              emotion: '',
                              content: '',
                            ),
                          );
                          if(shouldUpdatePage)
                          {
                            _controller.text = _entry!.content;
                            shouldUpdatePage = false;
                          }
                          
                          return NewEntryWidget(entry: _entry!, controller: _controller, onSave: onEntrySaved, canGoBack: true,);
                      }
                      else if (!snapshot.data!.any((e) => e.date == today)){
                        if(shouldUpdatePage)
                        {
                          _controller.text = '';
                          shouldUpdatePage = false;
                        }
                        _entry = DiaryEntry(
                          date: today,
                          emotion: '',
                          content: '',
                        );
                        return NewEntryWidget(entry: _entry!, controller: _controller, onSave: onEntrySaved, canGoBack: false,);
                      }
                      else{
                        return EmotionCalendar(
                          diary: snapshot.data!,
                          onDaySelected: (selectedDate) {
                            setState(() {
                              this.selectedDate = selectedDate;
                            });
                          },
                        );
                      }
                    }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void onEntrySaved() {
    Future.delayed(Duration.zero, () {
      setState(() {
        shouldUpdatePage = true;
        selectedDate = null;
      });
      getter.get<GetStorage>().write('selectedEmotion', null);
    });
  } 
}
