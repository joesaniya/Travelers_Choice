import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:provider/provider.dart';

class ConnectivityDemo extends StatefulWidget {
  ConnectivityDemo() : super();

  final String title = "Connectivity Demo";

  @override
  ConnectivityDemoState createState() => ConnectivityDemoState();
}

class ConnectivityDemoState extends State<ConnectivityDemo> {
  // In this video we will see 3 different ways to check network connectivity in Flutter.
  // So Let's Start...
  // First add the plugin..go to pubspec.yaml file and add.
  // The Plugin link is available in the description.

  // To keep it simple lets create 3 different varaibles to identify each
  // import the needed pacakges

  String _networkStatus1 = '';
  String _networkStatus2 = '';
  String _networkStatus3 = '';

  Connectivity connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? subscription;

  @override
  void initState() {
    super.initState();
    checkConnectivity2();
  }

  // Method1
  void checkConnectivity1() async {
    var connectivityResult = await connectivity.checkConnectivity();
    var conn = getConnectionValue(connectivityResult);
    setState(() {
      _networkStatus1 = 'Check Connection:: ' + conn;
    });
  }

  // Method2 - Using Subscription
  void checkConnectivity2() async {
    // Subscribe to the connectivity change
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      var conn = getConnectionValue(result);
      setState(() {
        _networkStatus2 = '<Subscription> :: ' + conn;
      });
    });
  }

  // Method3 - Using Providers

  void checkConnectivity3() async {
    var connectivityResult = Provider.of<ConnectivityResult>(context);
    var conn = getConnectionValue(connectivityResult);
    setState(() {
      _networkStatus3 = '<Provider> :: ' + conn;
    });
  }

  // Method to convert the connectivity to a string value
  String getConnectionValue(var connectivityResult) {
    String status = '';
    switch (connectivityResult) {
      case ConnectivityResult.mobile:
        status = 'Mobile';
        break;
      case ConnectivityResult.wifi:
        status = 'Wi-Fi';
        break;
      case ConnectivityResult.none:
        status = 'None';
        break;
      default:
        status = 'None';
        break;
    }
    return status;
  }

  @override
  Widget build(BuildContext context) {
    // Update widget whenever connection changes
    checkConnectivity3();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(_networkStatus1),
            SizedBox(height: 20.0),
            GestureDetector(
              child: Text('Check Connection'),
              onTap: () {
                checkConnectivity1();
              },
            ),
            SizedBox(height: 20.0),
            // This string will be updated automatically when the
            // connection changes
            Text(_networkStatus2),
            SizedBox(height: 20.0),
            Text(_networkStatus3),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
