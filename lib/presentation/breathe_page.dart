import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:showcaseview/showcaseview.dart';

import '../application/getter.dart';

class BreathePage extends StatefulWidget {
  const BreathePage({Key? key}) : super(key: key);

  @override
  _BreathePageState createState() => _BreathePageState();
}

class _BreathePageState extends State<BreathePage>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  bool isBreathing = false; // Flag to track if the exercise is ongoing
  Timer? breathingTimer; // Timer for the breathing exercise

  List<int> durationOptions = [1, 3, 5, 7]; // Available duration options
  Duration? selectedDuration; // Selected duration
  Duration timeRemaining = Duration(seconds: 0); // Time remaining for the exercise;

  bool isExhale = false; // Flag to track inhale/exhale state
  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();
  @override
void initState() {
  super.initState();
  if(getter.get<GetStorage>().read('breathpageTutorialShown') != 'true'){
    WidgetsBinding.instance.addPostFrameCallback((_) =>
      ShowCaseWidget.of(context).startShowCase([_one, _two])
    );
    getter.get<GetStorage>().write('breathpageTutorialShown', 'true');
  }
  _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
  );

  // Initialize the _animation with a Tween
  _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController!)
    ..addListener(() {
      setState(() {}); // This will trigger a rebuild whenever the animation value changes
    })
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController!.reverse();
        setState(() => isExhale = true);
      } else if (status == AnimationStatus.dismissed) {
        _animationController!.forward();
        setState(() => isExhale = false);
      }
    });

  selectedDuration = Duration(minutes: durationOptions[0]); // Set the initial selected duration
  
}

  @override
  void dispose() {
    _animationController?.dispose();
    breathingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double scale = 1.0 + (_animation!.value * 3);

    return Center(
          child: Column(
            children: <Widget>[
              const Spacer(flex: 2,),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 70),
                      child: Container(
                        height: 50,
                        width: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          //color: Colors.blueGrey[300],
                          border: Border.all(
                            color: Colors.black45,
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            timeRemaining!.inSeconds.toString(),
                            style: const TextStyle(
                              color: Colors.black45,
                              fontSize: 36,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 30.0),
                            child: Text(
                              'Set Duration',
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(right: 30.0),
                            child: Showcase(
                              key: _one,
                              description: 'Choose how long you are going to breath',
                              child: DropdownButton<int>(
                                value: selectedDuration!.inMinutes,
                                onChanged: (value) {
                                  setState(() {
                                    selectedDuration = Duration(minutes: value!);
                                  });
                                },
                                items: durationOptions.map((duration) {
                                  return DropdownMenuItem<int>(
                                    value: duration,
                                    child: Text(
                                      '$duration minute${duration > 1 ? 's' : ''}',
                                      style: TextStyle(color: Colors.black45),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 4,),
              GestureDetector(
                onTap: () {
                  if (!isBreathing) {
                    startBreathing();
                  } else {
                    stopBreathing();
                  }
                },
                child: Showcase(
                  key: _two,
                  description: 'Press the button to start breathing exercise',
                  targetShapeBorder: const CircleBorder(),
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(151, 209, 215, 1),
                      boxShadow: isBreathing
                          ? [
                        BoxShadow(
                          color: Color.fromRGBO(151, 209, 215, 1),
                          blurRadius: 30,
                          spreadRadius: 15 * scale,
                        ),
                      ]
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text(
                            timeRemaining!.inSeconds > 0
                                ? isExhale
                                ? 'Exhale'
                                : 'Inhale'
                                : 'Start',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontFamily: 'BraahOne',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 4,),
            ],
          ),
        );
  }

  void startBreathing() {
    setState(() {
      isBreathing = true;
      timeRemaining = selectedDuration!; // Convert duration to seconds
    });
    _animationController!.forward();
    startTimer();
  }

  void stopBreathing() {
    setState(() {
      _animationController!.reset();
      _animationController!.stop();
      isBreathing = false;
    });
    // Cancel the breathing exercise timer
    timeRemaining = Duration(seconds: 0);
    breathingTimer?.cancel();
  }

  void startTimer() {
    timeRemaining = selectedDuration!;
    breathingTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeRemaining!.inSeconds <= 0) {
        // Countdown is finished
        breathingTimer?.cancel();
        stopBreathing();
      } else {
        // Update the countdown value and decrement by 1 second
        setState(() {
          timeRemaining = timeRemaining - Duration(seconds: 1);
        });
      }
    });
  }
}
