import 'package:flutter/material.dart';
import 'package:myproject/pages/register_page.dart';
import 'package:myproject/pages/middle_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // TextEditingController _usernameController = TextEditingController();
  // TextEditingController _passwordController = TextEditingController();
  // bool _isLoading = false;

 final Future<FirebaseApp> firebase = Firebase.initializeApp();



  final TextEditingController myEmail = TextEditingController();
 
  final TextEditingController myPassword = TextEditingController();

  @override
  void dispose() {

    myEmail.dispose();
    myPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
                appBar: AppBar(title: const Text('Errorja')),
                body: Center(
                  child: Text("${snapshot.error}"),
                ));
          }
          // if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
              body: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center, // use aligment
                          child: Image.asset('assets/img/Logo.png',
                              height: 150, width: 200, fit: BoxFit.fill),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 20.0),
                          child: Text(
                            "Welcome Back Login to your account",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 20.0)),
                        TextField(
                          controller: myEmail,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), hintText: 'Email '),
                        ),
                        Padding(padding: EdgeInsets.only(top: 20.0)),
                        TextField(
                          controller: myPassword,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Password '),
                        ),
                        Padding(padding: EdgeInsets.only(top: 20.0)),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: myEmail.text,
                                      password: myPassword.text);

                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MiddlePage()));
                            } on FirebaseAuthException catch (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Wrong Email or Password"),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Color.fromARGB(255, 79, 9, 244),
                                elevation: 0,
                              ));
                              print(e.code);
                              print(e.message);
                            }

                            //navigate
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(300.0, 50),
                            backgroundColor:
                                const Color.fromARGB(255, 79, 9, 244),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterPage()));
                              },
                              child: const Text(
                                  "Don't have an acoount? Sign Up <=")),
                        )
                      ],
                    ),
                  ]));
          // }
        });
  }
}
