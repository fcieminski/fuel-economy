import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Replace extends StatefulWidget {
  @override
  _ReplaceState createState() => _ReplaceState();
}

class _ReplaceState extends State<Replace> {
  List replace;
  var partToReplace = TextEditingController();
  var kmToReplace = TextEditingController();
  var price = TextEditingController();
  var note = TextEditingController();
  var startEditing = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future getUserData() async {
    final saveData = await SharedPreferences.getInstance();
    if (saveData.getString('replaceInfo') != null) {
      setState(() {
        replace = json.decode(saveData.getString('replaceInfo'));
      });
    } else {
      setState(() {
        replace = [];
      });
    }
  }

  Future saveToStorage(data) async {
    final saveData = await SharedPreferences.getInstance();
    saveData.setString('replaceInfo', data);
  }

  void _submitReplace() {
    var part = partToReplace.text;
    var km = num.parse(kmToReplace.text);
    var cost = num.parse(price.text);
    var moreInfo = note.text;
    if (part is String && km is num && cost is num) {
      setState(() {
        replace.add({
          'item': part,
          'when': km,
          'price': cost,
          'note': moreInfo,
          'isDone': false
        });
      });
    }
    saveToStorage(json.encode(replace));
  }

  void _partReplaced(element) {
    setState(() {
      element['isDone'] = true;
    });
    saveToStorage(json.encode(replace));
  }

  void _removeReplacementInfo(element) {
    setState(() {
      replace.remove(element);
    });
    saveToStorage(json.encode(replace));
  }

  void _saveNote(element) {
    setState(() {
      element['note'] = note.text;
      startEditing = false;
    });
    saveToStorage(json.encode(replace));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Najbliższe wymiany'),
      ),
      body: (replace != null && replace.isNotEmpty)
          ? new ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: replace
                  .map(
                    (element) => Card(
                      color: (element['isDone'])
                          ? Colors.green[100]
                          : Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: Icon(
                                        Icons.build,
                                        size: 18,
                                      ),
                                    ),
                                    Text(
                                      'Do wymiany',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.note),
                                      onPressed: () async => await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return StatefulBuilder(
                                                builder: (context, setState) {
                                              return SimpleDialog(children: <
                                                  Widget>[
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      IconButton(
                                                        icon: Icon(Icons.edit),
                                                        onPressed: () =>
                                                            setState(() {
                                                          startEditing = true;
                                                        }),
                                                      ),
                                                      IconButton(
                                                          icon: Icon(
                                                              Icons.delete),
                                                          onPressed: () => {
                                                                setState(() {
                                                                  note.clear();
                                                                  element['note'] =
                                                                      null;
                                                                })
                                                              }),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  child: startEditing
                                                      ? TextFormField(
                                                          controller: note,
                                                          decoration:
                                                              const InputDecoration(
                                                            labelText:
                                                                'Notatka',
                                                          ),
                                                        )
                                                      : Text(
                                                          element['note'] !=
                                                                      null &&
                                                                  element['note']
                                                                      .isNotEmpty
                                                              ? element['note']
                                                              : 'Brak notatki',
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                ),
                                              ]);
                                            });
                                          }).then((val) => _saveNote(element)),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () => showDialog(
                                          context: context,
                                          builder: (_) {
                                            return AlertDialog(
                                              title: Text(
                                                'Uwaga',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                              titlePadding: EdgeInsets.all(10),
                                              content: Text(
                                                'Na pewno chcesz usunąć element?',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: Text(
                                                    'Nie',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                                FlatButton(
                                                  onPressed: () => {
                                                    _removeReplacementInfo(
                                                        element),
                                                    Navigator.pop(context),
                                                  },
                                                  child: Text(
                                                    'Tak',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                    ),
                                    IconButton(
                                      icon: Icon((element['isDone'])
                                          ? Icons.check_box
                                          : Icons.check_box_outline_blank),
                                      onPressed: () => _partReplaced(element),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black12,
                            height: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    '${element['item']}',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: Icon(
                                          Icons.attach_money,
                                          size: 20,
                                        ),
                                      ),
                                      Text(
                                        '${element['price']} zł',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: Icon(
                                        Icons.directions_car,
                                        size: 20,
                                      ),
                                    ),
                                    Text(
                                      '${element['when']} km',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList())
          : Container(
              child: SizedBox(
                width: double.infinity,
                height: 200.0,
                child: const Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Dodaj listę rzeczy do wymiany',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (_) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        new TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Co jest do wymiany?',
                            border: InputBorder.none,
                            hintText: 'Co jest do wymiany?',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Wpisz dane';
                            }
                            return null;
                          },
                          maxLines: null,
                          controller: partToReplace,
                          keyboardType: TextInputType.text,
                        ),
                        new TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Ile km do wymiany?',
                            border: InputBorder.none,
                            hintText: 'Ile km do wymiany?',
                          ),
                          maxLines: null,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Wpisz dane';
                            } else if (int.tryParse(value) == null) {
                              return 'Wprowadź liczbę!';
                            }
                            return null;
                          },
                          controller: kmToReplace,
                          keyboardType: TextInputType.number,
                        ),
                        new TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Koszt wymiany',
                            border: InputBorder.none,
                            hintText: 'Koszt wymiany',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Wpisz dane';
                            } else if (double.tryParse(value) == null) {
                              return 'Wprowadź liczbę!';
                            }
                            return null;
                          },
                          maxLines: null,
                          controller: price,
                          keyboardType: TextInputType.number,
                        ),
                        new TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Notatka',
                            hintText: 'Notatka',
                          ),
                          maxLines: null,
                          controller: note,
                          keyboardType: TextInputType.multiline,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            child: Text(
                              'Zapisz',
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _submitReplace();
                                Navigator.pop(context);
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
