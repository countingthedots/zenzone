class DiaryEntry {
  String emotion;
  final String content;
  final String date;

  DiaryEntry(
      {required this.emotion, required this.content, required this.date});

  factory DiaryEntry.fromJson(Map<String, dynamic> json){
    return DiaryEntry(
        emotion: json['emotion'],
        content: json['content'],
        date: json['date']
    );
  }

  Map<String, dynamic> toJson() => {
      'emotion': emotion,
      'content': content,
      'date': date,
    };
}