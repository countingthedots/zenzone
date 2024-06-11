import 'package:flutter/material.dart';

class EmotionSelector extends StatefulWidget {
 final Function(String) onEmotionSelected;
  EmotionSelector({Key? key, required this.onEmotionSelected}) : super(key: key);

  @override
  _EmotionSelectorState createState() => _EmotionSelectorState();
}

class _EmotionSelectorState extends State<EmotionSelector> {
 String selectedEmotion = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115,
      child: Row(
                            children: [
                              const SizedBox(width: 25),
                              GestureDetector(
                                child: AnimatedContainer(
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
                                onTap: () {
                                  setState(() {
                                    selectedEmotion = selectedEmotion == 'happy'
                                        ? ''
                                        : 'happy';
                                  });
                                  widget.onEmotionSelected(selectedEmotion);
                                },
                              ),
                              const SizedBox(width: 20),
                              GestureDetector(
                                child: AnimatedContainer(
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
                                onTap: () {
                                  setState(() {
                                    selectedEmotion = selectedEmotion == 'sad'
                                        ? ''
                                        : 'sad'; // Set selectedEmotion when selected, null otherwise
    
                                    
    
                                  });
                                  widget.onEmotionSelected(selectedEmotion);
                                },
                              ),
                              const SizedBox(width: 20),
                              GestureDetector(
                                child: AnimatedContainer(
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
                                onTap: () {
                                  setState(() {
                                    selectedEmotion = (selectedEmotion == 'ok'
                                        ? ''
                                        : 'ok'); // Set selectedEmotion when selected, null otherwise
    
                                    
    
                                  });
                                  widget.onEmotionSelected(selectedEmotion);
                                },
                              ),
                            ],
                          ),
    );
  }
}