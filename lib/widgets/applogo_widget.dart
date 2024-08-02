import 'package:ecom_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget applogoWidget() {
  return Image.asset(icAppLogo)
      .box
      .white
      .size(77, 99)
      .padding(const EdgeInsets.all(8))
      .rounded
      .make();
}
