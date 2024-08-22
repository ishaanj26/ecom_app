import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:country_flags/country_flags.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moonlit/constants.dart';
import 'package:moonlit/screens/auth_screen/login_screen.dart';
import 'package:moonlit/screens/store_bottom_navbar.dart';
import 'package:moonlit/widget/auth_widgets.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpController1 = TextEditingController();
  final TextEditingController _otpController2 = TextEditingController();
  final TextEditingController _otpController3 = TextEditingController();
  final TextEditingController _otpController4 = TextEditingController();
  final TextEditingController _otpController5 = TextEditingController();
  final TextEditingController _otpController6 = TextEditingController();
  late String _verificationId;
  late String verified_number;
  bool _isLoading = false;
  bool _showOTP = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: kprimaryColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              final usercollection =
                  FirebaseFirestore.instance.collection("users");
              usercollection.doc(_auth.currentUser!.uid).delete(); //here
              _auth.currentUser!.delete();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          ),
        ),
        body: _isLoading
            ? loading()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("OTP VERIFICATION",
                            style: GoogleFonts.montserrat(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      const SizedBox(height: 150),
                      const SizedBox(
                        height: 10,
                      ),
                      customTextField(
                          title: "Phone Number",
                          hint: "Enter Phone Number",
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 10),
                            child: SizedBox(
                              width: 80,
                              child: Row(children: [
                                CountryFlag.fromCountryCode(
                                  "IN",
                                  width: 25,
                                  height: 20,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                const Text(
                                  "+91",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ]),
                            ),
                          ),
                          controller: _phoneNumberController),
                      ElevatedButton(
                        onPressed: () async {
                          if (_phoneNumberController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Please enter phone number");
                            return;
                          }
                          _sendOtp();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kprimaryColor,
                          padding: const EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Send OTP',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                     _showOTP? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              OTPBox(
                                  controller: _otpController1,
                                  context: context),
                              OTPBox(
                                  controller: _otpController2,
                                  context: context),
                              OTPBox(
                                  controller: _otpController3,
                                  context: context),
                              OTPBox(
                                  controller: _otpController4,
                                  context: context),
                              OTPBox(
                                  controller: _otpController5,
                                  context: context),
                              OTPBox(
                                  controller: _otpController6, context: context)
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              await _verifyOtp();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                              padding: const EdgeInsets.all(20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Verify OTP',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ):Container(),
                    ],
                  ),
                ),
              ));
  }

  Future<void> _sendOtp() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: "+91${_phoneNumberController.text.toString()}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          setState(() {
            _isLoading = false;
            _showOTP = true;
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          Fluttertoast.showToast(msg: "Failed to send OTP: $e");
          setState(() {
            _isLoading = false;
          });
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationId = verificationId;
            _isLoading = false;
            _showOTP = true;
          });
          Fluttertoast.showToast(msg: "OTP has been sent");
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _verificationId = verificationId;
          });
        },
      );
      verified_number = _phoneNumberController.text;
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to send OTP");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _verifyOtp() async {
    try {
      setState(() {
        _isLoading = true;
      });
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _otpController1.text +
            _otpController2.text +
            _otpController3.text +
            _otpController4.text +
            _otpController5.text +
            _otpController6.text,
      );

      await _auth.currentUser?.linkWithCredential(credential);
      _addPhoneNumberToDatabase();
    } catch (e) {
      Fluttertoast.showToast(msg: "Invalid OTP");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _addPhoneNumberToDatabase() async {
    try {
      final usercollection = FirebaseFirestore.instance.collection("users");
      final userId = _auth.currentUser!.uid;
      await usercollection.doc(userId).set({
        "phoneNumber": verified_number,
      }, SetOptions(merge: true));
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const BottomNavBar()));
      Fluttertoast.showToast(msg: "OTP Verified Successfully");
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error adding phone number to database: $e');
    }
  }
}
