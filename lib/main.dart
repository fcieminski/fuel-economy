import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pl'),
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
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
  bool _isCarInfo = false;
  bool _clearAllFuelling = false;
  Map<String, Widget> menu = {
    'Archiwum spalania': FuellingArchive(),
    'Najbliższe wymiany': Replace(),
    'Przeglądy': NearestService(),
    'Notatki': Notes(),
  };

  void _addRecentFuelling(BuildContext context) async {
    await showModalBottomSheet(
        context: context, builder: (_) => AddRecentFuelling()).then((val) {
      if (val != null &&
          val['amount'] != null &&
          val['amount'].isNotEmpty &&
          val['totalCost'] != null &&
          val['totalCost'].isNotEmpty &&
          val['time'] != null) {
        setState(() {
          newFuelling = val;
        });
      }
    });
  }

  void updateCarInfo(bool childValue) {
    setState(() {
      _isCarInfo = childValue;
      _clearAllFuelling = !childValue;
    });
  }

  void clearFuelling(childValue) {
    setState(() {
      newFuelling = childValue;
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
      body: Container(
        child: Column(
          children: <Widget>[
            CarInfo(newFuelling: newFuelling, notifyParent: updateCarInfo),
            Expanded(
                child: RecentFuelling(
                    newFuelling: newFuelling,
                    clearAddedFuelling: clearFuelling,
                    clearAllFuelling: _clearAllFuelling)),
          ],
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
