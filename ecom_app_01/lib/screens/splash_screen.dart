import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import 'store_walkthrough.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Walkthrough(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F2E6),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Text(
            "from",
            style: GoogleFonts.montserrat(
              fontSize: 20,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "Moonlit Developers Ltd.",
            style: GoogleFonts.montserrat(
              fontSize: 17,
              color: sliderColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(child: Container()), // take up top space
          Column(
            children: [
              Image.asset('assets/icon/moonlit_icon.jpeg'),
            ],
          ),
        ],
      ),
    );
  }
}
