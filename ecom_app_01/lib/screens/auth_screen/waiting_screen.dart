import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moonlit/constants.dart';
import 'package:moonlit/screens/auth_screen/forgot_pass_page/OTP_screen.dart';
import 'package:moonlit/widget/auth_widgets.dart';

import '../../models/user_model.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({super.key, required this.message});
  final String message;

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _checkEmailVerification();
  }

  void _createData(UserModel userModel) {
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

  Future<void> _checkEmailVerification() async {
    await Future.delayed(const Duration(seconds: 2)); // wait for 2 seconds
    await _auth.currentUser?.reload();
    if (_auth.currentUser?.emailVerified ?? false) {
      _createData(UserModel(
          username: _auth.currentUser!.displayName,
          address: " ",
          phoneNumber: " ",
          id: _auth.currentUser!.uid));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OtpScreen()),
      );
    } else {
      _checkEmailVerification(); // check again
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.message,
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
              const SizedBox(height: 20),
              loading(),
            ],
          ),
        ),
      ),
    );
  }
}
