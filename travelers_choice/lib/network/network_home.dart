import 'package:flutter/material.dart';
import 'package:hotel_travel/views/full_app.dart';

import 'package:provider/provider.dart';

import 'network_aware_widget.dart';
import 'network_status_service.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Network Aware App"),
      ),
      body: StreamProvider<NetworkStatus>(
        // initialData:Null,
        initialData: NetworkStatus.Online,
        create: (context) =>
            NetworkStatusService().networkStatusController.stream,
        child: NetworkAwareWidget(
          onlineChild: Container(
            child: Center(
              child: Text(
                "I am online",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          offlineChild: Container(
            child: Center(
              child: Text(
                "No internet connection!",
                style: TextStyle(
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
