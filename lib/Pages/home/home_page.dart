import 'package:chat/Pages/home/widgets/custom_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../constants/widgets/flutter_toast.dart';

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

  final streamDate = FirebaseFirestore.instance.collection('Users').snapshots();
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
      body: StreamBuilder(
        stream: streamDate,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            toastInfo(msg: 'Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var userDocs = snapshot.data!.docs;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: userDocs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {},
                  leading: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Image.network(userDocs[index]['imageUrl']),
                    ),
                  ),
                  title: Text(
                    userDocs[index]['userName'],
                  ),
                  trailing: const Text('2:00'),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
