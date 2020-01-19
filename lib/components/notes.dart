import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final note = TextEditingController();
  List<String> notes = [];

  void _submitNote() => {
        setState(() {
          notes.add(note.text);
        }),
        note.clear()
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
              if (notes != null)
                ...notes.map(
                  (element) => Card(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      element,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  )),
                )
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
              })
        },
      ),
    );
  }
}
