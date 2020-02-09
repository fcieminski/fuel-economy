import 'dart:convert';
import 'package:flutter/material.dart';
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
        _currentDate = DateTime.parse('2020-01-09');
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
    }
  }

  // List<Widget> get monthButtons {
  //   return List.generate(12, (index) {
  //     final month = DateTime.now().subtract(Duration(month: index)).month;
  //     return Container(
  //         padding: const EdgeInsets.all(8),
  //         child: FlatButton(onPressed: null, child: Text(month.toString())));
  //   }).reversed.toList();
  // }

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
                              Row(
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
                                          '${fuel['time'].toString().substring(0, 10)}'),
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
                  : SizedBox(
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
            )
          ],
        ),
      ),
    );
  }
}
