import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future _notifAboutService() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(0, 'service', 'test', platformChannelSpecifics, payload: 'hello');
  }

  void _dataPicker(BuildContext context) async {
    last = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2018),
      lastDate: DateTime.now(),
    );
    setState(() {
      service = {
        'last': last,
        'nearest': new DateTime(last.year + 1, last.month, last.day + 1)
      };
      nextService = service['nearest'].difference(service['last']).inDays;
    });
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
                                  'Ostatni przegląd: ${service['last'].toString().substring(0, 10)}',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add_alert),
                                onPressed: () => _notifAboutService(),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Najbliższy przegląd: ${service['nearest'].toString().substring(0, 10)}',
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

  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: new Text('Notificatioooooon'),
        content: new Text('$payload'),
      ),
    );
  }
}
