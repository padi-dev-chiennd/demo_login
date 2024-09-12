import 'dart:developer';

import 'package:demologin/Login/auth_service.dart';
import 'package:demologin/Login/login.dart';
import 'package:demologin/home/home_screen.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = AuthService();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const Spacer(),
            const Text("Signup",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Enter Name"
              ),
              controller: _name,
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                  hintText: "Enter Email"
              ),
              controller: _email,
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                  hintText: "Password"
              ),
              obscureText: false,
              controller: _password,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _signup, child: const Text(
                "SIGN IN",
                style: TextStyle(color: Colors.white))),
            const SizedBox(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Already have an account? "),
              InkWell(
                onTap: () => goToLogin(context),
                child: const Text("Login", style: TextStyle(color: Colors.red)),
              )
            ]),
            const Spacer()
          ],
        ),
      ),
    );
  }

  goToLogin(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );

  goToHome(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );

  _signup() async {
    final user =
        await _auth.createUserWithEmailAndPassword(_email.text, _password.text);
    if (user != null) {
      log("User Created Succesfully");
      goToHome(context);
    }
  }
}
