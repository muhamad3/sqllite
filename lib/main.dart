import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqllite/datamodel.dart';
import 'package:sqllite/notes.dart';
import 'notes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<notes> note;
  bool isloading = false;
  TextEditingController anote = TextEditingController();
  String? note1;

  void initState() {
    super.initState();
    Database;
    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() {
      isloading = true;
    });
    this.note = await NotesDatabase.instance.readallnotes();

    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sqflite'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: anote,
            ),
            ElevatedButton(
              child: Text('create'),
              onPressed: () {
                note1 = anote.value.text;
                addNote();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future addNote() async {
    final note = notes(
      note: 'yyyy',
      date: DateTime.now(),
    );

    await NotesDatabase.instance.create(note);
  }
}
