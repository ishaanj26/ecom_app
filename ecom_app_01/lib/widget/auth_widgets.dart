import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget loading() {
  return const Center(
      child: CircularProgressIndicator(
    color: Colors.black,
  ));
}

Widget button(
    {required Color color,
    required String title,
    required Function() onPress,
    required Color textColor,
    Widget? icon,
    double? fontSize}) {
  return SizedBox(
    width: double.infinity,
    child: MouseRegion(
      cursor: SystemMouseCursors.click,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          minimumSize: const Size(double.infinity, 60),
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
                fontSize: fontSize ?? 16,
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

Widget customTextField(
    {required String hint,
    String? title,
    required TextEditingController controller,
    bool obscureText = false,
    Widget? suffixIcon,
    Widget? prefixIcon,
    void Function(String)? onChanged}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (title != null)
        Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      const SizedBox(height: 10),
      SizedBox(
        height: 70,
        child: TextFormField(
          cursorColor: const Color.fromARGB(255, 69, 49, 41),
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
            hintStyle: GoogleFonts.openSans(
              color: Colors.grey,
              fontSize: 14,
            ),
            hintText: hint,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            isDense: false,
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.all(20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.grey, // Add this
                width: 0.5, // You can adjust the width as needed
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.grey, // Add this
                width: 0.5, // You can adjust the width as needed
              ),
            ),
          ),
          onChanged: onChanged,
        ),
      ),
      const SizedBox(height: 5),
    ],
  );
}

Widget OTPBox({
  required TextEditingController controller,
  required BuildContext context,
}) {
  return SizedBox(
    width: 40,
    child: TextFormField(
        decoration: const InputDecoration(
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1)),
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 59, 43, 40), width: 3),
          ),
          counterStyle: TextStyle(fontSize: 0),
        ),
        maxLength: 1,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        controller: controller,
        cursorColor: const Color.fromARGB(255, 69, 49, 41)),
  );
}
