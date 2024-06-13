import 'dart:math';

import 'package:get_storage/get_storage.dart';
import 'package:zenzone/application/getter.dart';

class QuotesController {
  static late String todaysQuote;
  static final List<String> quotes = [
    'Worry often gives a small thing a big shadow.',
    'Do not anticipate trouble or worry about what may never happen.',
    'Self-observation is the first step of inner unfolding.',
    'You don’t have to control your thoughts. ',
    'Feelings come and go like clouds in a windy sky. ',
    'You don’t have to control your thoughts.',
    'Whatever is going to happen will happen, whether we worry or not.',
    'Almost everything will work again if you unplug it.'
  ];

  QuotesController() {

    String? _lastTimeUpdatedString = getter.get<GetStorage>().read('lastTimeUpdated');
    DateTime? _lastTimeUpdated;
    
    if (_lastTimeUpdatedString != null) {
      _lastTimeUpdated = DateTime.parse(_lastTimeUpdatedString);
    }

    if (_lastTimeUpdated == null || DateTime.now().day != _lastTimeUpdated.day) {
      todaysQuote = getRandomQuote();
      getter.get<GetStorage>().write('lastTimeUpdated', DateTime.now().toIso8601String());
      getter.get<GetStorage>().write('todaysQuote', todaysQuote);
    }
    else{
      todaysQuote = getter.get<GetStorage>().read('todaysQuote');
    }
  }
  



  static String getRandomQuote() {
    return quotes[Random().nextInt(quotes.length)];
  }
}