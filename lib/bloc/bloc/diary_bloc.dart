import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../domain/diary_domain_controller.dart';
import '../../domain/models/diary_entry.dart';

part 'diary_event.dart';
part 'diary_state.dart';

class DiaryBloc extends Bloc<DiaryEvent, DiaryState> {
  final DiaryDomainController diaryDomainController;
  String today = DateFormat('dd.MM.yyyy').format(DateTime.now());
  DiaryBloc(this.diaryDomainController) : super(DiaryLoading()) {
    on<LoadDiary>((event, emit) async {
      emit(DiaryLoading());
      var entries = await diaryDomainController.getDiary();
      var hasEntryToday = entries.any((entry) => entry.date == today);
      emit(DiaryLoaded(entries, hasEntryToday));
    });

    on<AddEntry>((event, emit) async {
      await diaryDomainController.saveDiaryEntry(event.entry);
      add(LoadDiary()); // Reload diary
    });

    on<EditEntry>((event, emit) async {
      var entry = await diaryDomainController.getDiaryEntryForDay(event.date);
      emit(EntryEditing(entry));
    });
  }
}
