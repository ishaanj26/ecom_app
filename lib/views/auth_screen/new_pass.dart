import 'package:ecommerce_app/widgets/buttons.dart';
import 'package:ecommerce_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NewPass extends StatefulWidget {
  const NewPass({super.key});

  @override
  State<NewPass> createState() => _NewPassState();
}

class _NewPassState extends State<NewPass> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _resetpasswordController =
      TextEditingController();
  bool _isPasswordVisible = false;
  bool _isPasswordVisible2 = false;
  bool _isButtonEnabled = false;
  String? _passwordError;
  String? _resetpasswordError;
  void checkPasswords() {
    if (_passwordController.text == _resetpasswordController.text) {
      setState(() {
        _isButtonEnabled = true;
      });
    } else {
      setState(() {
        _isButtonEnabled = false;
      });
    }
  }

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
                      Text("Set a new Password",
                          style: GoogleFonts.montserrat(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                          "Create a new password. Ensure it differes from previous ones for security",
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: Colors.grey,
                          )),
                      const SizedBox(
                        height: 40,
                      ),
                      customTextField(
                          hint: "Enter a new password",
                          controller: _passwordController,
                          title: "Password",
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
                          onChanged: (value) {
                            checkPasswords();
                          }),
                      if (_passwordError != null)
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            _passwordError!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      customTextField(
                          hint: "Re-enter password",
                          controller: _resetpasswordController,
                          title: "Confirm Password",
                          obscureText: !_isPasswordVisible2,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible2
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible2 = !_isPasswordVisible2;
                              });
                            },
                          ),
                          onChanged: (value) {
                            checkPasswords();
                          }),
                      if (_resetpasswordError != null)
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            _resetpasswordError!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      Button(
                        color:
                            _isButtonEnabled ? Colors.red : Colors.red.shade100,
                        title: "Update Password",
                        onPress: _isButtonEnabled
                            ? () {
                                setState(() {
                                  if (_passwordController.text.length < 8) {
                                    _passwordError =
                                        "Password must be at least 8 characters long";
                                  }
                                });
                              }
                            : () {},
                        textColor: Colors.white,
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
}
