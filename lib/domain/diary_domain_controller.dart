import 'package:zenzone/data/diary_repo.dart';
import 'models/diary_entry.dart';

class DiaryDomainController {
  List<DiaryEntry>? diary;

  Future<DiaryEntry> getDiaryEntryForDay(String date) async {
    diary ??= await DiaryRepo.loadDiary();
    final diaryEntry = diary!.firstWhere((entry) => entry.date == date,
        orElse: () => DiaryEntry(emotion: '', content: '', date: date));
    return diaryEntry;
  }

  Future<void> saveDiaryEntry(String date, String content, String emotion) async {
    final diary = await DiaryRepo.loadDiary();
    diary.removeWhere((entry) => entry.date == date);
    final diaryEntryToSave = DiaryEntry(
        emotion: emotion, content: content, date: date);
    diary.add(diaryEntryToSave);
    await DiaryRepo.saveDiary(diary);
  }
}
