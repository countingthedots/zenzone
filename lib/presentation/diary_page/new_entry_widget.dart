import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:zenzone/domain/diary_domain_controller.dart';
import 'package:zenzone/presentation/diary_page/emotion_selector.dart';

import '../../application/getter.dart';
import '../../bloc/bloc/diary_bloc.dart';
import '../../domain/models/diary_entry.dart';

class NewEntryWidget extends StatefulWidget {
  NewEntryWidget({required this.entry, required this.controller, required this.onSave, required this.canGoBack, Key? key}) : super(key: key);
  final DiaryEntry entry; 
  final TextEditingController controller;
  final Function(DiaryEntry) onSave;
  final bool canGoBack;

  @override
  State<NewEntryWidget> createState() => _NewEntryWidgetState();
}

class _NewEntryWidgetState extends State<NewEntryWidget> {
 
  late EmotionSelector emotionSelector;
  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();
  final GlobalKey _three = GlobalKey();
  @override
  void initState() {
    super.initState();
    if(getter.get<GetStorage>().read('newentryTutorialShown') != 'true'){
      WidgetsBinding.instance.addPostFrameCallback((_) =>
        ShowCaseWidget.of(context).startShowCase([_one, _two, _three])
      );
      getter.get<GetStorage>().write('newentryTutorialShown', 'true');
    }
    emotionSelector = EmotionSelector(
      defaultEmotion: widget.entry.emotion,
    );
    widget.controller.text = widget.entry.content;
    
    
  }

  
  @override
Widget build(BuildContext context) {
  return Showcase(
      key: _one,
      description: 'This page will help you to track you mood',
      child: Container(
        height: MediaQuery.of(context).size.height - 100,
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom > 100 ? MediaQuery.of(context).viewInsets.bottom - 60 : 0),
          child: Column(
              children: [
                Spacer(flex: 2,),
                
               
                Row(
                  
                  children: [
                    widget.canGoBack ? Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 207, 177, 125),
                      ),
                      child: IconButton(
                        onPressed: () {
                          getter.get<GetStorage>().write('selectedEmotion', null);
                          BlocProvider.of<DiaryBloc>(context).add(LoadDiary());
                        },
                        icon: Icon(Icons.arrow_back_ios_new, color: Color.fromARGB(255, 248, 241, 229), size: 30,)
                      ),
                    ),
                  ),
                ) : Container(),
                const Spacer(),
                    const Text("Hello!\nHow are you feeling now?",
                        style: TextStyle(
                            fontFamily: 'BraahOne',
                            fontSize: 24,
                            color: Color.fromARGB(255, 207, 177, 125))),
                            const Spacer(),
                  ],
                  
                ),
                Spacer(flex: 2,),
                Showcase(
                  key: _two, 
                  description: 'First, choose your emotion',
                  child: emotionSelector),
                Spacer(flex: 7,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                        textSelectionTheme: const TextSelectionThemeData(
                            selectionColor: Colors.blueGrey)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Showcase(
                        key: _three,
                        description: 'Then, optionally add some note',
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
                      if (getter.get<GetStorage>().read('selectedEmotion') == null && widget.entry.emotion == "") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('First, choose the emotion'),
                          action: SnackBarAction(
                            label: 'Ok',
                            onPressed: () {},
                          ),
                        ));
                      } else {
                        String em = getter.get<GetStorage>().read('selectedEmotion') == null ? widget.entry.emotion : getter.get<GetStorage>().read('selectedEmotion')!;
                        FocusScope.of(context).unfocus();
                        getter.get<GetStorage>().write('selectedEmotion', null);
                        widget.onSave(DiaryEntry(date: widget.entry.date, content: widget.controller.text, emotion: em));
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
      ),
    );
}
}
