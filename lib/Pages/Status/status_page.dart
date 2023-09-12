import 'package:chat/Pages/Status/widgets/header_own_stause.dart';
import 'package:chat/Pages/Status/widgets/other_status.dart';
import 'package:chat/constants/widgets/media_query.dart';
import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: FloatingActionButton(
              backgroundColor: Colors.grey,
              onPressed: () {},
              child: const Icon(
                Icons.edit,
              ),
            ),
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            elevation: 5,
            backgroundColor: Colors.greenAccent[700],
            onPressed: () {},
            child: const Icon(
              Icons.camera,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const HeaderOwnStatus(),
            lableName('Recent update'),
            const OtherStatus(
              name: 'Osama',
              imageName: '2.jpeg',
              isSean: true,
              statusNum: 5,
            ),
            const OtherStatus(
              name: 'Ali',
              imageName: '2.jpeg',
              isSean: true,
              statusNum: 2,
            ),
            const OtherStatus(
              name: 'Sied',
              imageName: '2.jpeg',
              isSean: true,
              statusNum: 3,
            ),
            lableName('Viewed update'),
            const OtherStatus(
              name: 'Osama',
              imageName: '2.jpeg',
              isSean: false,
              statusNum: 1,
            ),
            const OtherStatus(
              name: 'Ali',
              imageName: '2.jpeg',
              isSean: false,
              statusNum: 2,
            ),
            const OtherStatus(
              name: 'Sied',
              imageName: '2.jpeg',
              isSean: false,
              statusNum: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget lableName(String labeleName) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 33,
      width: CustomMediaQuery(context).screenWidth,
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
        child: Text(labeleName),
      ),
    );
  }
}
