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

  Future<List<DiaryEntry>> getDiary() async {
    diary ??= await DiaryRepo.loadDiary();
    return diary!;
  }

  Future<void> saveDiaryEntry(String date, String content, String emotion) async {
    final oldDiary = await DiaryRepo.loadDiary();
    oldDiary.removeWhere((entry) => entry.date == date);
    final diaryEntryToSave = DiaryEntry(
        emotion: emotion, content: content, date: date);
    oldDiary.add(diaryEntryToSave);
    diary = oldDiary;
    await DiaryRepo.saveDiary(oldDiary);
  }
}
