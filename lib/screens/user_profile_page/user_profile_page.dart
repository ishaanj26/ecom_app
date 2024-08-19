import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moonlit/constants.dart';
import 'package:moonlit/screens/auth_screen/login_screen.dart';
import 'package:moonlit/widget/auth_widgets.dart';

import '../../models/user_model.dart';
import 'edit_profile_page.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User _user;
  late Color _randomColor;
  @override
  void initState() {
    super.initState();
    _randomColor = getRandomColor();
    _getUser();
  }

  void _getUser() async {
    _user = _auth.currentUser!;
  }

  Color getRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'My Profile',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                icon: const Icon(
                  Icons.edit,
                  size: 25,
                  color: Colors.black,
                ),
                onPressed: () {
                  // Edit profile button pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfilePage(),
                    ),
                  );
                },
              ),
            ),
          ],
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: Utils.fetchUserData(userId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    // Profile header
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: _user.photoURL != null
                                ? NetworkImage(
                                    _user.photoURL!,
                                  )
                                : null,
                            backgroundColor:
                                _user.photoURL == null ? _randomColor : null,
                            child: _user.photoURL == null
                                ? Text(
                                    _user.displayName![0].toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  )
                                : null,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            snapshot.data!.get('username'),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _user.email!,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Profile information
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          // Profile details
                          ListTile(
                              leading: const Icon(Icons.person),
                              title: const Text('Name'),
                              subtitle: Text(snapshot.data!.get('username'))),
                          ListTile(
                            leading: const Icon(Icons.email),
                            title: const Text('Email'),
                            subtitle: Text(
                              _user.email!,
                            ),
                          ),
                          ListTile(
                              leading: const Icon(Icons.phone),
                              title: const Text('Phone Number'),
                              subtitle:
                                  Text(snapshot.data!.get('phoneNumber'))),
                          ListTile(
                              leading: const Icon(Icons.location_on),
                              title: const Text('Address'),
                              //here
                              subtitle: Text(snapshot.data!.get('address'))),
                          // Order history
                          ListTile(
                            leading: const Icon(Icons.shopping_bag),
                            title: const Text('Order History'),
                            subtitle: const Text('View all orders'),
                            trailing: const Icon(Icons.arrow_forward),
                            onTap: () {
                              // Navigate to order history page
                            },
                          ),
                          // Payment methods
                          ListTile(
                            leading: const Icon(Icons.credit_card),
                            title: const Text('Payment Methods'),
                            subtitle: const Text('View all payment methods'),
                            trailing: const Icon(Icons.arrow_forward),
                            onTap: () {
                              // Navigate to payment methods page
                            },
                          ),
                          // Shipping addresses
                          ListTile(
                            leading: const Icon(Icons.location_on),
                            title: const Text('Shipping Addresses'),
                            subtitle: const Text('View all shipping addresses'),
                            trailing: const Icon(Icons.arrow_forward),
                            onTap: () {
                              // Navigate to shipping addresses page
                            },
                          ),
                          // Logout button
                          const SizedBox(height: 20),

                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: button(
                                color: kprimaryColor,
                                title: "Logout",
                                onPress: () {
                                  // Logout button pressed
                                  FirebaseAuth.instance.signOut();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                  );
                                  Fluttertoast.showToast(
                                      msg: "User successfully Signed out");
                                },
                                textColor: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
