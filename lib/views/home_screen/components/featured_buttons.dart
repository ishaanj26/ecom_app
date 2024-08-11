import 'package:flutter/material.dart';

Widget featuredButtons({String? title, icon}) {
  return Container(
    width: 180,
    margin: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    padding: const EdgeInsets.all(4),
    child: Row(
      children: [
        Image.asset(icon),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: Text(
            title!,
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        )
      ],
    ),
  );
}

Widget featuredCategories() {
  return Container(
    padding: const EdgeInsets.all(8),
    margin: const EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          "assets/images/logo.png",
          width: 150,
          fit: BoxFit.cover,
        ),
        Text(
          "Laptop",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.grey.shade800),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Pfice",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.red, fontSize: 16),
        ),
      ],
    ),
  );
}
