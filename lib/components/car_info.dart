import 'package:flutter/material.dart';

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
  Map<String, dynamic> _carInfo = {};

  void _submitForm() {
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
    widget.notifyParent(true);
  }

  void updateCarInfo(newFuelling) {
    if(newFuelling != null){
      double totalCost = double.parse(newFuelling['totalCost']);
      double mileage = double.parse(newFuelling['distance']);
      setState(() {
        _carInfo.update('totalFuelCost',  (dynamic val) => val += totalCost);
        _carInfo.update('mileage',  (dynamic val) => val += mileage);
        _carInfo.update('currentMileage',  (dynamic val) => val += mileage);
      });
    }
  }
  

  @override
  Widget build(BuildContext context) {
    updateCarInfo(widget.newFuelling);
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
                          label: Text(
                              '${_carInfo['maker']} ${_carInfo['model']} ${_carInfo['engine']}'),
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
                                      (_carInfo['totalFuelCost'] / _carInfo['currentMileage'])
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
                                            labelText:
                                                'Pokonana odległość od zakupu',
                                          ),
                                        ),
                                        TextFormField(
                                          controller: _carMileage,
                                          keyboardType:
                                              TextInputType.numberWithOptions(),
                                          decoration: const InputDecoration(
                                            labelText: 'Łączny przebieg',
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
                                          onPressed: () {
                                            _submitForm();
                                            Navigator.pop(context);
                                          },
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
