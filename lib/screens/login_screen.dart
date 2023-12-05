import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone_flutter/resources/auth_methods.dart';
import 'package:instagram_clone_flutter/screens/register_screen.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:instagram_clone_flutter/widgets/text_field_input.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/utils.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  bool _isLoading=false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  void loginUser() async{
    setState(() {
      _isLoading=true;
    });
    String result= await AuthMethods().login(email: _emailController.text, password: _passwordController.text);
    setState(() {
      _isLoading=false;
    });
    print(result);
    if(result != "Success"){
      showSnackBar(result, context);
    }else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          )));
    }
  }
  void navigateToRegisterScreen(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>RegisterScreen()));
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
              InkWell(
                onTap: loginUser,
                child: Container(
                  width: double.infinity,
                  child: _isLoading ? Center(child: CircularProgressIndicator(color: primaryColor,),)
                  : Text("Log in"),
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
                      child: Text("Don't have an account?"),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: navigateToRegisterScreen,
                    child: Container(
                      child: Text("Sign up", style: TextStyle(fontWeight: FontWeight.bold),),
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
