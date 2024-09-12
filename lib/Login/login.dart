import 'dart:developer';

import 'package:demologin/Login/auth_service.dart';
import 'package:demologin/Login/signup_screen.dart';
import 'package:demologin/home/bottom_nav.dart';
import 'package:demologin/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  final TextEditingController _passwordController = TextEditingController();
  // final _auth = AuthService();

  final _email = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.fromLTRB(30, 0, 0, 30),
          constraints: const BoxConstraints.expand(),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Container(
                  width: 70,
                  height: 70,
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffd8d8d8),
                  ),
                  child: const FlutterLogo(),
                ),
              ),
              const Text(
                "Hello\nWellCome Back",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 20, 0),
                child: TextField(
                  controller: _email,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: "USERNAME",
                    labelStyle: TextStyle(color: Color(0xff888888), fontSize: 15),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: <Widget>[
                    TextFormField(
                      controller: _passwordController,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      decoration: const InputDecoration(
                        labelText: "PASSWORD",
                        labelStyle: TextStyle(color: Color(0xff888888), fontSize: 15),
                      ),
                      obscureText: _obscureText,
                    ),
                    GestureDetector(
                      onTap: () {
                        showPassWord();
                      },
                      child: Text(
                        _obscureText ? "Show" : "Hide",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // navigateScreen(context);
                      // _login();
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const BottomNav()));
                    },

                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.blueAccent;
                          }
                          return Colors.blueAccent;
                        },
                      ),
                    ),
                    child: const Text(
                      "SIGN IN",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  goToSignup(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const SignupScreen()),
  );

  goToHome(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const BottomNav()),
  );

  // _login() async {
  //   final user =
  //   await _auth.loginUserWithEmailAndPassword(_email.text, _passwordController.text);
  //
  //   if (user != null) {
  //     log("User Logged In");
  //     goToHome(context);
  //   }
  // }

  void showPassWord() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool _validatePassword(String value) {
    final RegExp regex = RegExp(r'^[a-zA-Z0-9]{6,}$');
    return regex.hasMatch(value);
  }

  void navigateScreen(BuildContext context) {
    final password = _passwordController.text;
    if (_validatePassword(password)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BottomNav()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid password')),
      );
    }
  }
}
