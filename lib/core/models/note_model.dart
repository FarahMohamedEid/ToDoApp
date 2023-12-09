class NoteModel {
  NoteModel({
    this.id,
    this.title,
    this.date,
    this.time,
    this.content,
    this.done,
  });

  String? id;
  String? title;
  String? date;
  String? time;
  String? content;
  bool? done;

  NoteModel.fromJson(dynamic json) {
    id = json['id'] ?? '';
    title = json['title'] ?? '';
    date = json['date'] ?? '';
    time = json['time'] ?? '';
    content = json['content'] ?? '';
    done = json['done'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['date'] = date;
    map['time'] = time;
    map['content'] = content;
    map['done'] = done;
    return map;
  }

  NoteModel copyWith({
    String? id,
    String? title,
    String? date,
    String? time,
    String? content,
    bool? done,
  }) =>
      NoteModel(
        id: id ?? this.id,
        title: title ?? this.title,
        date: date ?? this.date,
        time: time ?? this.time,
        content: content ?? this.content,
        done: done ?? this.done,
      );
}
