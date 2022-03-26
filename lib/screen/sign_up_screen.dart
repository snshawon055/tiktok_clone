import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/auth_controller/auth_control.dart';
import 'package:tiktok_clone/color/colors.dart';
import 'package:tiktok_clone/screen/login_screen.dart';
import 'package:tiktok_clone/widgets/text_input_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

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
              Stack(
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1565127023133-44e48eb1af93?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8c21va2luZ3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'),
                  ),
                  Positioned(
                    left: 80,
                    bottom: -10,
                    child: IconButton(
                      onPressed: () {
                        authController.picImg();
                      },
                      icon: Icon(
                        Icons.add_a_photo,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 24),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                child: TextInputField(
                  controller: usernameController,
                  icon: Icons.person,
                  labelText: 'username',
                  textInputType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(height: 24),
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
                  authController.registerUser(
                    usernameController.text,
                    emailController.text,
                    passwordController.text,
                    authController.profilePhoto,
                  );
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
                      "Register",
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
                  Text("Already have an account? ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Log in",
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
