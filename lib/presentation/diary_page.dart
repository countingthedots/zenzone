import 'package:flutter/material.dart';
import 'package:zenzone/application/getter.dart';
import 'package:zenzone/domain/models/diary_entry.dart';
import 'package:intl/intl.dart';
import 'package:zenzone/presentation/diary_page/emotion_selector.dart';
import '../domain/diary_domain_controller.dart';
import 'diary_page/emotion_calendar.dart';



class DiaryPage extends StatefulWidget {
  const DiaryPage({Key? key}) : super(key: key);


  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  String date = DateFormat('dd.MM.yyyy').format(DateTime.now());
  final TextEditingController _controller = TextEditingController();
  bool isCalendarVisible = false;

  String selectedEmotion = '';
  
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
              style: const TextStyle(fontFamily: 'BraahOne', fontSize: 34, color: Colors.black45)),
          const SizedBox(
            height: 50,
          ),
          FutureBuilder<List<DiaryEntry>>(
            future:
                getter.get<DiaryDomainController>().getDiary(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } 
                  else {
                    if (snapshot.data!.any((e) => e.date == date) ) {
                      return EmotionCalendar();
                      // _controller.text = snapshot.data!.firstWhere((e) => e.date == date);
                      // emotionSelector = EmotionSelector(
                      //   onEmotionSelected: (emotion) {
                      //       selectedEmotion = emotion;
                      //   },
                      // );
                    }
                    else{
                      //to be replaced with new entry widget
                    return Column(
                      children: [
                        const Text("Helloo! How are you feeling now?",
                            style: TextStyle(
                                fontFamily: 'BraahOne',
                                fontSize: 24,
                                color: Color.fromARGB(255, 207, 177, 125))
                        ),

                        emotionSelector,
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                                textSelectionTheme:
                                    const TextSelectionThemeData(
                                        selectionColor: Colors.blueGrey)),
                            child: TextField(
                                controller: _controller,
                                minLines: 5,
                                maxLines: 10,
                                decoration: const InputDecoration(
                                  labelText: 'Tell us how was your day',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors
                                          .blueGrey, // Set the outline border color
                                      width:
                                          2.0, // Set the outline border width
                                    ),
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors
                                        .blueGrey, // Set the color of the labeled text
                                  ),
                                  //contentPadding: EdgeInsets.only(bottom: 100),
                                )),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.blueGrey, // Background color
                          ),
                          onPressed: () {
                            if (selectedEmotion == '') {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    const Text('First, choose the emotion'),
                                action: SnackBarAction(
                                  label: 'Ok',
                                  onPressed: () {},
                                ),
                              ));
                            } else {
                              getter
                                  .get<DiaryDomainController>()
                                  .saveDiaryEntry(
                                      date, _controller.text, selectedEmotion);
                            }
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    );
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
