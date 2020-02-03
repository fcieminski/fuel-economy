import 'package:flutter/material.dart';

class Replace extends StatefulWidget {
  @override
  _ReplaceState createState() => _ReplaceState();
}

class _ReplaceState extends State<Replace> {
  List<Map<String, dynamic>> replace = [
    {
      'item': 'Olej silnikowy',
      'when': 10000,
      'price': 200,
      'note': 'blablablablabla',
      'isDone': true,
    },
    {
      'item': 'Drążki kierownicze',
      'when': 3000,
      'price': 100,
      'note': 'blablablxxxxxxx',
      'isDone': false,
    }
  ];

  var partToReplace = TextEditingController();
  var kmToReplace = TextEditingController();
  var price = TextEditingController();
  var note = TextEditingController();

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
  }

  void _partReplaced(element) {
    setState(() {
      element['isDone'] = true;
    });
  }

  void _removeReplacementInfo(element) {
    setState(() {
      replace.remove(element);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Najbliższe wymiany'),
      ),
      body: (replace.isNotEmpty)
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
                                      onPressed: () => showDialog(
                                          context: context,
                                          builder: (_) {
                                            return SimpleDialog(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16),
                                                    child: Text(
                                                      '${element['note']}',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ]);
                                          }),
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
                                                    onPressed: () => {
                                                          _removeReplacementInfo(
                                                              element),
                                                          Navigator.pop(
                                                              context),
                                                        },
                                                    child: Text(
                                                      'Tak',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      ),
                                                    )),
                                                FlatButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: Text(
                                                      'Nie',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      ),
                                                    ))
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
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        new TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Co jest do wymiany?',
                          ),
                          maxLines: null,
                          controller: partToReplace,
                          keyboardType: TextInputType.text,
                        ),
                        new TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Ile km do wymiany?',
                          ),
                          maxLines: null,
                          controller: kmToReplace,
                          keyboardType: TextInputType.number,
                        ),
                        new TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Koszt wymiany',
                          ),
                          maxLines: null,
                          controller: price,
                          keyboardType: TextInputType.number,
                        ),
                        new TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Notatka',
                          ),
                          maxLines: null,
                          controller: note,
                          keyboardType: TextInputType.multiline,
                        ),
                        FlatButton(
                          child: Text(
                            'Zapisz',
                          ),
                          onPressed: () {
                            _submitReplace();
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
        ),
      ),
    );
  }
}
