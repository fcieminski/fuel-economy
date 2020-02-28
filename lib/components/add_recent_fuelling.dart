import 'package:flutter/material.dart';
import 'package:fuel_economy/utils/date_formatter.dart';

class AddRecentFuelling extends StatefulWidget {
  @override
  _AddRecentFuellingState createState() => _AddRecentFuellingState();
}

class _AddRecentFuellingState extends State<AddRecentFuelling> {
  final distance = TextEditingController();
  final amount = TextEditingController();
  final totalCost = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String dateError;
  DateTime time;

  void submitForm() {
    Map<String, dynamic> data = {
      'distance': distance.text,
      'amount': amount.text,
      'totalCost': totalCost.text,
      'time': time,
    };
    Navigator.pop(context, data);
  }

  Future<DateTime> _dataPicker(BuildContext context) async {
    time = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    );
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: new Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: amount,
                  decoration: const InputDecoration(
                    labelText: 'Ilość benzyny',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Wpisz dane';
                    } else if (int.tryParse(value) == null) {
                      return 'Pole akceptuje tylko liczby!';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    submitForm();
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: totalCost,
                  decoration: const InputDecoration(
                    labelText: 'Koszt benzyny',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Wpisz dane';
                    } else if (double.tryParse(value) == null) {
                      return 'Pole akceptuje tylko liczby!';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    submitForm();
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: distance,
                  decoration: const InputDecoration(
                    labelText: 'Przejechany dystans',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Wpisz dane';
                    } else if (double.tryParse(value) == null) {
                      return 'Pole akceptuje tylko liczby!';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    submitForm();
                  },
                ),
                FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.date_range),
                      Padding(padding: EdgeInsets.only(right: 8)),
                      Text(time is DateTime
                          ? DateFormatter.date(time.toString())
                          : "Dodaj datę"),
                    ],
                  ),
                  onPressed: () {
                    _dataPicker(context);
                  },
                ),
                if (dateError != null)
                  Text(
                    dateError,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    child: Text(
                      'Zapisz',
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate() && time != null) {
                        submitForm();
                      } else if (time is DateTime) {
                        setState(() {
                          dateError = null;
                        });
                      } else {
                        setState(() {
                          dateError = 'Wprowadź datę!';
                        });
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
  }
}
