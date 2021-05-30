import 'package:flutter/material.dart';

const String appFontFamily = 'cairo';
final flatButtonStyle = ButtonStyle();
final raisedButtonStyle = ButtonStyle();

final outlineButtonStyle = TextButton.styleFrom(
  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
  textStyle: TextStyle(fontSize: 16, fontFamily: 'cairo'),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);
