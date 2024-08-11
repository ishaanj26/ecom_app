import 'package:flutter/material.dart';

Widget HomeButtons({width, height, icon, iconColor, title, onPress}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        const SizedBox(height: 10.0),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w400),
        )
      ],
    ),
  );
}
