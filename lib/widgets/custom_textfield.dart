import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customTextField(
    {required String hint,
    String? title,
    required TextEditingController controller,
    bool obscureText = false,
    Widget? suffixIcon}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (title != null)
        Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      const SizedBox(height: 5),
      SizedBox(
        height: 40,
        child: TextFormField(
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
            hintStyle: GoogleFonts.openSans(
              color: Colors.grey,
              fontSize: 14,
            ),
            hintText: hint,
            suffixIcon: suffixIcon,
            isDense: true,
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.black, // Add this
                width: 0.5, // You can adjust the width as needed
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.grey, // Add this
                  width: 0.5, // You can adjust the width as needed
                )),
          ),
        ),
      ),
      const SizedBox(height: 5),
    ],
  );
}
