import 'package:flutter/material.dart';

class CarInfo extends StatefulWidget {
  final Map<String, String> newFuelling;
  CarInfo(this.newFuelling);

  @override
  _CarInfoState createState() => _CarInfoState();
}

class _CarInfoState extends State<CarInfo> {
  final _carMaker = TextEditingController();
  final _carModel = TextEditingController();
  final _carEngine = TextEditingController();
  final _carCurrentMileage = TextEditingController();
  final _carTotalFuelCost = TextEditingController();
  // TextEditingController _carMileage;
  Map<String, String> _carInfo = {};

  void _submitForm() {
    setState(() {
      _carInfo.addAll({
        'model': _carModel.text,
        'maker': _carMaker.text,
        'engine': _carEngine.text,
        'currentMileage': _carCurrentMileage.text,
        'totalFuelCost': _carTotalFuelCost.text,
      });
    });
    print(_carInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: (_carInfo.isNotEmpty)
              ? Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Chip(
                          labelStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          label: Text('Honda Civic VIII 1.8 140km'),
                        ),
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
                                      '153 000',
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
                                      '7 800',
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
                                      '10.5',
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
                                      '3 500',
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
                  child: FlatButton(
                    child: Text('dodaj samochód'),
                    onPressed: () => {
                      showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            return Container(
                              child: Scaffold(
                                body: SingleChildScrollView(
                                  child: Form(
                                    child: Column(
                                      children: <Widget>[
                                        TextFormField(
                                          controller: _carMaker,
                                          decoration: const InputDecoration(
                                            labelText: 'Marka',
                                          ),
                                        ),
                                        TextFormField(
                                          controller: _carModel,
                                          decoration: const InputDecoration(
                                            labelText: 'Model',
                                          ),
                                        ),
                                        TextFormField(
                                          controller: _carEngine,
                                          decoration: const InputDecoration(
                                            labelText: 'Silnik',
                                          ),
                                        ),
                                        TextFormField(
                                          controller: _carCurrentMileage,
                                          keyboardType:
                                              TextInputType.numberWithOptions(),
                                          decoration: const InputDecoration(
                                            labelText: 'Przejechane kilometry',
                                          ),
                                        ),
                                        TextFormField(
                                          controller: _carTotalFuelCost,
                                          keyboardType:
                                              TextInputType.numberWithOptions(),
                                          decoration: const InputDecoration(
                                            labelText:
                                                'Dotychczas wydana kwota',
                                          ),
                                        ),
                                        FlatButton(
                                          child: Text(
                                            'Zapisz',
                                          ),
                                          onPressed: _submitForm,
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
                ),
        ),
      ),
    );
  }
}
