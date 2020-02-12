import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fuel_economy/utils/date_formatter.dart';

class NearestService extends StatefulWidget {
  @override
  _NearestServiceState createState() => _NearestServiceState();
}

class _NearestServiceState extends State<NearestService> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  DateTime last;
  int nextService;
  Map<String, DateTime> service = {};

  @override
  initState() {
    super.initState();
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    if (service.isNotEmpty) {
      var scheduledNotificationDateTime =
          new DateTime.now().add(Duration(days: nextService - 3));
      _notifAboutService(scheduledNotificationDateTime);
    }
  }

  _notifAboutService(scheduledNotificationDateTime) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your other channel id',
        'your other channel name',
        'your other channel description');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Zbliża się przegląd!',
        'Pozostało $nextService dni',
        scheduledNotificationDateTime,
        platformChannelSpecifics,
        androidAllowWhileIdle: true);
  }

  _notificationsOn() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your other channel id',
        'your other channel name',
        'your other channel description');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      1,
      'Powiadomienie',
      'Powiadomienie o następnym przeglądzie włączone',
      platformChannelSpecifics,
    );
  }

  void _dataPicker(BuildContext context) async {
    last = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2018),
      lastDate: DateTime.now(),
    );
    if (last != null) {
      setState(() {
        service = {
          'last': last,
          'nearest':  new DateTime(last.year + 1, last.month, last.day + 1)
        };
        nextService = service['nearest'].difference(new DateTime.now()).inDays;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Przeglądy'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: (service.isNotEmpty)
                  ? Card(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Ostatni przegląd: ${DateFormatter.date(service['last'].toString())}',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add_alert),
                                onPressed: () => _notificationsOn(),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Najbliższy przegląd: ${DateFormatter.date(service['nearest'].toString())}',
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Pozostało: $nextService dni',
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      width: double.infinity,
                      height: 200.0,
                      child: const Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Dodaj ostatni przegląd',
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => _dataPicker(context),
      ),
    );
  }
}
