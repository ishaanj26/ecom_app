import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moonlit/widget/auth_widgets.dart';

import '../../../constants.dart';
import '../firebase/firebase_auth_implementation.dart';
import 'verify_pass.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final TextEditingController _emailController = TextEditingController();
  Color _buttonColor = const Color(0xFF9898A2);
  String _errorText = '';
  bool _isResettingPassword = false;
  final _auth = FirebaseAuthImplementation();

  @override
  Widget build(BuildContext context) {
    // Retrieve screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define responsive padding and font sizes
    final horizontalPadding = screenWidth * 0.05; // 5% of screen width
    final verticalPadding = screenHeight * 0.03; // 3% of screen height
    final fontSizeTitle = screenWidth * 0.055; // Responsive font size
    final fontSizeSubtitle = screenWidth * 0.04; // Responsive font size

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: Colors.black, size: 25),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding, vertical: verticalPadding),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Forgot Password",
                        style: GoogleFonts.montserrat(
                          fontSize: fontSizeTitle, // Responsive font size
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: verticalPadding * 0.5, // Responsive spacing
                      ),
                      Text(
                        "Please enter your email to reset your password",
                        style: GoogleFonts.montserrat(
                          fontSize: fontSizeSubtitle, // Responsive font size
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: verticalPadding, // Responsive spacing
                      ),
                      Text(
                        "Your Email",
                        style: GoogleFonts.montserrat(
                          fontSize: fontSizeTitle, // Responsive font size
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: verticalPadding * 0.5, // Responsive spacing
                      ),
                      customTextField(
                        hint: "Enter your email",
                        controller: _emailController,
                      ),
                      SizedBox(
                        height: verticalPadding * 0.5, // Responsive spacing
                      ),
                      button(
                        color: _buttonColor,
                        title: "Send Email",
                        onPress: () async {
                          if (_emailController.text.isNotEmpty) {
                            setState(() {
                              _isResettingPassword = true;
                            });
                            try {
                              await _auth.sendPasswordlResetLink(
                                  _emailController.text);
                              setState(() {
                                _isResettingPassword = false;
                              });
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled:
                                    true, // This will allow the sheet to be scrolled
                                builder: (context) => SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    child: VerifyPass(
                                        email: _emailController.text)),
                              );
                            } catch (e) {
                              setState(() {
                                _isResettingPassword = false;
                                _errorText = e.toString();
                              });
                            }
                          }
                        },
                        textColor: kcontentColor,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: _isResettingPassword
                            ? loading()
                            : Text(
                                _errorText,
                                style: const TextStyle(color: Colors.red),
                              ),
                      ),
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

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        _buttonColor = _emailController.text.isEmpty
            ? const Color(0xFF9898A2)
            : buttonColor;
      });
    });
  }
}
