import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:zenzone/application/getter.dart';
import 'package:zenzone/domain/diary_domain_controller.dart';
import 'package:zenzone/domain/models/diary_entry.dart';

class EmotionCalendar extends StatefulWidget {
  EmotionCalendar({required this.diary, super.key});
  List<DiaryEntry> diary;
  @override
  State<EmotionCalendar> createState() => _EmotionCalendarState();
}

class _EmotionCalendarState extends State<EmotionCalendar> {
  PageController _pageController =
      PageController(initialPage: DateTime.now().month - 1);
  DateTime _currentMonth = DateTime.now();
  bool selectedcurrentyear = false;
  late List<DiaryEntry> diary;
  final emotionToAsset = <String, String>{
    "happy": "lib/assets/images/delighted_emotion.png",
    "sad": "lib/assets/images/sad_emotion.png",
    "ok": "lib/assets/images/ok_emotion.png",
    "none": "lib/assets/images/no_emotion.png",
  };
  @override
  void initState() {
    diary = widget.diary;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        _buildWeeks(),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentMonth = DateTime(_currentMonth.year, index + 1, 1);
              });
            },
            itemCount: 12 * 10, // Show 10 years, adjust this count as needed
            itemBuilder: (context, pageIndex) {
              DateTime month =
                  DateTime(_currentMonth.year, (pageIndex % 12) + 1, 1);
              return buildCalendar(month);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    // Checks if the current month is the last month of the year (December)
    bool isLastMonthOfYear = _currentMonth.month == 12;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Moves to the previous page if the current page index is greater than 0
              if (_pageController.page! > 0) {
                _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
          // Displays the name of the current month
          Text(
            '${DateFormat('MMMM').format(_currentMonth)}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          DropdownButton<int>(
            // Dropdown for selecting a year
            value: _currentMonth.year,
            onChanged: (int? year) {
              if (year != null) {
                setState(() {
                  // Sets the current month to January of the selected year
                  _currentMonth = DateTime(year, 1, 1);

                  // Calculates the month index based on the selected year and sets the page
                  int yearDiff = DateTime.now().year - year;
                  int monthIndex = 12 * yearDiff + _currentMonth.month - 1;
                  _pageController.jumpToPage(monthIndex);
                });
              }
            },
            items: [
              // Generates DropdownMenuItems for a range of years from current year to 10 years ahead
              for (int year = DateTime.now().year;
                  year <= DateTime.now().year + 10;
                  year++)
                DropdownMenuItem<int>(
                  value: year,
                  child: Text(year.toString()),
                ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              // Moves to the next page if it's not the last month of the year
              if (!isLastMonthOfYear) {
                setState(() {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWeeks() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildWeekDay('Mon'),
          _buildWeekDay('Tue'),
          _buildWeekDay('Wed'),
          _buildWeekDay('Thu'),
          _buildWeekDay('Fri'),
          _buildWeekDay('Sat'),
          _buildWeekDay('Sun'),
        ],
      ),
    );
  }

  Widget _buildWeekDay(String day) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Text(
        day,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildCalendar(DateTime month) {
    // Calculating various details for the month's display
    int daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    DateTime firstDayOfMonth = DateTime(month.year, month.month, 1);
    int weekdayOfFirstDay = firstDayOfMonth.weekday;

    DateTime lastDayOfPreviousMonth =
        firstDayOfMonth.subtract(Duration(days: 1));
    int daysInPreviousMonth = lastDayOfPreviousMonth.day;

    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 0.4,
      ),
      // Calculating the total number of cells required in the grid
      itemCount: daysInMonth + weekdayOfFirstDay - 1,
      itemBuilder: (context, index) {
        if (index < weekdayOfFirstDay - 1) {
          // Displaying dates from the previous month in grey
          int previousMonthDay =
              daysInPreviousMonth - (weekdayOfFirstDay - index) + 2;
          return Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide.none,
                left: BorderSide(width: 1.0, color: Colors.grey),
                right: BorderSide(width: 1.0, color: Colors.grey),
                bottom: BorderSide(width: 1.0, color: Colors.grey),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              previousMonthDay.toString(),
              style: TextStyle(color: Colors.grey),
            ),
          );
        } else {
          // Displaying the current month's days
          DateTime date =
              DateTime(month.year, month.month, index - weekdayOfFirstDay + 2);
          DiaryEntry entry = diary.firstWhere(
            (entry) => entry.date == DateFormat('dd.MM.yyyy').format(date),
            orElse: () => DiaryEntry(
              date: DateFormat('dd.MM.yyyy').format(date),
              emotion: 'none',
              content: '',
            ),
          );
          String day = date.day.toString();

          return InkWell(
            onTap: () {
              context.go("/new-entry");
            },
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 0,
                    child: SizedBox(
                      child: Image.asset(
                        emotionToAsset[entry.emotion] ??
                            "lib/assets/images/no_emotion.png",
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        day,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
  // Write a Widget code from here
  // Widget _buildHeader() {--}
  //  Widget _buildWeeks() {--}
  //  Widget _buildCalendar() {--}
}
