part of 'diary_bloc.dart';

@immutable
abstract class DiaryEvent {}

class LoadDiary extends DiaryEvent {}

class AddEntry extends DiaryEvent {
  AddEntry(this.entry);
  final DiaryEntry entry;
}

class EditEntry extends DiaryEvent {
  EditEntry(this.date);
  final String date;
}
