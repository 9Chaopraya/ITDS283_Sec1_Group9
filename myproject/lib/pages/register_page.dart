import 'package:flutter/material.dart';
import 'package:myproject/pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myproject/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                            "Register",
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
                                  .createUserWithEmailAndPassword(
                                      email: myEmail.text,
                                      password: myPassword.text);

                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()));
                            } on FirebaseAuthException catch (e) {
                              

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("This Email has already sign up or The password is not be at least 6 characters "),
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
                            'Sign Up',
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
                                            const LoginPage()));
                              },
                              child: const Text(
                                  "Already have an acoount? Login <=")),
                        )
                      ],
                    ),
                  ]));
          // }
        });
  }
}
