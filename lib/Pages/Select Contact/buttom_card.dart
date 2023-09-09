import 'package:flutter/material.dart';

class ButtomCard extends StatelessWidget {
  const ButtomCard({
    super.key,
    this.name,
    this.iconData,
  });
  final String? name;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color(0xFF25D366),
        radius: 23,
        child: Icon(iconData, color: Colors.white),
      ),
      title: Text(name!),
    );
  }
}
