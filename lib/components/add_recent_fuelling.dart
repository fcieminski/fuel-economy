import 'package:flutter/material.dart';

class AddRecentFuelling extends StatefulWidget {
  @override
  _AddRecentFuellingState createState() => _AddRecentFuellingState();
}

class _AddRecentFuellingState extends State<AddRecentFuelling> {
  final distance = TextEditingController();
  final amount = TextEditingController();
  final totalCost = TextEditingController();
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
      body: Form(
        child: SingleChildScrollView(
                  child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(),
                controller: amount,
                decoration: const InputDecoration(
                  labelText: 'Ilość benzyny',
                ),
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
                onSaved: (String value) {
                  submitForm();
                },
              ),
              FlatButton(
                child: Text(
                  'Wybierz datę',
                ),
                onPressed: () {
                  _dataPicker(context);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: submitForm,
      ),
    );
  }
}
