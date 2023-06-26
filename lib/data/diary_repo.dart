import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zenzone/application/locator.dart';

import '../domain/models/diary_entry.dart';

class DiaryRepo{

  static Future<List<DiaryEntry>> loadDiary() async {
    final diary = locator.get<GetStorage>().read('Diary');
    if (diary == null) {
      final user = FirebaseAuth.instance.currentUser!;
      final db = FirebaseFirestore.instance;
      final userDocRef = db.collection('diaries').doc(user.uid);
      final doc = await userDocRef.get();
      if (doc.exists) {
        return doc.data()?['diary'].map<DiaryEntry>((diaryEntry) => DiaryEntry.fromJson(diaryEntry)).toList();
      }
      else {
        return [];
      }
    }
    else if (diary.runtimeType == List<dynamic>) {
      return diary
          .map<DiaryEntry>((json) => DiaryEntry.fromJson(json))
          .toList();
    }
    else {
      return diary;
    }
  }

  static Future<void> saveDiary(List<DiaryEntry> diary) async {

    if (FirebaseAuth.instance.currentUser != null) {
      final List<Map> mapDiary = []; //= diary.map((e) => e.toJson()).toList();
      for (DiaryEntry diaryEntry in diary) {
        mapDiary.add(diaryEntry.toJson());
      }

      final user = FirebaseAuth.instance.currentUser!;
      final db = FirebaseFirestore.instance;
      final diaryToSave = <String, dynamic>{
        'diary': mapDiary,
      };
      db.collection('diaries').doc(user.uid).set(diaryToSave);
    }
    locator.get<GetStorage>().write('Diary', diary);
    return;
  }
}