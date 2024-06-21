part of 'diary_bloc.dart';

@immutable
abstract class DiaryState {}

class DiaryLoading extends DiaryState {}

class DiaryLoaded extends DiaryState {
  DiaryLoaded(this.entries, this.hasEntryToday);
  final List<DiaryEntry> entries;
  final bool hasEntryToday;
}

class EntryEditing extends DiaryState {
  EntryEditing(this.entry);
  final DiaryEntry entry; // Null if adding a new entry
}