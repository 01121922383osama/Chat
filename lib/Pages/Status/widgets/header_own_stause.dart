import 'package:chat/Pages/Status/widgets/other_status.dart';
import 'package:flutter/material.dart';

class HeaderOwnStatus extends StatelessWidget {
  const HeaderOwnStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        children: [
          CustomPaint(
            painter: StatusPainter(isSean: true, statusNum: 7),
            child: const CircleAvatar(
              radius: 27,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/balram.jpg'),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Colors.greenAccent[700],
              radius: 10,
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      title: const Text(
        'My Status',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: const Text(
        'Tap to add status update',
        style: TextStyle(
          fontSize: 13,
        ),
      ),
    );
  }
}
