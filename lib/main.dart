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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MoonLit ECommerce App",
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
          fontFamily: "Sans-regular"),
      home: const SplashScreen(),
    );
  }
}
