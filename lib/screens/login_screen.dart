import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:practices/api_services/api_service.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ApiService apiService = ApiService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String message = '';

  void loginFun() async {
    setState(() {
      isLoading = true;
    });
    final responses =
        await apiService.login(emailController.text, passwordController.text);
    setState(() {
      isLoading = false;
    });

    if (responses != null) {
      log('You have successfully logged in');
      Navigator.push(
          context, MaterialPageRoute(builder: (ctx) => HomeScreen()));
    } else {
      log('Invalid Credentials');
      message = 'Invalid Credentials';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Enter your email'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Enter your password',
                  ),
                  style: TextStyle(),
                  obscureText: true,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  message,
                  style: TextStyle(color: Colors.red),
                ),
                SizedBox(
                  height: 10,
                ),
                (isLoading == true)
                    ? CircularProgressIndicator()
                    : ElevatedButton(onPressed: loginFun, child: Text('Login'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
