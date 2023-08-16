import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Email",
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "Password", suffixIcon: Icon(Icons.remove_red_eye_sharp)),
            ),
            const SizedBox(height: 40),
            InkWell(
              onTap: () {
                signUpWithApi(emailController.text.toString().trim(), passwordController.text.toString().trim());
              },
              child: Container(
                height: 50,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text("Sign Up", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  void signUpWithApi(String email, String password) async {
    try {
      var response = await http.post(
        Uri.parse("https://reqres.in/api/register"),
        body: {"email": email, "password": password},
      );
      if (response.statusCode == 200) {
        print("account created successfully");
        var data = jsonDecode(response.body.toString());
        print(data);
      } else {
        print("failed");
      }

    } catch (e) {}
  }
}
