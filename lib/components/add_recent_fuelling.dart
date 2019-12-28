import 'package:flutter/material.dart';

class AddRecentFuelling extends StatefulWidget {
  // final Function _addRecentFuelling;

  // AddRecentFuelling(this._addRecentFuelling);

  @override
  _AddRecentFuellingState createState() => _AddRecentFuellingState();
}

class _AddRecentFuellingState extends State<AddRecentFuelling> {
  final distance = TextEditingController();
  final amount = TextEditingController();
  final totalCost = TextEditingController();

  void submitForm() {
    print(distance.text);
    print(amount.text);
    print(totalCost.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
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
          ],
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
