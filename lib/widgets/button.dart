import 'package:ecom_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget Button({required Color color, required String title, required Null Function() onPress, required Color textColor}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: color, padding: const EdgeInsets.all(12)),
    onPressed:onPress,
    child: title.text.fontFamily(bold).color(textColor).make(),
  );
}
