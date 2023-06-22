import 'dart:async';
import 'package:flutter/material.dart';

class BreathePage extends StatefulWidget {
  const BreathePage({Key? key}) : super(key: key);

  @override
  _BreathePageState createState() => _BreathePageState();
}

class _BreathePageState extends State<BreathePage>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  int timerDuration = 0; // Duration of the breathing exercise in seconds
  bool isBreathing = false; // Flag to track if the exercise is ongoing
  Timer? breathingTimer; // Timer for the breathing exercise

  List<int> durationOptions = [1, 3, 5, 7]; // Available duration options
  int? selectedDuration; // Selected duration

  bool isExhale = false; // Flag to track inhale/exhale state

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _animationController!.repeat(reverse: true);
    _animation = Tween(begin: 0.3, end: 1.4).animate(_animationController!)
      ..addListener(() {
        setState(() {});
      });

    selectedDuration = durationOptions[0]; // Set the initial selected duration
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
              const SizedBox(height: 80),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 100.0),
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
                            timerDuration.toString(),
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
                            child: DropdownButton<int>(
                              value: selectedDuration,
                              onChanged: (value) {
                                setState(() {
                                  selectedDuration = value;
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 125),
              GestureDetector(
                onTap: () {
                  if (!isBreathing) {
                    startBreathing();
                  } else {
                    stopBreathing();
                  }
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blueGrey[300],
                    boxShadow: isBreathing
                        ? [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 30 * scale,
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
                          timerDuration > 0
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
            ],
          ),
        );
  }

  void startBreathing() {
    setState(() {
      isBreathing = true;
      timerDuration = selectedDuration! * 60; // Convert duration to seconds
      isExhale = timerDuration > 0
          ? false
          : true; // Set initial state to inhale if timer duration is greater than zero
    });

    // Start the breathing exercise
    int exhaleInterval = 5; // Exhale interval in seconds
    int inhaleInterval = 5; // Inhale interval in seconds

    int currentInterval = isExhale ? exhaleInterval : inhaleInterval;

    breathingTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerDuration <= 0) {
        stopBreathing();
        return;
      }

      setState(() {
        timerDuration--;

        // Toggle inhale/exhale state based on current interval
        if (timerDuration % currentInterval == 0) {
          isExhale = !isExhale;
          currentInterval = isExhale ? exhaleInterval : inhaleInterval;
        }
      });
    });
  }

  void stopBreathing() {
    setState(() {
      isBreathing = false;
      timerDuration = 0;
    });

    // Cancel the breathing exercise timer
    breathingTimer?.cancel();
  }
}
