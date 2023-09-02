
  import 'package:flutter/material.dart';

Widget buildListile({
    required String text,
    required IconData iconData,
    required void Function()? onTap,
  }) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(text),
      onTap: onTap,
    );
  }