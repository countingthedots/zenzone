import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zenzone/domain/diary_domain_controller.dart';
import 'package:zenzone/presentation/diary_page/emotion_selector.dart';

import '../../application/getter.dart';

class NewEntryWidget extends StatefulWidget {
  NewEntryWidget({required this.date, Key? key}) : super(key: key);
  final String date;

  @override
  State<NewEntryWidget> createState() => _NewEntryWidgetState();
}

class _NewEntryWidgetState extends State<NewEntryWidget> {
  String selectedEmotion = '';
  final TextEditingController _controller = TextEditingController();

  late EmotionSelector emotionSelector;

  @override
  void initState() {
    super.initState();
    emotionSelector = EmotionSelector(
      onEmotionSelected: (emotion) {
        selectedEmotion = emotion;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Helloo! How are you feeling now?",
            style: TextStyle(
                fontFamily: 'BraahOne',
                fontSize: 24,
                color: Color.fromARGB(255, 207, 177, 125))),
        emotionSelector,
        const SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Theme(
            data: Theme.of(context).copyWith(
                textSelectionTheme: const TextSelectionThemeData(
                    selectionColor: Colors.blueGrey)),
            child: TextField(
                controller: _controller,
                minLines: 5,
                maxLines: 10,
                decoration: const InputDecoration(
                  labelText: 'Tell us how was your day',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueGrey, // Set the outline border color
                      width: 2.0, // Set the outline border width
                    ),
                  ),
                  labelStyle: TextStyle(
                    color: Colors.blueGrey, // Set the color of the labeled text
                  ),
                  //contentPadding: EdgeInsets.only(bottom: 100),
                )),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey, // Background color
          ),
          onPressed: () {
            if (selectedEmotion == '') {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('First, choose the emotion'),
                action: SnackBarAction(
                  label: 'Ok',
                  onPressed: () {},
                ),
              ));
            } else {
              getter.get<DiaryDomainController>().saveDiaryEntry(
                  widget.date, _controller.text, selectedEmotion);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
