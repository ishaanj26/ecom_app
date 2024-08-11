import 'package:ecommerce_app/views/profile_screen/components/profile_widgets.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> buttonInfo = [
      "My Orders",
      "My WishList",
      "Messages",
      "Refund Request",
      "Earned Points",
    ];
    List<IconData> buttonInfoIcons = [
      Icons.menu,
      Icons.menu,
      Icons.message,
      Icons.money_off_csred,
      Icons.emoji_events,
    ];

    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          //edit profile button
          const Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.edit,
                color: Colors.black,
              )),
          //user details section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipOval(
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dummy User",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Customer@gmail.com",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Text(
                  "Log Out",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ProfileInfo(context, title: "in Your cart", count: "00"),
              ProfileInfo(context, title: "in Your wishlist", count: "32"),
              ProfileInfo(context, title: "your orders", count: "675"),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  // Add this
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: Colors.grey.shade500,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.grey.shade50,
                    );
                  },
                  itemCount: buttonInfo.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(buttonInfoIcons[index]),
                      title: Text(buttonInfo[index]),
                    );
                  }),
            ),
          )
        ]),
      )),
    );
  }
}
