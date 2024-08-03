import 'package:ecommerce_app/views/auth_screen/signup_screen.dart';
import 'package:ecommerce_app/views/screens/home_screen.dart';
import 'package:ecommerce_app/widgets/buttons.dart';
import 'package:ecommerce_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFF7F7F7),
              ],
            ),
          ),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                Text(
                  "Log in to Moonlit",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      customTextField(
                          hint: "Enter your Email",
                          title: "Email Address",
                          controller: _emailController),
                      customTextField(
                          hint: "*******",
                          title: "Password",
                          controller: _passwordController),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password?",
                            style: GoogleFonts.poppins(
                                color: Colors.red, fontSize: 14),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Button(
                          color: Colors.red,
                          title: "Login",
                          textColor: Colors.white,
                          onPress: () {
                            Get.to(() => const HomeScreen());
                          }),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Create New Account",
                            style: GoogleFonts.openSans(
                              color: Colors.grey.shade500,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () => Get.to(() => const SignupScreen()),
                            child: Text(
                              "Signup",
                              style: GoogleFonts.poppins(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
