import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone_flutter/models/post.dart';
import 'package:instagram_clone_flutter/resources/auth_methods.dart';
import 'package:instagram_clone_flutter/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> uploadPost(Uint8List file, String description, String uid, String username, String profileImage) async {
    String result = "Error Occured";
    try {
      String postUrl =
          await StorageMethods().uploadToStorage("posts", file, true);
      String postId = Uuid().v1();
      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          postUrl: postUrl,
          postId: postId,
          datePublished: DateTime.now(),
          profileImage: profileImage,
          likes: []);
      _firestore.collection('posts').doc(postId).set(post.toJson());
      result='Success';

    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  Future<void> likePost(String postId, String uid, List likes) async{
    if(likes.contains(uid)){
      await _firestore.collection('posts').doc(postId).update({
      'likes': FieldValue.arrayRemove([uid]),
      });
    }else{
      await _firestore.collection('posts').doc(postId).update({
        "likes" : FieldValue.arrayUnion([uid]),
      });
    }




 }
}
