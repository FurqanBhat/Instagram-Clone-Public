import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/screens/feed_screen.dart';
import 'package:instagram_clone_flutter/screens/profile_screen.dart';
import 'package:instagram_clone_flutter/screens/search_screen.dart';

import '../screens/add_post.dart';

const webScreenSize=600;
final homeScreenItems=[
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Text("liked"),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,)
];