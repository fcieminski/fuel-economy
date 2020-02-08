import 'package:flutter/material.dart';
import 'package:fuel_economy/components/add_recent_fuelling.dart';
import 'package:fuel_economy/components/car_info.dart';
import 'package:fuel_economy/components/fuelling_archive.dart';
import 'package:fuel_economy/components/nearest_service.dart';
import 'package:fuel_economy/components/recent_fuelling.dart';
import 'package:fuel_economy/components/notes.dart';
import 'package:fuel_economy/components/replace.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> newFuelling;
  String distance;
  bool _isCarInfo = false;
  Map<String, Widget> menu = {
    'Archiwum spalania': FuellingArchive(),
    'Najbliższe wymiany': Replace(),
    'Przeglądy': NearestService(),
    'Notatki': Notes(),
  };

  void _addRecentFuelling(BuildContext context) async {
    await showModalBottomSheet(
        context: context, builder: (_) => AddRecentFuelling()).then((val) {
      setState(() {
        newFuelling = val;
        distance = val['distance'];
      });
    });
  }

  void updateCarInfo(bool childValue) {
    setState(() {
      _isCarInfo = childValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Wykaz spalania'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new DropdownButtonHideUnderline(
              child: new DropdownButton<Widget>(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                items: menu.entries
                    .map<DropdownMenuItem<Widget>>(
                        (MapEntry<String, Widget> route) =>
                            DropdownMenuItem<Widget>(
                              value: route.value,
                              child: Text(route.key),
                            ))
                    .toList(),
                onChanged: (value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => value),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      drawer: new Drawer(
        elevation: 2,
        child: Column(),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              CarInfo(newFuelling: newFuelling, notifyParent: updateCarInfo),
              RecentFuelling(newFuelling),
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: _isCarInfo,
        child: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          onPressed: () => _addRecentFuelling(context),
        ),
      ),
    );
  }
}
