import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:zenzone/application/getter.dart';
import 'package:zenzone/domain/diary_domain_controller.dart';
import 'package:zenzone/domain/models/diary_entry.dart';

class EmotionCalendar extends StatefulWidget {
  EmotionCalendar({required this.diary, required this.onDaySelected, super.key});
  final List<DiaryEntry> diary;
  final Function(String) onDaySelected;
  
  @override
  State<EmotionCalendar> createState() => _EmotionCalendarState();
}

class _EmotionCalendarState extends State<EmotionCalendar> {
  PageController _pageController =
      PageController(initialPage: DateTime.now().month - 1);
  DateTime _currentMonth = DateTime.now();
  bool selectedcurrentyear = false;
  late List<DiaryEntry> diary;
  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();
  final emotionToAsset = <String, String>{
    "happy": 'lib/assets/images/delighted_emotion.png',
    "sad": 'lib/assets/images/sad_emotion.png',
    "ok": 'lib/assets/images/ok_emotion.png',
    "none": "lib/assets/images/no_emotion.png",
  };
  @override
  void initState() {
    if(getter.get<GetStorage>().read('calendarTutorialShown') != 'true'){
    WidgetsBinding.instance.addPostFrameCallback((_) =>
      ShowCaseWidget.of(context).startShowCase([_one, _two])
    );
    getter.get<GetStorage>().write('calendarTutorialShown', 'true');
  }
    diary = widget.diary;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      child: Column(
        children: [
          Spacer(flex: 2,),
          const Text('Emotion Calendar', style: TextStyle(fontSize: 36, fontFamily: 'BraahOne', color: Color.fromARGB(255, 	126, 109, 76))),
          Spacer(),
          _buildWeeks(),
          Showcase(
            key: _one,
            description: 'With this calendar you can see your mood for each day',
            child: GestureDetector(
              onPanEnd: (DragEndDetails details) {
                if (details.velocity.pixelsPerSecond.dx > 0) {
                  _pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
                if(details.velocity.pixelsPerSecond.dx < 0){
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.55,
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
            ),
          ),
          _buildHeader(),
        ],
      ),
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
            style: TextStyle(fontSize: 22, fontFamily: 'BraahOne'),
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
        childAspectRatio: 0.7,
      ),
      // Calculating the total number of cells required in the grid
      itemCount: daysInMonth + weekdayOfFirstDay - 1,
      itemBuilder: (context, index) {
        if (index < weekdayOfFirstDay - 1) {
          // Displaying dates from the previous month in grey
          int previousMonthDay =
              daysInPreviousMonth - (weekdayOfFirstDay - index) + 2;
          return Container(
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
          print(emotionToAsset[entry.emotion]!);
          if(date.day == 1)
          return Showcase(
            key: _two,
            description: 'Tap on a day to edit the entry',
            child: InkWell(
              onTap: () {
                    widget.onDaySelected(DateFormat('dd.MM.yyyy').format(date));
              },
              child: Container(
                height: 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        width: 40,
                        height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          emotionToAsset[entry.emotion]!
                                      )
                                      //fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                    Center(
                        child: Text(
                          day,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
          else
          return InkWell(
            onTap: () {
                  widget.onDaySelected(DateFormat('dd.MM.yyyy').format(date));
            },
            child: Container(
              height: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: 40,
                      height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                        emotionToAsset[entry.emotion]!
                                    )
                                    //fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                  Center(
                      child: Text(
                        day,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
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
}
