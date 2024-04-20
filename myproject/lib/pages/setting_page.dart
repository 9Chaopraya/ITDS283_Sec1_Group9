import 'package:flutter/material.dart';
import 'package:myproject/pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myproject/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // TextEditingController _usernameController = TextEditingController();
  // TextEditingController _passwordController = TextEditingController();
  // bool _isLoading = false;
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  final TextEditingController myChangePassword = TextEditingController();

  @override
  void dispose() {
    myChangePassword.dispose();
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
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: const Color.fromARGB(255, 79, 9, 244),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    Text(
                      "   Settings",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 60)),
                  TextField(
                    controller: myChangePassword,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Put your Email to change password '),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.sendPasswordResetEmail(
                            email: myChangePassword.text);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            "Check your Email",
                            style: TextStyle(color: Colors.white),
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Color.fromARGB(255, 79, 9, 244),
                          elevation: 0,
                        ));
                      } on FirebaseAuthException catch (e) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            "Something went wrong!!!",
                            style: TextStyle(color: Colors.white),
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Color.fromARGB(255, 79, 9, 244),
                          elevation: 0,
                        ));
                        print(e.message);
                      }

                      //navigate
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300.0, 50),
                      backgroundColor: const Color.fromARGB(255, 79, 9, 244),
                    ),
                    child: const Text(
                      'Apply Change',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 240)),
                  TextButton(
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.signOut();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            "Logout Successfully",
                            style: TextStyle(color: Colors.white),
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Color.fromARGB(255, 79, 9, 244),
                          elevation: 0,
                        ));

                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      } on FirebaseAuthException catch (e) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            "Something went wrong!!!",
                            style: TextStyle(color: Colors.white),
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Color.fromARGB(255, 79, 9, 244),
                          elevation: 0,
                        ));
                        print(e.message);
                      }

                      //navigate
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      side: BorderSide(color: Colors.white),
                      minimumSize: const Size(300.0, 50),
                      backgroundColor: Color.fromARGB(255, 87, 83, 202),
                    ),
                    child: const Text(
                      'Logout here <=',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ));
          // }
        });
  }
}
