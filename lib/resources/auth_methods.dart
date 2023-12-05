import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/resources/storage_methods.dart';
class AuthMethods{
  final FirebaseAuth _auth= FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  Future<String> register({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String result="Some Error  Occured";
    try{
      if(email.isNotEmpty && password.isNotEmpty && username.isNotEmpty && bio.isNotEmpty && file!=null){
      UserCredential userCredential=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      String photoUrl=await StorageMethods().uploadToStorage("profilePictures", file, false);
      await _firestore.collection("users").doc(userCredential.user!.uid).set({
        'username' : username,
        "bio" : bio,
        "uid" : userCredential.user!.uid,
        'email' : email,
        'photoUrl': photoUrl,
        'followers' : [],
        "following" : [],
      });

      result="Success";
      }
    }
    catch(e){
      result=e.toString();
    }
    return result;



  }
}