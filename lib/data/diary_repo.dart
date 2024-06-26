import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zenzone/application/getter.dart';

import '../domain/models/diary_entry.dart';

class DiaryRepo{

  static Future<List<DiaryEntry>> loadDiary() async {
    final diary = getter.get<GetStorage>().read('Diary');
    if (diary == null && getter.get<GetStorage>().read('skippedAuth') != true) {
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
    else{
      if (diary is List) {
      return diary.map<DiaryEntry>((diaryEntry) {
        if (diaryEntry is Map<String, dynamic>) {
          return DiaryEntry.fromJson(diaryEntry);
        } else if (diaryEntry is DiaryEntry) {
          return diaryEntry;
        } else {
          throw Exception('Unexpected diary entry type');
        }
      }).toList();
    } else {
      return [];
    }
    }
  }

  static Future<void> saveDiary(List<DiaryEntry> diary) async {
    getter.get<GetStorage>().write('Diary', diary);
    if (FirebaseAuth.instance.currentUser != null) {
      final List<Map> mapDiary = [];
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
    
    return;
  }
}