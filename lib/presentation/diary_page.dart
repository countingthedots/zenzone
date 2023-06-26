import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zenzone/application/locator.dart';
import 'package:zenzone/domain/models/diary_entry.dart';
import 'package:intl/intl.dart';
import '../domain/diary_domain_controller.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  String date = DateFormat('dd.MM.yyyy').format(DateTime.now());
  final TextEditingController _controller = TextEditingController();
  String selectedEmotion = '';
  bool isCalendarVisible = false;
  //String newDate = DateFormat('dd.MM.yyyy').format(DateTime.now());

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
                  if (newDate != null)
                  {
                    setState(() {
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
            height: 100,
          ),
          Text(date),
          const SizedBox(
            height: 50,
          ),
          Row(
            children: [
              GestureDetector(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage('lib/assets/images/delighted_emotion.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    selectedEmotion = 'happy';
                  });
                },
              ),
              GestureDetector(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/assets/images/sad_emotion.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    selectedEmotion = 'sad';
                  });
                },
              ),
              GestureDetector(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/assets/images/ok_emotion.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    selectedEmotion = 'ok';
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          FutureBuilder<DiaryEntry>(
            future:
                locator.get<DiaryDomainController>().getDiaryEntryForDay(date),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                  break;
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else {
                    _controller.text = snapshot.data!.content;
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                              controller: _controller,
                              minLines: 5,
                              maxLines: 10,
                              decoration: const InputDecoration(
                                labelText: 'Tell us how was your day',
                                border: OutlineInputBorder(),
                                //contentPadding: EdgeInsets.only(bottom: 100),
                              )),
                        ),
                        ElevatedButton(
                          onPressed: () async {
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
                            }
                            await locator
                                .get<DiaryDomainController>()
                                .saveDiaryEntry(
                                    date, _controller.text, selectedEmotion);
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
