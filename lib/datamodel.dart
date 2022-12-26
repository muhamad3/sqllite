final String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [note, date,id];

  static final String note = 'note';
  static final String id = '_id';
  static final String date = 'date';
}

class notes {
  num? id;
  String? note;
  DateTime? date;
  notes({this.date, this.note,this.id});

  static notes fromJson(Map<String, Object?> json) => notes(
      note: json[NoteFields.note] as String,
      id: json[NoteFields.id] as num,
      date: DateTime.parse(json[NoteFields.date] as String));

  Map<String, Object?> toJson() =>
      {NoteFields.note: notes, NoteFields.date: date?.toIso8601String(),NoteFields.id:id};

  notecopy({
    String? note,
    DateTime? date,
    num? id
  }) =>
      notes(note: note ?? this.note, 
      id: id ?? this.id,
      date: date ?? this.date);
}
