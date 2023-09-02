import 'package:chat/Pages/home/widgets/custom_drawer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Connectivity().checkConnectivity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatApp'),
      ),
      drawer: StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          bool isOnline = snapshot.data == ConnectivityResult.mobile ||
                  snapshot.data == ConnectivityResult.wifi
              ? true
              : false;

          return CusttomDrawer(isOnlline: isOnline);
        },
      ),
    );
  }
}
