import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqllite/datamodel.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final Stringtype = 'TEXT';

    await db.execute(''' 
    CREATE TABLE $tableNotes (
      ${NoteFields.note} $Stringtype,
      ${NoteFields.date} $Stringtype 

    );
      ''');
  }

Future<notes> create(notes note) async {
    final db = await instance.database;

    //to personalize it
    // final json = note.toJson();

    // final column = '${NoteFields.date},${NoteFields.note}  ';

    // final value = '${json[NoteFields.note]},${json[NoteFields.date]} ';

    // final id =
    //     await db.rawInsert('INSERT INTO TABLE NAME  ($column)  VALUE($value)');

    final id = await db.insert(tableNotes, note.toJson());
    return note.notecopy(id: id);
  }

  Future<notes?> readnote(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableNotes,
      columns: NoteFields.values,
    );
    if (maps.isNotEmpty) {
      return notes.fromJson(maps.first);
    }
    return null;
  }

  Future<List<notes>> readallnotes() async {
    final db = await instance.database;
    final result = await db.query(tableNotes);

    return result.map((json) => notes.fromJson(json)).toList();
  }

  Future<int> update(notes note) async {
    final db = await instance.database;

    return db.update(tableNotes, note.toJson());
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
