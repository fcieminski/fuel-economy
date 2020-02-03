import 'package:flutter/material.dart';

class Replace extends StatefulWidget {
  @override
  _ReplaceState createState() => _ReplaceState();
}

class _ReplaceState extends State<Replace> {
  List<Map<String, dynamic>> replace = [];
  var partToReplace = TextEditingController();
  var kmToReplace = TextEditingController();

  void _submitReplace() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Najbliższe wymiany'),
      ),
      body: SingleChildScrollView(
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
