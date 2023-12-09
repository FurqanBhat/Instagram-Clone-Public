import 'package:cloud_firestore/cloud_firestore.dart';

class Post{
  final String description;
  final String uid;
  final String username;
  final String postUrl;
  final String postId;
  final datePublished;
  final String profileImage;
  final likes;
  Post(
      {required this.description,
        required this.uid,
        required this.username,
        required this.postUrl,
        required this.postId,
        required this.datePublished,
        required this.profileImage,
        required this.likes,
      });
  Map<String, dynamic> toJson() {
    return {
      'description': description,
      "uid": uid,
      'username': username,
      'postUrl': postUrl,
      "postId": postId,
      "datePublished": datePublished,
      'profileImage':profileImage ,
      "likes": likes,
    };
  }

  static Post fromSnap(DocumentSnapshot snapshot) {
    return Post(
      description: snapshot.get('description'),
      uid: snapshot.get('uid'),
      username: snapshot.get('username'),
      postUrl: snapshot.get('postUrl'),
      postId: snapshot.get('postId'),
      datePublished: snapshot.get('datePublished'),
      profileImage: snapshot.get('profileImage'),
      likes: snapshot.get('datePublished'),
    );
  }

}
