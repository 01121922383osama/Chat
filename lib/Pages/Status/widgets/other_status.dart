import 'package:flutter/material.dart';

class OtherStatus extends StatelessWidget {
  const OtherStatus({super.key, this.name, this.imageName});
  final String? name;
  final String? imageName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 26,
        backgroundImage: AssetImage('assets/images/$imageName'),
      ),
      title: Text(
        name!,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        'Tody now',
        style: TextStyle(
          fontSize: 13,
        ),
      ),
    );
  }
}
