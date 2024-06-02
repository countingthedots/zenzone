import 'package:flutter/material.dart';
import 'package:zenzone/application/getter.dart';
import 'package:zenzone/domain/models/diary_entry.dart';
import 'package:intl/intl.dart';
import 'package:zenzone/presentation/diary_page/emotion_selector.dart';
import '../domain/diary_domain_controller.dart';



class DiaryPage extends StatefulWidget {
  const DiaryPage({Key? key}) : super(key: key);


  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  String date = DateFormat('dd.MM.yyyy').format(DateTime.now());
  final TextEditingController _controller = TextEditingController();
  bool isCalendarVisible = false;
  bool wasDataCollected = false;
  bool newDateSet = false;
  String selectedEmotion = '';
  
  late EmotionSelector emotionSelector;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ElevatedButton(
                onPressed: () async {
                  DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 800)),
                      lastDate: DateTime.now());
                  if (newDate != null) {
                    setState(() {
                      newDateSet = true;
                      date = DateFormat('dd.MM.yyyy').format(newDate);
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(50, 50),
                ),
                child: const Icon(Icons.calendar_month_outlined),
              ),
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          Text(date,
              style: const TextStyle(fontFamily: 'BraahOne', fontSize: 34, color: Colors.black45)),
          const SizedBox(
            height: 50,
          ),
          FutureBuilder<DiaryEntry>(
            future:
                getter.get<DiaryDomainController>().getDiaryEntryForDay(date),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    if (!wasDataCollected) {
                      _controller.text = snapshot.data!.content;
                      emotionSelector = EmotionSelector(
                        onEmotionSelected: (emotion) {
                            selectedEmotion = emotion;
                        },
                      );
                      wasDataCollected = true;
                    } else {
                      if (newDateSet) {
                        _controller.text = snapshot.data!.content;
                        emotionSelector = EmotionSelector(
                          onEmotionSelected: (emotion) {
                              selectedEmotion = emotion;
                          },
                        );
                        newDateSet = false;
                      }
                    }
                    return Column(
                      children: [
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
            },
          ),
        ],
      ),
    );
  }
}
