import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String bio;
  final String uid;
  final String email;
  final String photoUrl;
  final List followers;
  final List following;
  User(
      {required this.uid,
      required this.username,
      required this.email,
      required this.bio,
      required this.followers,
      required this.following,
      required this.photoUrl});
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      "bio": bio,
      "uid": uid,
      'email': email,
      'photoUrl': photoUrl,
      'followers': followers,
      "following": following,
    };
  }

  static User fromSnap(DocumentSnapshot snapshot) {
    return User(
      username: snapshot.get('username'),
      bio: snapshot.get('bio'),
      uid: snapshot.get('uid'),
      email: snapshot.get('email'),
      photoUrl: snapshot.get('photoUrl'),
      followers: snapshot.get('followers'),
      following: snapshot.get('following'),
    );
  }
}
