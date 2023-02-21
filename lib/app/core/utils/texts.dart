import 'package:flutter/cupertino.dart';

Text labelText(text, {
  Color? color,
  FontWeight? fontWeight,
  double? fontSize,
  TextAlign? textAlign,
  TextOverflow? overflow,
  TextDecoration? decoration,
}) {
  return Text(
      text,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        overflow: overflow,
        decoration: decoration,
      ),
      textAlign: textAlign,
  );
}
