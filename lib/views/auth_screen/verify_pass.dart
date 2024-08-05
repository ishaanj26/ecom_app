import 'package:ecommerce_app/views/auth_screen/confirmation.dart';
import 'package:ecommerce_app/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyPass extends StatefulWidget {
  const VerifyPass({super.key});

  @override
  State<VerifyPass> createState() => _VerifyPassState();
}

class _VerifyPassState extends State<VerifyPass> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();
  bool _isButtonEnabled = false;
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
                      Text("Check your email",
                          style: GoogleFonts.montserrat(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                          "We have sent a link to XYZ@gmail.com\n enter 5 digit code that is mentioned in the email",
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: Colors.grey,
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildCodeField(_controller1, 1),
                          _buildCodeField(_controller2, 2),
                          _buildCodeField(_controller3, 3),
                          _buildCodeField(_controller4, 4),
                          _buildCodeField(_controller5, 5),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Button(
                          color: _isButtonEnabled
                              ? Colors.red
                              : Colors.red.shade100,
                          title: "Verify Code",
                          onPress: () {
                            if (_isButtonEnabled) {
                              Get.to(() => const Confirmation());
                            }
                          },
                          textColor: Colors.white),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "Haven't got the email yet?",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  )),
                              const WidgetSpan(
                                child: SizedBox(
                                    width: 4), // Add a space of 4 pixels
                              ),
                              TextSpan(
                                  text: "Resend Email",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCodeField(TextEditingController controller, int index) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
          controller: controller,
          maxLength: 1,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            counterText: '',
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Colors.blue), // Change the color to blue when focused
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              _isButtonEnabled = _controller1.text.isNotEmpty &&
                  _controller2.text.isNotEmpty &&
                  _controller3.text.isNotEmpty &&
                  _controller4.text.isNotEmpty &&
                  _controller5.text.isNotEmpty;
            });
            if (value.isNotEmpty && index < 5) {
              FocusScope.of(context).nextFocus();
            }
            ;
          }),
    );
  }
}
