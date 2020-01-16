import 'package:flutter/material.dart';

class RecentFuelling extends StatefulWidget {
  final Map<String, dynamic> _newFuelling;
  RecentFuelling(this._newFuelling);

  @override
  _RecentFuellingState createState() => _RecentFuellingState();
}

class _RecentFuellingState extends State<RecentFuelling> {
  final List<Map<String, dynamic>> _fuelling = [
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
          'time': fuelling['time'],
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
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: _fuelling.map((fuel) {
          return Card(
              child:  SingleChildScrollView(
                              child: Column(
            children: <Widget>[
                Container(
                  child: Text('${fuel['time']}'),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Chip(
                        labelStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        label: Text('cena'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'cena',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'cena',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'cena',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'cena',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'cena',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Chip(
                        labelStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        label: Text('${fuel['average']} l'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        '${fuel['distance']} km',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        '${fuel['totalCost']} zł',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        '${fuel['amount']} l',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        '${fuel['fuelCost']} zł/l',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        '${fuel['kmCost']} zł/km',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
              ));
        }).toList(),
      ),
    );
  }
}
