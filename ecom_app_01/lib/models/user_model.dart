import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? username;
  final String? address;
  final String? id;
  final String? phoneNumber;
  UserModel({this.username, this.address, this.id, this.phoneNumber});

  static UserModel fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserModel(
      username: snapshot['username'],
      address: snapshot['adress'],
      id: snapshot['id'],
      phoneNumber: snapshot['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "address": address,
      "id": id,
      "phoneNumber": phoneNumber,
    };
  }
}

class Utils {
  static Future<DocumentSnapshot> fetchUserData(String userId) async {
    final firestore = FirebaseFirestore.instance;
    final docRef = firestore.collection('users').doc(userId);
    final docSnap = await docRef.get();
    return docSnap;
  }
}
