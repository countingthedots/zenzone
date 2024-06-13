import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zenzone/domain/diary_domain_controller.dart';
import 'package:zenzone/presentation/diary_page/emotion_selector.dart';

import '../../application/getter.dart';
import '../../domain/models/diary_entry.dart';

class NewEntryWidget extends StatefulWidget {
  NewEntryWidget({required this.entry, required this.controller, required this.onSave, Key? key}) : super(key: key);
  final DiaryEntry entry; 
  final TextEditingController controller;
  final Function() onSave;

  @override
  State<NewEntryWidget> createState() => _NewEntryWidgetState();
}

class _NewEntryWidgetState extends State<NewEntryWidget> {
  String selectedEmotion = '';

  late EmotionSelector emotionSelector;

  @override
  void initState() {
    super.initState();
    emotionSelector = EmotionSelector(
      defaultEmotion: widget.entry.emotion,
      onEmotionSelected: (emotion) {
        selectedEmotion = emotion;
      },
    );
    
  }

  @override
  @override
Widget build(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height - 100,
    child: Padding( // Add Padding
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom > 100 ?  MediaQuery.of(context).viewInsets.bottom - 90 : 0 ),
      child: Column(
        children: [
          Spacer(flex: 2,),
          const Text("Hello!\nHow are you feeling now?",
              style: TextStyle(
                  fontFamily: 'BraahOne',
                  fontSize: 24,
                  color: Color.fromARGB(255, 207, 177, 125))),
          Spacer(flex: 2,),
          emotionSelector,
          Spacer(flex: 7,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Theme(
              data: Theme.of(context).copyWith(
                  textSelectionTheme: const TextSelectionThemeData(
                      selectionColor: Colors.blueGrey)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('lib/assets/images/grid.jpg'),
                     fit: BoxFit.cover,
                     repeat: ImageRepeat.repeat
                     ),
                  ),
                  child: TextField(
                      controller: widget.controller,
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
                          fontSize: 20,
                          color: Colors.blueGrey, // Set the color of the labeled text
                        ),
                        //contentPadding: EdgeInsets.only(bottom: 100),
                      )),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 	207, 177, 125),
                minimumSize: Size(double.infinity, 50), // Set the minimum width and height
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25), // Set the border radius
                ),
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
                      widget.entry.date, widget.controller.text, selectedEmotion);
                  widget.onSave();
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('Save', style: TextStyle(color: Colors.white60, fontSize: 24, fontFamily: 'BraahOne')),
              ),
            ),
          ),
          Spacer(flex: 1,),
        ],
      ),
    ),
  );
}
}
