import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fuel_economy/utils/date_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentFuelling extends StatefulWidget {
  final Map<String, dynamic> newFuelling;
  final Function(bool) clearAddedFuelling;
  RecentFuelling({this.newFuelling, this.clearAddedFuelling});

  @override
  _RecentFuellingState createState() => _RecentFuellingState();
}

class _RecentFuellingState extends State<RecentFuelling> {
  List _fuelling;
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future getUserData() async {
    final saveData = await SharedPreferences.getInstance();
    if (saveData.getString('fuelling') != null) {
      Iterable jsonData = json.decode(saveData.getString('fuelling'));
      setState(() {
        _fuelling = jsonData;
      });
    } else {
      setState(() {
        _fuelling = [];
      });
    }
  }

  List get _recentFuelling {
    if (_fuelling != null) {
      _fuelling.sort((a, b) => b['time'].compareTo(a['time']));
      return _fuelling.where((fuel) {
        return DateTime.parse(fuel['time'])
            .isAfter(DateTime.now().subtract(Duration(days: 30)));
      }).toList();
    } else {
      return [];
    }
  }

  void checkFunction(fuelling) async {
    if (fuelling != null) {
      int distance = int.parse(fuelling['distance']);
      double liters = double.parse(fuelling['amount']);
      double totalCost = double.parse(fuelling['totalCost']);
      String date = DateTime.now().toString();
      Map<String, dynamic> newFuelling = {
        'id': date,
        'time': fuelling['time'].toString(),
        'distance': distance,
        'amount': liters,
        'average': num.parse((distance / liters).toStringAsFixed(2)),
        'totalCost': totalCost,
        'fuelCost': num.parse((totalCost / liters).toStringAsFixed(2)),
        'kmCost': num.parse((totalCost / distance).toStringAsFixed(2))
      };
      setState(() {
        _fuelling.add(newFuelling);
      });
      await saveAllFuellings();
    }
  }

  Future saveAllFuellings() async {
    final saveData = await SharedPreferences.getInstance();
    saveData.setString('fuelling', json.encode(_fuelling));
    widget.clearAddedFuelling(null);
  }

  @override
  Widget build(BuildContext context) {
    checkFunction(widget.newFuelling);
    return Container(
      child: (_recentFuelling != null && _recentFuelling.isNotEmpty)
          ? ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: _recentFuelling.map((fuel) {
                return Card(
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
                              label: Text(
                                  'średnie spalanie: ${fuel['average']} l'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              child: Text(DateFormatter.date(fuel['time'])),
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
                );
              }).toList())
          : Container(
              child: SizedBox(
                width: double.infinity,
                height: 200.0,
                child: const Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Dodaj ostatnie tankowanie',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
