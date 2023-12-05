import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/models/user.dart';
import 'package:instagram_clone_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';
class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    User _user=Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: Center(
        child: Text("In Mobile Screen"+ _user.username),
      ),
    );
  }
}
