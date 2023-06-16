import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectionCheck extends StatefulWidget {
  const ConnectionCheck({super.key});

  @override
  State<ConnectionCheck> createState() => _ConnectionCheckState();
}

class _ConnectionCheckState extends State<ConnectionCheck> {
  late StreamSubscription subscription;
  late StreamSubscription internetSubscription;
  bool hasInternet = false;
  @override
  void initState() {
    super.initState();
    subscription =
        Connectivity().onConnectivityChanged.listen(_showConnectivitySnackBar);
    internetSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() {
        this.hasInternet = hasInternet;
      });
    });
  }

  void _showConnectivitySnackBar(ConnectivityResult result) {
    final hasInternet = result != ConnectivityResult.none;
    final message = hasInternet
        ? result == ConnectivityResult.mobile
            ? 'You are connected to Mobile Network'
            : 'You are connected to Mobile wifi'
        : 'You have no Internet';
    final color = hasInternet ? Colors.green : Colors.red;
    _showSnackBar(context, message, color);
  }

  void _showSnackBar(BuildContext context, String? message, Color color) {
    final snackBar = SnackBar(
      content: Text(message!),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('connectionCheck'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildInternetStatus(),
            ElevatedButton(
                onPressed: () async {
                  final result = await Connectivity().checkConnectivity();
                  _showConnectivitySnackBar(result);
                },
                child: const Text('check connectivity'))
          ],
        ),
      ),
    );
  }

  Column buildInternetStatus() {
    return Column(
      children: [
        const Text(
          'Connection status',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 29, color: Colors.black),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              hasInternet ? Icons.done : Icons.error,
              color: hasInternet ? Colors.green : Colors.red,
              size: 40,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(hasInternet ? 'Internet available' : 'Internet not available')
          ],
        )
      ],
    );
  }
}
