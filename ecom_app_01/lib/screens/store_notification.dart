import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

import '../constants.dart';
import 'store_bottom_navbar.dart';

class StoreNotification extends StatefulWidget {
  const StoreNotification({super.key});

  @override
  State<StoreNotification> createState() => _StoreNotificationState();
}

class _StoreNotificationState extends State<StoreNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(10),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(EvaIcons.arrow_ios_back_outline),
                ),
              ],
            ),
            const Notification(
                "Welcome to Moonlit! 🌙",
                "We’re thrilled to have you join our fashion community. Explore the latest trends and elevate your style with ease. Happy shopping!",
                "Explore now",
                BottomNavBar()),
          ],
        ),
      ),
    );
  }
}

class Notification extends StatelessWidget {
  final String title;
  final String description;
  final String button;
  final Widget navigation;
  const Notification(this.title, this.description, this.button, this.navigation,
      {super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const SizedBox(height: 20,),
        Container(
          width: screenWidth,
          decoration: BoxDecoration(
              color: kcontentColor, borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Text(
                  title,
                  style: GoogleFonts.quicksand(
                      color: sliderColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: GoogleFonts.quicksand(color: sliderColor, fontSize: 15),
                ),
                const SizedBox(height: 10),
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => navigation,
                        ),
                      );
                    },
                    child: Text(
                      button,
                      style: GoogleFonts.quicksand(
                          color: sliderColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    )),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}