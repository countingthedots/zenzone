import 'dart:math';

import 'package:zenzone/data/quotes_repo.dart';

class QuotesController {
  static String getRandomQuote() {
    return QuotesRepo().quotes[Random().nextInt(QuotesRepo().quotes.length - 1)];
  }
}