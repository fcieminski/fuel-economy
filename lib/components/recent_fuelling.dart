import 'package:flutter/material.dart';

class RecentFuelling extends StatefulWidget {
  final Map<String, String> _newFuelling;
  RecentFuelling(this._newFuelling);

  @override
  _RecentFuellingState createState() => _RecentFuellingState();
}

class _RecentFuellingState extends State<RecentFuelling> {
  final List<Map<dynamic, dynamic>> _fuelling = [
    {
      "id": DateTime.now(),
      "time": DateTime.now(),
      "distance": 358,
      "amount": 39,
      "average": 8.10,
      "totalCost": 257,
      'fuelCost': 5.10,
      'kmCost': 0.40
    },
  ];

  void checkFunction(fuelling) {
    if (fuelling != null) {
      int distance = int.parse(fuelling['distance']);
      double liters = double.parse(fuelling['amount']);
      double totalCost = double.parse(fuelling['totalCost']);
      setState(() {
        _fuelling.add({
          'id': DateTime.now(),
          'time': DateTime.now(),
          'distance': distance,
          'amount': liters,
          'average': num.parse((distance / liters).toStringAsFixed(2)),
          'totalCost': totalCost,
          'fuelCost': num.parse((totalCost / liters).toStringAsFixed(2)),
          'kmCost': num.parse((totalCost / distance).toStringAsFixed(2))
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    checkFunction(widget._newFuelling);
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: _fuelling.map((fuel) {
          return Card(
              child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Chip(
                  labelStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  label: Text('${fuel['average'].toString()}l'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  fuel['distance'].toString(),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  fuel['totalCost'].toString(),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  fuel['amount'].toString(),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  fuel['fuelCost'].toString(),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  fuel['kmCost'].toString(),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ));
        }).toList(),
      ),
    );
  }
}
