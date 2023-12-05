import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_flutter/resources/auth_methods.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:instagram_clone_flutter/utils/utils.dart';
import 'package:instagram_clone_flutter/widgets/text_field_input.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  final TextEditingController _bioController=TextEditingController();
  final TextEditingController _usernameController=TextEditingController();
  Uint8List? _image;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
    super.dispose();
  }
  void selectImage() async{
    Uint8List image= await pickImage(ImageSource.camera);
    setState(() {
      _image=image;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 1,
              ),
              SvgPicture.asset(
                "ic_instagram.svg",
                color: primaryColor,
                height: 60,
              ),
              SizedBox(height: 0,),
              Stack(
                children: [
                  _image!=null ?
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: MemoryImage(_image!),
                  ):
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage('https://t4.ftcdn.net/jpg/02/15/84/43/240_F_215844325_ttX9YiIIyeaR7Ne6EaLLjMAmy4GvPC69.jpg'),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 70,
                    child: IconButton(
                      icon: Icon(Icons.add_a_photo),
                      onPressed: selectImage,
                    ),
                  )
                ],
              ),
              SizedBox(height: 24,),
              TextFieldInput(
                hintText: "Enter your username",
                textInputType: TextInputType.text,
                controller: _usernameController,
              ),
              SizedBox(height: 24,),
              TextFieldInput(
                hintText: "Enter Your Email",
                textInputType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              SizedBox(height: 24,),
              TextFieldInput(
                hintText: "Enter Your Password",
                textInputType: TextInputType.text,
                obscure: true,
                controller: _passwordController,
              ),
              SizedBox(height: 24,),
              TextFieldInput(
                hintText: "Enter bio",
                textInputType: TextInputType.text,
                controller: _bioController,
              ),
              SizedBox(height: 24,),
              InkWell(
                onTap: () async{
                  String res=await AuthMethods().register(email: _emailController.text, password: _passwordController.text, username: _usernameController.text, bio: _bioController.text, file: _image!);
                  print(res);
                  },
                child: Container(
                    width: double.infinity,
                    child: Text("Register"),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: blueColor,
                    )

                ),
              ),
              SizedBox(height: 14,),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Already have an account?"),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      child: Text("Log in", style: TextStyle(fontWeight: FontWeight.bold),),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),

                ],
              ),
              SizedBox(height: 8,)


            ],
          ),
        ),
      ),
    );
  }
}
