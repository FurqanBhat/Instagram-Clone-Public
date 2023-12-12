import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/models/user.dart' as model;
import 'package:instagram_clone_flutter/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async{
    User currUser=await _auth.currentUser!;
    DocumentSnapshot _snapshot= await _firestore.collection('users').doc(currUser.uid).get();
    return model.User.fromSnap(_snapshot);
  }


  Future<String> register({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String result = "Some error occured";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty &&
          file != null) {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);
        String photoUrl = await StorageMethods()
            .uploadToStorage("profilePictures", file, false, '');
        model.User user=model.User(
          username: username,
          bio: bio,
          uid: userCredential.user!.uid,
          email: email,
          photoUrl: photoUrl,
          followers: [],
          following: [],
        );
        await _firestore.collection("users").doc(userCredential.user!.uid).set(user.toJson());

        result = "Success";
      }
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  Future<String> login({required String email, required String password}) async{
    String result="Some error occured";
    try{
      if(email.isNotEmpty && password.isNotEmpty){
        UserCredential userCredential= await _auth
            .signInWithEmailAndPassword(email: email, password: password);
      }else{
        result="Please enter all the fields.";
      }

      result="Success";
    }catch(e){
      result=e.toString();
    }
    return result;
  }
  Future<void> signOut() async{
    await _auth.signOut();
  }
}
