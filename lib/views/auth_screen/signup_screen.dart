import '../screens/home_screen.dart';
import '../../widgets/buttons.dart';
import '../../widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isCheck = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  String? _nameError;
  String? _emailError;
  String? _passwordError;
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
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Join the Moonlit",
                              style: GoogleFonts.montserrat(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                           Text("Fill the form to continue",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Sans_regular",
                                  color: Colors.grey.shade900)),
                          const SizedBox(height: 30),
                          Column(children: [
                            customTextField(
                                hint: "Enter Name",
                                title: 'Name',
                                controller: _nameController),
                            if (_nameError != null)
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  _nameError!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            customTextField(
                                hint: "Enter Email Address",
                                title: 'Email',
                                controller: _emailController),
                            if (_emailError != null)
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  _emailError!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            customTextField(
                              hint: "******",
                              title: 'Password',
                              controller: _passwordController,
                              obscureText: !_isPasswordVisible,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            if (_passwordError != null)
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  _passwordError!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.black,
                                    activeColor: Colors.white,
                                    value: isCheck,
                                    onChanged: (newValue) {
                                      setState(() {
                                        isCheck = newValue!;
                                      });
                                    }),
                                const SizedBox(width: 10),
                                Expanded(
                                    child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isCheck = !isCheck;
                                    });
                                  },
                                  child: RichText(
                                    text: const TextSpan(
                                      children: [
                                        TextSpan(
                                            text: "I agree to the ",
                                            style: TextStyle(
                                                fontFamily: "Sans_regular",
                                                color: Color(0xFF666666))),
                                        TextSpan(
                                            text: "Terms and Conditions",
                                            style: TextStyle(
                                                fontFamily: "Sans_regular",
                                                color: Color(0xFFC51077))),
                                        TextSpan(
                                            text: " & ",
                                            style: TextStyle(
                                                fontFamily: "Sans_regular",
                                                color: Color(0xFF666666))),
                                        TextSpan(
                                            text: "Privacy Policy",
                                            style: TextStyle(
                                                fontFamily: "Sans_regular",
                                                color: Color(0xFFC51077)))
                                      ],
                                    ),
                                  ),
                                ))
                              ],
                            ),
                            const SizedBox(height: 5),
                            Button(
                                color: isCheck
                                    ? const Color(0xFFC51077)
                                    : const Color(0xFFE5E5E5),
                                title: "Sign Up",
                                onPress: () {
                                  setState(() {
                                    if (_nameController.text.isEmpty) {
                                      _nameError = "Please enter your name";
                                    } else {
                                      _nameError = null;
                                    }
                                    if (_emailController.text.isEmpty) {
                                      _emailError = "Please enter your email";
                                    } else {
                                      _emailError = null;
                                    }
                                    if (_passwordController.text.length < 8) {
                                      _passwordError =
                                          "Password must be at least 8 characters long";
                                    } else if (!RegExp(
                                            r"^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-{};:'<>,./?]).*$")
                                        .hasMatch(_passwordController.text)) {
                                      _passwordError =
                                          "Password must contain at least one special character or one digit";
                                    } else {
                                      _passwordError = null;
                                    }
                                  });
                                  if (_nameError == null &&
                                      _emailError == null &&
                                      _passwordError == null &&
                                      isCheck) {
                                    Get.to(() => const HomeScreen());
                                  }
                                },
                                textColor: Colors.white),
                            const SizedBox(height: 10),
                            Text(
                              "OR",
                              style: GoogleFonts.montserrat(
                                fontSize: 10,
                                color: Colors.grey.shade900,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Button(
                                color: const Color(0xFFEA4335),
                                title: "Sign up with Google",
                                onPress: () {},
                                textColor: Colors.white,
                                icon: Image.asset(
                                  "assets/icons/google_icon.png",
                                  width: 20,
                                  height: 20,
                                )),
                          ]),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                 Text(
                                  "Already have an account?",
                                  style: TextStyle(
                                    color: Colors.grey.shade900,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Login",
                                    style: GoogleFonts.poppins(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ]),
                        ]),
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
