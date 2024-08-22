import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';
import '../../../widget/auth_widgets.dart';
import '../login_screen.dart';


class VerifyPass extends StatefulWidget {
  final String email;
  const VerifyPass({super.key, required this.email});

  @override
  State<VerifyPass> createState() => _VerifyPassState();
}

class _VerifyPassState extends State<VerifyPass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                          ),
                          const Positioned(
                            top: 12,
                            left: 12,
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text("Email Sent",
                          style: GoogleFonts.montserrat(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                        "We have sent an email to ${widget.email} with a link to get back into your account",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Colors.grey.shade900,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: SizedBox(
                        width: 300,
                        child: button(
                            color: buttonColor,
                            title: "Ok",
                            onPress: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            textColor: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
