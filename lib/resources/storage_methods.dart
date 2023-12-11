import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
class StorageMethods{
  final FirebaseStorage _storage=FirebaseStorage.instance;
  final FirebaseAuth _auth=FirebaseAuth.instance;

  Future<String> uploadToStorage(String childName, Uint8List file, bool isPost, String postId) async{
    Reference ref=await _storage.ref().child(childName).child(_auth.currentUser!.uid);
    if(isPost){
      ref=ref.child(postId);
    }
    UploadTask uploadTask=ref.putData(file);
    TaskSnapshot snapshot=await uploadTask;
    String downloadUrl=await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
  Future<void> deleteFromStorage(String postId) async{
    await _storage.ref().child('posts').child(_auth.currentUser!.uid).child(postId).delete();
  }

}