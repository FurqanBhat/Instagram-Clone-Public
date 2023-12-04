import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
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
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
    super.dispose();
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
                flex: 2,
              ),
              SvgPicture.asset(
                "ic_instagram.svg",
                color: primaryColor,
                height: 64,
              ),
              SizedBox(height: 64,),
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
                onTap: (){},
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
