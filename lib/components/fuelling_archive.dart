import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fuel_economy/utils/date_formatter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FuellingArchive extends StatefulWidget {
  @override
  _FuellingArchiveState createState() => _FuellingArchiveState();
}

class _FuellingArchiveState extends State<FuellingArchive> {
  List _fuelling;
  DateTime _currentDate;

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
        _currentDate = new DateTime.now();
      });
    } else {
      setState(() {
        _fuelling = [];
      });
    }
  }

  List get _oldFuelling {
    if (_fuelling != null) {
      _fuelling.sort((a, b) => b['time'].compareTo(a['time']));
      return _fuelling.where((fuel) {
        final current = DateTime.parse(fuel['time']);
        if (current.year.compareTo(_currentDate.year) == 0 &&
            current.month.compareTo(_currentDate.month) == 0) {
          return true;
        } else {
          return false;
        }
      }).toList();
    } else {
      return [];
    }
  }

  List<Widget> get monthButtons {
    int passedMonths = DateTime.now().month;
    return List.generate(passedMonths, (index) {
      String newIndex = (index + 1).toString().length == 1
          ? '0${index + 1}'
          : (index + 1).toString();
      return Container(
          child: FlatButton(
        padding: const EdgeInsets.all(8),
        onPressed: () => {
          setState(() {
            _currentDate = DateTime.parse('2020-$newIndex-01');
          })
        },
        child: Text(new DateFormat.MMMM('pl').format(DateTime.parse('2020-$newIndex-01'))),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Archiwum'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[200],
              height: 50,
              child: ListView(
                  scrollDirection: Axis.horizontal, children: monthButtons),
            ),
            Expanded(
              child: (_oldFuelling != null && _oldFuelling.isNotEmpty)
                  ? ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: _oldFuelling.map((fuel) {
                        return Card(
                          child: Column(
                            children: <Widget>[
                              Container(
                                 color: Colors.teal[50],
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                        child: Text(
                                            DateFormatter.date(fuel['time'])),
                                      ),
                                    ),
                                  ],
                                ),
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
                  : SizedBox(
                      width: double.infinity,
                      height: 200.0,
                      child: const Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Archiwum jest puste',
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
