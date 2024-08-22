import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moonlit/constants.dart';
import 'package:moonlit/models/user_model.dart';
import 'package:moonlit/screens/store_bottom_navbar.dart';
import 'package:moonlit/widget/auth_widgets.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late User _user;
  late String _displayName;
  late String _address;
  bool _isUpdating = false;
  late Color _randomColor;
  bool _isUserDataFetched = false;

  @override
  void initState() {
    super.initState();
    _randomColor = getRandomColor();
    _getUser();
  }

  Future<void> _getUser() async {
    _user = _auth.currentUser!;
    final userData = await Utils.fetchUserData(_user.uid);
    setState(() {
      _displayName = userData['username'] ?? '';
      _address = userData['address'] ?? '';
      _isUserDataFetched = true;
    });
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: bgColor,
          title: const Text('Edit Profile'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
        ),
        body: _isUserDataFetched
            ? Container(
                height: MediaQuery.of(context).size.height,
                color: kcontentColor,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
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
                          const SizedBox(height: 20),
                          TextFormField(
                            initialValue: _displayName,
                            decoration: const InputDecoration(
                              labelText: 'Display Name',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your display name';
                              }
                              return null;
                            },
                            onSaved: (value) => _displayName = value!,
                          ),
                          const SizedBox(height: 20),
                          const SizedBox(height: 20),
                          TextFormField(
                            initialValue: _address,
                            decoration: const InputDecoration(
                              labelText: 'Address',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            },
                            onSaved: (value) => _address = value!,
                          ),
                          const SizedBox(height: 20),
                          _isUpdating
                              ? loading()
                              : SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  // or any other proportion
                                  child: button(
                                    color: buttonColor,
                                    title: "Save Changes",
                                    fontSize: 13,
                                    onPress: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        _updateUserProfile();
                                      }
                                    },
                                    textColor: Colors.white,
                                  ),
                                ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : loading());
  }

  Future<void> _updateUserProfile() async {
    try {
      setState(() {
        _isUpdating = true;
      });

      _createData(UserModel(
        username: _displayName,
        address: _address,
      ));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavBar(),
        ),
      );
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error updating profile: $e');
    } finally {
      setState(() {
        _isUpdating = false;
      });
    }
  }

  void _createData(UserModel userModel) {
    final usercollection = FirebaseFirestore.instance.collection("users");
    String id = _auth.currentUser!.uid;

    usercollection.doc(id).update({
      'username': userModel.username,
      'address': userModel.address,
    });
  }
}
