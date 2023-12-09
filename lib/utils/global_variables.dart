import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/screens/feed_screen.dart';

import '../screens/add_post.dart';

const webScreenSize=600;
const homeScreenItems=[
  FeedScreen(),
  Text("search"),
  AddPostScreen(),
  Text("liked"),
  Text("profile"),
];