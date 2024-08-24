import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moonlit/screens/splash_screen.dart';
import 'package:moonlit/screens/store_bottom_navbar.dart';
import 'package:provider/provider.dart';

import 'provider/add_to_cart_provider.dart';
import 'provider/favorite_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyA09zb8qrAXKtgDSF2NIoja8rb-vLoIUms",
            authDomain: "moonlit-cfb10.firebaseapp.com",
            projectId: "moonlit-cfb10",
            storageBucket: "moonlit-cfb10.appspot.com",
            messagingSenderId: "861073529342",
            appId: "1:861073529342:web:c2f7b05693141e84a288af",
            measurementId: "G-3W44TKPBML"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          // for add to cart
          ChangeNotifierProvider(create: (_) => CartProvider()),
          // for favorite
          ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.mulishTextTheme(),
          ),
          home: StatefulBuilder(
            builder: (context, setState) {
              return FutureBuilder(
                future: auth.authStateChanges().first,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return const BottomNavBar();
                    } else {
                      return const SplashScreen();
                    }
                  } else {
                    return const SplashScreen();
                  }
                },
              );
            },
          ),
        ),
      );
}
