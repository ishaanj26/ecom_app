import 'package:ecommerce_app/views/home_screen/home.dart';
import 'views/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //We are using getx hence we change materialapp to getmaterial app
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MoonLit ECommerce App",
      home: Home(),
    );
  }
}
