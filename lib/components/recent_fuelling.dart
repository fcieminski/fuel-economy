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
              child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Chip(
                        labelStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        label: Text('średnie spalanie: ${fuel['average']} l'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        child:
                            Text('${fuel['time'].toString().substring(0, 10)}'),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      defaultColumnWidth: FlexColumnWidth(.25),
                      children: [
                        TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              'dystans',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              'koszt',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              'litry',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              'zł/l',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              'zł/km',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ]),
                        TableRow(children: [
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
                        ]),
                      ]),
                ),
              ],
            ),
          ));
        }).toList(),
      ),
    );
  }
}
