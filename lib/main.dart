import 'package:flutter/material.dart';
import 'package:fuel_economy/components/car_info.dart';
import 'package:fuel_economy/components/recent_fuelling.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
    );
  }
}
