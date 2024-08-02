import 'package:ecom_app/consts/consts.dart';
import 'package:ecom_app/widgets/applogo_widget.dart';
import 'package:ecom_app/widgets/bg_widget.dart';
import 'package:ecom_app/widgets/button.dart';
import 'package:ecom_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Join the $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Column(children: [
              customTextField(hint: nameHint, title: name),
              customTextField(hint: emailHint, title: email),
              customTextField(hint: passwordHint, title: password),
              customTextField(hint: password, title: retypePassword),
              Row(
                children: [
                  Checkbox(
                      checkColor: redColor,
                      value: false,
                      onChanged: (newValue) {}),
                  10.widthBox,
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                              text: "I agree to the ",
                              style:
                                  TextStyle(fontFamily: bold, color: fontGrey)),
                          TextSpan(
                              text: termAndCond,
                              style:
                                  TextStyle(fontFamily: bold, color: redColor)),
                          TextSpan(
                              text: " & ",
                              style:
                                  TextStyle(fontFamily: bold, color: fontGrey)),
                          TextSpan(
                              text: privacyPolicy,
                              style:
                                  TextStyle(fontFamily: bold, color: redColor))
                        ],
                      ),
                    ),
                  )
                ],
              ),
              5.heightBox,
              Button(
                      color: redColor,
                      title: signup,
                      textColor: whiteColor,
                      onPress: () {})
                  .box
                  .width(context.screenWidth - 50)
                  .make(),
              10.heightBox,
              RichText(
                  text: const TextSpan(
                children: [
                  TextSpan(
                      text: alreadyHaveAccount,
                      style: TextStyle(fontFamily: bold, color: fontGrey)),
                  TextSpan(
                      text: login,
                      style: TextStyle(fontFamily: bold, color: redColor))
                ],
              )).onTap(() {
                Get.back();
              })
            ])
                .box
                .white
                .rounded
                .shadowSm
                .padding(const EdgeInsets.all(16))
                .width(context.screenWidth - 70)
                .make(),
          ],
        ),
      ),
    ));
  }
}
