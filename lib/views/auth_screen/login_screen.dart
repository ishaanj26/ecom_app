import 'package:ecom_app/consts/consts.dart';
import 'package:ecom_app/consts/list.dart';
import 'package:ecom_app/views/auth_screen/signup_screen.dart';
import 'package:ecom_app/widgets/applogo_widget.dart';
import 'package:ecom_app/widgets/bg_widget.dart';
import 'package:ecom_app/widgets/button.dart';
import 'package:ecom_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,
              Column(
                children: [
                  customTextField(hint: emailHint, title: email),
                  customTextField(hint: passwordHint, title: password),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {}, child: forgetPassword.text.make()),
                  ),
                  5.heightBox,
                  Button(
                          color: redColor,
                          title: login,
                          textColor: whiteColor,
                          onPress: () {})
                      .box
                      .width(context.screenHeight - 50)
                      .make(),
                  createNewAccount.text.color(fontGrey).make(),
                  5.heightBox,
                  Button(
                      color: golden,
                      title: signup,
                      textColor: whiteColor,
                      onPress: () {
                        Get.to(()=>const SignupScreen());
                      }).box.width(context.screenHeight - 50).make(),
                  10.heightBox,
                  loginWith.text.color(fontGrey).make(),
                  5.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: lightGrey,
                                child: Image.asset(
                                  socialIconList[index],
                                  width: 30,
                                ),
                              ),
                            )),
                  )
                ],
              )
                  .box
                  .white
                  .rounded
                  .shadowSm
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .make()
            ],
          ),
        ),
      ),
    );
  }
}
