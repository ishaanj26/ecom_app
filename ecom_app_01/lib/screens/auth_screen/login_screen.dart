import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:moonlit/screens/auth_screen/forgot_pass_page/OTP_screen.dart';

import '../../constants.dart';
import '../../models/user_model.dart';
import '../../widget/auth_widgets.dart';
import '../store_bottom_navbar.dart';
import 'firebase/firebase_auth_implementation.dart';
import 'forgot_pass_page/forgot_pass.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuthImplementation _auth = FirebaseAuthImplementation();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isSigning = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define responsive padding and font sizes
    final horizontalPadding = screenWidth * 0.05; // 5% of screen width
    final verticalPadding = screenHeight * 0.02; // 2% of screen height
    final fontSizeTitle = screenWidth * 0.06; // Responsive font size for title
    final fontSizeSubtitle =
        screenWidth * 0.04; // Responsive font size for subtitle

    return Scaffold(
      backgroundColor: bgColor,
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
          child: _isSigning
              ?loading()
              : SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Column(
                      mainAxisSize: MainAxisSize
                          .min, // Prevents overflow on smaller screens
                      children: [
                        SizedBox(height: screenHeight * 0.22),
                        Text(
                          "Welcome Back",
                          style: GoogleFonts.poppins(
                            fontSize: fontSizeTitle,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                            height:
                                verticalPadding * 2.5), // Responsive spacing
                        customTextField(
                            hint: "Enter your Email",
                            title: "Email Address",
                            controller: _emailController),
                        customTextField(
                          hint: "*******",
                          title: "Password",
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgotPass(),
                                ),
                              );
                            },
                            child: Text(
                              "Forgot Password?",
                              style: GoogleFonts.poppins(
                                  color: sliderColor,
                                  fontSize: fontSizeSubtitle),
                            ),
                          ),
                        ),
                        SizedBox(height: verticalPadding), // Responsive spacing
                        button(
                            color: buttonColor,
                            title: "Login",
                            textColor: Colors.white,
                            onPress: () {
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const BottomNavBar(),
                              //   ),
                              // );
                              _signUp();
                            }),
                        const SizedBox(height: 10),
                        Text(
                          "OR",
                          style: GoogleFonts.montserrat(
                            fontSize: 10,
                            color: Colors.grey.shade900,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        button(
                          color: kprimaryColor,
                          title: "Sign in with Google",
                          onPress: () {
                            _signInWithGoogle();
                          },
                          textColor: Colors.white,
                          icon: Container(
                            width: 41, // Adjust the width as needed
                            height: 41, // Adjust the height as needed
                            decoration: const BoxDecoration(
                              color: Colors.white, // Background color
                              shape: BoxShape.circle, // Circular shape
                            ),
                            child: Center(
                              child: Image.asset(
                                "assets/icon/google_icon.png",
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: screenHeight * 0.1), // Responsive spacing
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: GoogleFonts.openSans(
                                color: Colors.grey.shade700,
                                fontSize: fontSizeSubtitle,
                              ),
                            ),
                            SizedBox(
                                width: horizontalPadding *
                                    0.5), // Responsive spacing
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignupScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Signup",
                                style: GoogleFonts.poppins(
                                  color: sliderColor,
                                  fontSize: fontSizeSubtitle,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  void _signUp() async {
    setState(() {
      _isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;
    try {
      User? user = await _auth.signInWithEmailAndPassword(email, password);

      setState(() {
        _isSigning = false;
      });

      if (user != null && user.emailVerified) {
        Fluttertoast.showToast(msg: "User is successfully logged in");
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavBar(),
          ),
        );
      } else if (!user!.emailVerified) {
        //here
        user.sendEmailVerification();
        Fluttertoast.showToast(
            msg: "Please verify your email address before logging in.");
      } else {
        Fluttertoast.showToast(msg: "Invalid email or password");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'No user found for that email.');
      } else if (e.code == 'invalid-credential' || e.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: "The username or the password entered is incorrect");
      } else if (e.code == 'invalid-email' ||
          e.code == 'invalid-password' ||
          e.code == 'channel-error') {
        Fluttertoast.showToast(msg: "The username or password is invalid");
      } else {
        Fluttertoast.showToast(msg: "Error:${e.code}");
      }
    } finally {
      setState(() {
        _isSigning = false;
      });
    }
  }

  _signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await _firebaseAuth.signInWithCredential(credential);
        _setupDatabase();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "some error occured $e");
    }
  }

  void _createData(UserModel userModel) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final usercollection = FirebaseFirestore.instance.collection("users");
    String id = _auth.currentUser!.uid;

    final newUser = UserModel(
      address: userModel.address,
      username: userModel.username,
      id: id,
      phoneNumber: userModel.phoneNumber,
    ).toJson();

    usercollection.doc(id).set(newUser);
  }

  Future<void> _setupDatabase() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final usercollection = FirebaseFirestore.instance.collection("users");
    String id = _auth.currentUser!.uid;
    final userDoc = await usercollection.doc(id).get();
    if (userDoc.exists) {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavBar(),
        ),
      );
    } else {
      _createData(UserModel(
        username: _auth.currentUser!.displayName,
        address: " ",
        phoneNumber: " ",
        id: id,
      ));
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => const OtpScreen(),
        ),
      );
    }
  }
}
