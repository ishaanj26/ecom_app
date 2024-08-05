import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget Button(
    {required Color color,
    required String title,
    required Function() onPress,
    required Color textColor,
    Widget? icon}) {
  return SizedBox(
    width: double.infinity,
    child: MouseRegion(
      cursor: SystemMouseCursors.click,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Added rounded corners
          ),
          elevation: 5,
        ),
        onPressed: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                color: textColor,
                fontSize: 16,
              ),
            ),
            icon != null
                ? Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      icon,
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    ),
  );
}
