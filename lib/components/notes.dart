import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final note = TextEditingController();
  final editedNote = TextEditingController();
  List notes;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future getUserData() async {
    final saveData = await SharedPreferences.getInstance();
    if (saveData.getString('notes') != null) {
      final jsonData = json.decode(saveData.getString('notes'));
      setState(() {
        notes = jsonData;
      });
    } else {
      setState(() {
        notes = [];
      });
    }
  }

  Future saveNotes(note) async {
    final saveData = await SharedPreferences.getInstance();
    saveData.setString('notes', json.encode(note));
  }

  void _submitNote() => {
        setState(() {
          notes.add({
            'text': note.text,
            'date': DateTime.now().toString(),
          });
        }),
        note.clear(),
        saveNotes(notes),
      };

  void _deleteNote(Map note) => {
        setState(() {
          notes.remove(note);
        }),
        saveNotes(notes),
      };

  void _editNote(int index, String text) => {
        setState(() {
          notes[index].update('text', (dynamic val) => val = text);
        }),
        saveNotes(notes),
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Notatki'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (notes != null && notes.isNotEmpty)
                ...notes.map(
                  (element) => Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('${element['date']}'),
                              Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                    ),
                                    onPressed: () => showDialog(
                                        context: context,
                                        builder: (_) {
                                          editedNote.text = element['text'];
                                          return SimpleDialog(children: <
                                              Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Column(
                                                children: <Widget>[
                                                  new TextField(
                                                    maxLines: null,
                                                    controller: editedNote,
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                  ),
                                                  FlatButton(
                                                    child: Text(
                                                      'Zapisz',
                                                    ),
                                                    onPressed: () {
                                                      _editNote(
                                                          notes
                                                              .indexOf(element),
                                                          editedNote.text);
                                                      Navigator.pop(context);
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                          ]);
                                        }),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                    ),
                                    onPressed: () => _deleteNote(element),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8.0, left: 8.0, right: 8.0),
                          child: Text(
                            element['text'],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (notes == null || notes.isEmpty)
                Container(
                  child: SizedBox(
                    width: double.infinity,
                    height: 200.0,
                    child: const Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Dodaj notatki',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => {
          showModalBottomSheet(
            context: context,
            builder: (_) {
              return Container(
                child: Scaffold(
                  body: SingleChildScrollView(
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          new TextField(
                            maxLines: null,
                            controller: note,
                            keyboardType: TextInputType.multiline,
                          ),
                          FlatButton(
                            child: Text(
                              'Zapisz',
                            ),
                            onPressed: () {
                              _submitNote();
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        },
      ),
    );
  }
}
