import 'package:flutter/material.dart';
import 'package:myproject/pages/register_page.dart';
import 'package:myproject/pages/middle_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // TextEditingController _usernameController = TextEditingController();
  // TextEditingController _passwordController = TextEditingController();
  // bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center, // use aligment
            child: Image.asset('assets/img/Logo.png',
                height: 150, width: 200, fit: BoxFit.fill),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
            child: Text(
              "Welcome Back",
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Text("Login to your account"),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Username '),
              )),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Password '),
              )),
          ElevatedButton(
            onPressed: () {
              //navigate
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MiddlePage()));
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(300.0, 50),
              backgroundColor: const Color.fromARGB(255, 79, 9, 244),
            ),
            child: const Text(
              'Login',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: TextButton(
                onPressed: () {
                  // navigate
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const RegisterPage()));
                },
                child: const Text("Don't have an account? Create here <=")),
          )
        ],
      ),
    );
  }
}
