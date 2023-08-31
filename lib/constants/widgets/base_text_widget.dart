import 'package:flutter/material.dart';

import 'media_query.dart';

Widget baseTextWidget({
  required BuildContext? context,
  AlignmentGeometry? alignment = Alignment.centerLeft,
  String? text,
  double? fontSize,
}) {
  return Container(
    alignment: Alignment.topCenter,
    margin: EdgeInsets.symmetric(
      horizontal: CustomMediaQuery(context!).screenWidth / 20,
      vertical: CustomMediaQuery(context).screenWidth / 40,
    ),
    child: Align(
      alignment: alignment!,
      child: Text(
        text!,
        style: TextStyle(
          fontSize: fontSize,
        ),
      ),
    ),
  );
}
