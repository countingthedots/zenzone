

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../application/getter.dart';

class NewEntryWidget extends StatelessWidget {
  const NewEntryWidget({super.key});

  @override
  Widget build(BuildContext context) {
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