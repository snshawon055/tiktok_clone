import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/auth_controller/auth_control.dart';
import 'package:tiktok_clone/color/colors.dart';
import 'package:tiktok_clone/screen/sign_up_screen.dart';
import 'package:tiktok_clone/widgets/text_input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Text(
                "TikTok",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                "Log in",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 25),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                child: TextInputField(
                  controller: emailController,
                  icon: Icons.email,
                  labelText: 'Email',
                  textInputType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(height: 24),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                child: TextInputField(
                  controller: passwordController,
                  icon: Icons.lock,
                  labelText: 'Password',
                  textInputType: TextInputType.text,
                  isPass: true,
                ),
              ),
              SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  authController.loginUser(
                      emailController.text, passwordController.text);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(child: Container(), flex: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Don't have an account? ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: buttonColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
