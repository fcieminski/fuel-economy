import 'package:flutter/material.dart';
import 'package:fuel_economy/components/add_recent_fuelling.dart';
import 'package:fuel_economy/components/car_info.dart';
import 'package:fuel_economy/components/recent_fuelling.dart';

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

class Home extends StatelessWidget {
  void _addRecentFuelling(BuildContext context) {
    showDialog(context: context, builder: (_) => AddRecentFuelling());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wykaz spalania'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              CarInfo(),
              RecentFuelling(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => _addRecentFuelling(context),
      ),
    );
  }
}
