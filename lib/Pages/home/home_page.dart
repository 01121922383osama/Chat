import 'package:chat/Pages/Camera%20Page/camera_page.dart';
import 'package:chat/Pages/Chat/chat_page.dart';
import 'package:chat/Pages/home/widgets/custom_drawer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  @override
  void initState() {
    Connectivity().checkConnectivity();
    tabController = TabController(length: 4, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatApp'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 'New Gruap',
                  child: Text('New Gruap'),
                ),
                const PopupMenuItem(
                  value: 'New broadCast',
                  child: Text('New broadCast'),
                ),
                const PopupMenuItem(
                  value: 'WhatsApp Web',
                  child: Text('WhatsApp Web'),
                ),
                const PopupMenuItem(
                  value: 'Started Message',
                  child: Text('Started Message'),
                ),
              ];
            },
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          automaticIndicatorColorAdjustment: true,
          dividerColor: Colors.white,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(
              text: 'Camera',
            ),
            Tab(
              text: 'Chats',
            ),
            Tab(
              text: 'Status',
            ),
            Tab(
              text: 'Calls',
            ),
          ],
        ),
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
      body: TabBarView(
        controller: tabController,
        children: const [
          CameraPage(),
          ChatPage(),
          Text('2'),
          Text('3'),
        ],
      ),
    );
  }
}
