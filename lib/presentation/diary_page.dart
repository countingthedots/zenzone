import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zenzone/application/getter.dart';
import 'package:zenzone/bloc/bloc/diary_bloc.dart';
import 'package:zenzone/domain/models/diary_entry.dart';
import 'package:intl/intl.dart';
import 'package:zenzone/presentation/diary_page/emotion_selector.dart';
import 'package:zenzone/presentation/diary_page/new_entry_widget.dart';
import '../domain/diary_domain_controller.dart';
import 'diary_page/emotion_calendar.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({Key? key}) : super(key: key);
  
  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  String today = DateFormat('dd.MM.yyyy').format(DateTime.now());
  final TextEditingController _controller = TextEditingController();
  
  Future<List<DiaryEntry>>? futureDiary;

  @override
  void initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height - 80,
        child: Column(
          children: [
            const SizedBox(height: 20),
            BlocProvider(
              create: (context) => DiaryBloc(DiaryDomainController())..add(LoadDiary()),
              child: BlocBuilder<DiaryBloc, DiaryState>(
                builder: (context, state) {
                  if(state is DiaryLoading)
                  {
                    return CircularProgressIndicator();
                  }
                  else if(state is DiaryLoaded)
                  {
                    if(state.hasEntryToday){
                      return EmotionCalendar(
                        diary: state.entries,
                        onDaySelected: (date) {
                          BlocProvider.of<DiaryBloc>(context).add(EditEntry(date));
                        },
                      );
                    } else {
                      return NewEntryWidget(canGoBack: false, 
                                            entry: DiaryEntry(emotion: "", content: "", date: today), 
                                            onSave: (entry) {
                                              BlocProvider.of<DiaryBloc>(context).add(AddEntry(entry));
                                            },
                                            controller: _controller,);
                    }
                  } else if( state is EntryEditing)
                  {
                    return NewEntryWidget(canGoBack: true, 
                                          entry: state.entry, 
                                          onSave: (entry) {
                                            BlocProvider.of<DiaryBloc>(context).add(AddEntry(entry));
                                          },
                                          controller: _controller,);
                  } else {
                    return Text('Error: ${state}');
                  }
                },
              )
            ),
          ],
        ),
      ),
    );
  }

  
}
