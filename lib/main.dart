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

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> newFuelling;
  bool _isCarInfo = false;

  void _addRecentFuelling(BuildContext context) async {
    await showModalBottomSheet(
        context: context, builder: (_) => AddRecentFuelling()).then((val) {
      setState(() {
        newFuelling = val;
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
      appBar: AppBar(
        title: Text('Wykaz spalania'),
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
