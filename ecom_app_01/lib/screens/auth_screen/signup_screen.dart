import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moonlit/screens/auth_screen/waiting_screen.dart';
import 'firebase/firebase_auth_implementation.dart';

import '../../constants.dart';
import '../../widget/auth_widgets.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isCheck = false;
  bool _isSigning = false;
  final FirebaseAuthImplementation _auth = FirebaseAuthImplementation();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _otpError;
  late String phoneNumber;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: _isSigning
          ? loading()
          : SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: 25,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Let's Get Started",
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
                              const SizedBox(height: 40),
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
                                        _isPasswordVisible =
                                            !_isPasswordVisible;
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
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                if (_otpError != null)
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Center(
                                      child: Text(
                                        _otpError!,
                                        style:
                                            const TextStyle(color: Colors.red),
                                      ),
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
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Sans_regular",
                                                    color: sliderColor)),
                                            TextSpan(
                                                text: " & ",
                                                style: TextStyle(
                                                    fontFamily: "Sans_regular",
                                                    color: Color(0xFF666666))),
                                            TextSpan(
                                                text: "Privacy Policy",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Sans_regular",
                                                    color: sliderColor))
                                          ],
                                        ),
                                      ),
                                    ))
                                  ],
                                ),
                                const SizedBox(height: 5),
                                button(
                                    color: isCheck
                                        ? buttonColor
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
                                          _emailError =
                                              "Please enter your email";
                                        } else {
                                          _emailError = null;
                                        }
                                        if (_passwordController.text.length <
                                            8) {
                                          _passwordError =
                                              "Password must be at least 8 characters long";
                                        } else if (!RegExp(
                                                r"^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-{};:'<>,./?]).*$")
                                            .hasMatch(
                                                _passwordController.text)) {
                                          _passwordError =
                                              "Password must contain atleast one digit and a character";
                                        } else {
                                          _passwordError = null;
                                        }
                                      });
                                      if (_nameError == null &&
                                          _emailError == null &&
                                          _passwordError == null &&
                                          isCheck) {
                                        _signUp();
                                      }
                                    },
                                    textColor: Colors.white),
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
                                        color: sliderColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void _signUp() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String name = _nameController.text;

    setState(() {
      _isSigning = true;
    });
    try {
      User? user = await _auth.signUpWithEmailAndPassword(email, password);
      if (user != null) {
        await user.sendEmailVerification();
        await user.updateDisplayName(name);
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const WaitingScreen(
            message:
                "User is successfully created.\nPlease Verify your Email Adddress..",
          ),
        ),
      );
      setState(() {
        _isSigning = false;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: 'The account already exists for that email.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: "Email is already in use");
      } else if (e.code == 'invalid-email') {
        Fluttertoast.showToast(msg: "Email is invalid");
      } else {
        Fluttertoast.showToast(msg: 'An error occurred. Please try again. $e');
      }
    } finally {
      setState(() {
        _isSigning = false;
      });
    }
  }
}
