import 'package:ecommerce_app/views/auth_screen/verify_pass.dart';
import 'package:ecommerce_app/widgets/buttons.dart';
import 'package:ecommerce_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final TextEditingController _emailController = TextEditingController();
  Color _buttonColor = Colors.red.shade100;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Column(children: [
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
                    Text("Forgot Password",
                        style: GoogleFonts.montserrat(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Please enter your email to reset your password",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Colors.grey,
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    Text("Your Email",
                        style: GoogleFonts.montserrat(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    customTextField(
                        hint: "Enter your email", controller: _emailController),
                    const SizedBox(
                      height: 10,
                    ),
                    Button(
                        color: _buttonColor,
                        title: "Reset Password",
                        onPress: () {
                          if (_emailController.text.isNotEmpty) {
                            Get.to(() => const VerifyPass());
                          }
                        },
                        textColor: Colors.white)
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        _buttonColor =
            _emailController.text.isEmpty ? Colors.red.shade100 : Colors.red;
      });
    });
  }
}
