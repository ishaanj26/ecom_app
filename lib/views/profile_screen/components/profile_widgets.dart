import 'package:flutter/material.dart';

Widget ProfileInfo(BuildContext context, {required String title, required String count}) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Container(
        width: MediaQuery.of(context).size.width / 3.4,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              count!,
              style:const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              title!,
              style:const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        )),
  );
}
