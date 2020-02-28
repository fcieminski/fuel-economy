import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarInfo extends StatefulWidget {
  final Map<String, dynamic> newFuelling;
  final Function(bool) notifyParent;
  CarInfo({this.notifyParent, this.newFuelling});

  @override
  _CarInfoState createState() => _CarInfoState();
}

class _CarInfoState extends State<CarInfo> {
  final _carMaker = TextEditingController();
  final _carModel = TextEditingController();
  final _carEngine = TextEditingController();
  final _carCurrentMileage = TextEditingController();
  final _carMileage = TextEditingController();
  final _carTotalFuelCost = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _carInfo;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future getUserData() async {
    final saveData = await SharedPreferences.getInstance();
    if (saveData.getString('carInfo') != null) {
      setState(() {
        _carInfo = json.decode(saveData.getString('carInfo'));
      });
      widget.notifyParent(true);
    } else {
      setState(() {
        _carInfo = {};
      });
    }
  }

  Future saveToStorage(data) async {
    final saveData = await SharedPreferences.getInstance();
    saveData.setString('carInfo', data);
  }

  void _submitForm() async {
    int currentMileage = int.parse(_carCurrentMileage.text);
    int mileage = int.parse(_carMileage.text);
    double totalFuelCost = double.parse(_carTotalFuelCost.text);
    setState(() {
      _carInfo.addAll({
        'model': _carModel.text,
        'maker': _carMaker.text,
        'engine': _carEngine.text,
        'currentMileage': currentMileage,
        'mileage': mileage,
        'totalFuelCost': totalFuelCost,
      });
    });
    saveToStorage(json.encode(_carInfo));
    widget.notifyParent(true);
  }

  void updateCarInfo(newFuelling) {
    if (newFuelling != null) {
      double totalCost = double.parse(newFuelling['totalCost']);
      double mileage = double.parse(newFuelling['distance']);
      setState(() {
        _carInfo.update('totalFuelCost', (dynamic val) => val += totalCost);
        _carInfo.update('mileage', (dynamic val) => val += mileage);
        _carInfo.update('currentMileage', (dynamic val) => val += mileage);
      });
      saveToStorage(json.encode(_carInfo));
    }
  }

  void _removeCurrentCar() async {
    setState(() {
      _carInfo = {};
    });
    saveToStorage(json.encode(_carInfo));
  }

  @override
  Widget build(BuildContext context) {
    updateCarInfo(widget.newFuelling);
    return Container(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: (_carInfo != null && _carInfo.isNotEmpty)
              ? Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Chip(
                            labelStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            label: Text(
                              '${_carInfo['maker']} ${_carInfo['model']} ${_carInfo['engine']}',
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                          ),
                          onPressed: () => {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text(
                                      'Uwaga',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    titlePadding: EdgeInsets.all(10),
                                    content: Text(
                                      'Na pewno chcesz usunąć samochód?',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                          onPressed: () => {
                                                _removeCurrentCar(),
                                                Navigator.pop(context),
                                              },
                                          child: Text(
                                            'Tak',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          )),
                                      FlatButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            'Nie',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ))
                                    ],
                                  );
                                })
                          },
                        )
                      ],
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        'Łączny przebieg',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${_carInfo['currentMileage']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        'Pokonana odległość',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${_carInfo['mileage']}',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        'Średnie spalanie',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      (_carInfo['totalFuelCost'] /
                                              _carInfo['currentMileage'])
                                          .toStringAsFixed(2),
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        'Łączny koszt',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${_carInfo['totalFuelCost']}',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )
              : Container(
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => {
                            showModalBottomSheet(
                                context: context,
                                builder: (_) {
                                  return Container(
                                    padding: EdgeInsets.all(16),
                                    child: Scaffold(
                                      body: SingleChildScrollView(
                                        child: Form(
                                          key: _formKey,
                                          child: Column(
                                            children: <Widget>[
                                              TextFormField(
                                                controller: _carMaker,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Marka',
                                                ),
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Wpisz dane';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              TextFormField(
                                                controller: _carModel,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Model',
                                                ),
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Wpisz dane';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              TextFormField(
                                                controller: _carEngine,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Silnik',
                                                ),
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Wpisz dane';
                                                  } else if (double.tryParse(
                                                          value) ==
                                                      null) {
                                                    return 'Pole akceptuje tylko liczby!';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              TextFormField(
                                                controller: _carCurrentMileage,
                                                keyboardType: TextInputType
                                                    .numberWithOptions(),
                                                decoration:
                                                    const InputDecoration(
                                                  labelText:
                                                      'Pokonana odległość od zakupu',
                                                ),
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Wpisz dane';
                                                  } else if (int.tryParse(
                                                          value) ==
                                                      null) {
                                                    return 'Pole akceptuje tylko liczby!';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              TextFormField(
                                                controller: _carMileage,
                                                keyboardType: TextInputType
                                                    .numberWithOptions(),
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Łączny przebieg',
                                                ),
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Wpisz dane';
                                                  } else if (int.tryParse(
                                                          value) ==
                                                      null) {
                                                    return 'Pole akceptuje tylko liczby!';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              TextFormField(
                                                controller: _carTotalFuelCost,
                                                keyboardType: TextInputType
                                                    .numberWithOptions(),
                                                decoration:
                                                    const InputDecoration(
                                                  labelText:
                                                      'Dotychczas wydana kwota',
                                                ),
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Wpisz dane';
                                                  } else if (double.tryParse(
                                                          value) ==
                                                      null) {
                                                    return 'Pole akceptuje tylko liczby!';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              SizedBox(
                                                width: double.infinity,
                                                child: RaisedButton(
                                                  child: Text(
                                                    'Zapisz',
                                                  ),
                                                  onPressed: () {
                                                    if (_formKey.currentState
                                                        .validate()) {
                                                      _submitForm();
                                                      Navigator.pop(context);
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
                                })
                          },
                        ),
                        Text(
                          'Dodaj swój samochód',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
