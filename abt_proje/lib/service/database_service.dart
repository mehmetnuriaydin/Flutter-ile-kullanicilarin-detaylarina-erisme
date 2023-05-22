import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //reference for our collections
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");

  //saving the userdata
  Future savingUserData(String fullName, String email, String gender, String category) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "gender": gender,
      "category": category,
      "uid": uid,
    });
  }

  // getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot = await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
}
