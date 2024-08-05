import 'package:ecommerce_app/views/auth_screen/new_pass.dart';
import 'package:ecommerce_app/views/screens/home_screen.dart';
import 'package:ecommerce_app/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Confirmation extends StatefulWidget {
  const Confirmation({super.key});

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Password Rest",
                          style: GoogleFonts.montserrat(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                          "Your password has been successfully rest. Click confirm to set a new password",
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: Colors.grey,
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Button(
                          color: Colors.red,
                          title: "Confirm",
                          onPress: () {
                            Get.to(() => const NewPass());
                          },
                          textColor: Colors.white)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
