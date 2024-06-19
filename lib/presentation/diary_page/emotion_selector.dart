import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../application/getter.dart';

class EmotionSelector extends StatefulWidget {
 final String defaultEmotion;
  EmotionSelector({Key? key, required this.defaultEmotion}) : super(key: key);

  @override
  _EmotionSelectorState createState() => _EmotionSelectorState();
}

class _EmotionSelectorState extends State<EmotionSelector> {
 late String selectedEmotion;

 @override
  void initState() {
   super.initState();
   selectedEmotion = getter.get<GetStorage>().read('selectedEmotion') ?? widget.defaultEmotion;
   }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      child: Row(
                            children: [
                              
                              const Spacer(),
                              GestureDetector(
                                child: Column(
                                  children: [
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      curve: Curves.easeInOut,
                                      width: selectedEmotion == 'sad'
                                          ? 115
                                          : 100, // Increase width when selected
                                      height: selectedEmotion == 'sad'
                                          ? 115
                                          : 100, // Increase height when selected
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: const DecorationImage(
                                          image: AssetImage(
                                              'lib/assets/images/sad_emotion.png'),
                                          fit: BoxFit.fill,
                                        ),
                                        border: selectedEmotion == 'sad'
                                            ? Border.all(
                                                color: Colors
                                                    .white54, // Outline color when selected
                                                width: 7,
                                                // Outline width when selected
                                              )
                                            : null, // No outline when not selected
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text('Sad'),
                                  ],
                                ),
                                onTap: () {
                                  getter.get<GetStorage>().write('selectedEmotion', 'sad');
                                  setState(() {
                                    selectedEmotion = selectedEmotion == 'sad'
                                        ? ''
                                        : 'sad'; // Set selectedEmotion when selected, null otherwise
                                  });
                                },
                              ),
                              const Spacer(),
                              GestureDetector(
                                child: Column(
                                  children: [
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      curve: Curves.easeInOut,
                                      width: selectedEmotion == 'ok'
                                          ? 115
                                          : 100, // Increase width when selected
                                      height: selectedEmotion == 'ok'
                                          ? 115
                                          : 100, // Increase height when selected
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: const DecorationImage(
                                          image: AssetImage(
                                              'lib/assets/images/ok_emotion.png'),
                                          fit: BoxFit.fill,
                                        ),
                                        border: selectedEmotion == 'ok'
                                            ? Border.all(
                                                color: Colors
                                                    .white54, // Outline color when selected
                                                width:
                                                    7, // Outline width when selected
                                              )
                                            : null, // No outline when not selected
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text('Neutral'),
                                  ],
                                ),
                                onTap: () {
                                  getter.get<GetStorage>().write('selectedEmotion', 'ok');

                                  setState(() {
                                    selectedEmotion = (selectedEmotion == 'ok'
                                        ? ''
                                        : 'ok'); // Set selectedEmotion when selected, null otherwise
                                  });
                                },
                              ),
                              const Spacer(),
                              GestureDetector(
                                child: Column(
                                  children: [
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      curve: Curves.easeInOut,
                                      width: selectedEmotion == 'happy'
                                          ? 115
                                          : 100, // Increase width when selected
                                      height: (selectedEmotion) == 'happy'
                                          ? 115
                                          : 100, // Increase height when selected
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: const DecorationImage(
                                          image: AssetImage(
                                              'lib/assets/images/delighted_emotion.png'),
                                          //fit: BoxFit.fill,
                                        ),
                                        border: selectedEmotion == 'happy'
                                            ? Border.all(
                                                color: Colors
                                                    .white54, // Outline color when selected
                                                width: 7,
                                                // Outline width when selected
                                              )
                                            : null, // No outline when not selected
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text('Happy'),
                                  ],
                                ),
                                onTap: () {
                                  getter.get<GetStorage>().write('selectedEmotion', 'happy');
                                  setState(() {
                                    selectedEmotion = selectedEmotion == 'happy'
                                        ? ''
                                        : 'happy';
                                  });
                                },
                              ),
                              const Spacer()
                            ],
                          ),
    );
  }
}