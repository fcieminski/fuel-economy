import 'package:flutter/material.dart';

class CarInfo extends StatefulWidget {
  @override
  _CarInfoState createState() => _CarInfoState();
}

class _CarInfoState extends State<CarInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Chip(
                  label: Text('Honda Civic VIII 1.8 140km'),
                ),
                Chip(
                  label: Text('153 200km 2 miesiące'),
                )
              ],
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Row(children: <Widget>[
                    Text('Łączny przebieg'),
                    Text('Pokonana odległość')
                  ]),
                  Row(
                    children: <Widget>[
                      Text('Średnie spalanie'),
                      Text('Łączny koszt')
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
