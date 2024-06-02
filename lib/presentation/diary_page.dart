import 'package:flutter/material.dart';
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
  String date = DateFormat('dd.MM.yyyy').format(DateTime.now());
  bool isCalendarVisible = false;

  late EmotionSelector emotionSelector;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 110,
          ),
          Text(date,
              style: const TextStyle(
                  fontFamily: 'BraahOne', fontSize: 34, color: Colors.black45)),
          const SizedBox(
            height: 50,
          ),
          FutureBuilder<List<DiaryEntry>>(
            future: getter.get<DiaryDomainController>().getDiary(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    if (snapshot.data!.any((e) => e.date == date)) {
                      return EmotionCalendar(
                        diary: snapshot.data!,
                      );
                    } else {
                      return NewEntryWidget(date: date);
                    }
                  }
              }
            },
          ),
        ],
      ),
    );
  }
}
