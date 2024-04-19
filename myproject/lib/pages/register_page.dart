import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // TextEditingController _usernameController = TextEditingController();
  // TextEditingController _passwordController = TextEditingController();
  // bool _isLoading = false;
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("${snapshot.error}");
            return Scaffold(
                appBar: AppBar(title: const Text('Errorja')),
                body: Center(
                  child: Text("${snapshot.error}"),
                ));
          }
          return const Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        });
  }
    // return Scaffold(
    //     appBar: AppBar(
    //       title: const Text(''),
    //     ),
    //     body: ListView(padding: const EdgeInsets.all(8), children: <Widget>[
    //       Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: <Widget>[
    //           Container(
    //             alignment: Alignment.center, // use aligment
    //             child: Image.asset('assets/img/Logo.png',
    //                 height: 150, width: 200, fit: BoxFit.fill),
    //           ),
    //           Padding(
    //             padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
    //             child: const Text(
    //               "Register",
    //               style: TextStyle(
    //                 fontWeight: FontWeight.w700,
    //               ),
    //             ),
    //           ),
    //           Text("Create your new account"),
    //           Padding(
    //               padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
    //               child: TextField(
    //                 decoration: InputDecoration(
    //                     border: OutlineInputBorder(), hintText: 'Username '),
    //               )),
    //           Padding(
    //               padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
    //               child: TextField(
    //                 decoration: InputDecoration(
    //                     border: OutlineInputBorder(), hintText: 'Email '),
    //               )),
    //           Padding(
    //               padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
    //               child: TextField(
    //                 decoration: InputDecoration(
    //                     border: OutlineInputBorder(),
    //                     hintText: 'Phone Number '),
    //               )),
    //           Padding(
    //               padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
    //               child: TextField(
    //                 decoration: InputDecoration(
    //                     border: OutlineInputBorder(), hintText: 'Password '),
    //               )),
    //           ElevatedButton(
    //             onPressed: () {
    //               //navigate
    //               Navigator.push(context,
    //                   MaterialPageRoute(builder: (context) => LoginPage()));
    //             },
    //             style: ElevatedButton.styleFrom(
    //               minimumSize: Size(300.0, 50),
    //               backgroundColor: Color.fromARGB(255, 79, 9, 244),
    //             ),
    //             child: Text(
    //               'Sign Up',
    //               style: TextStyle(
    //                   color: Colors.white, fontWeight: FontWeight.w700),
    //             ),
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(top: 15.0),
    //             child: TextButton(
    //                 onPressed: () {
    //                   Navigator.push(context,
    //                       MaterialPageRoute(builder: (context) => LoginPage()));
    //                 },
    //                 child: Text("Already have an acoount? Login <=")),
    //           )
    //         ],
    //       ),
    //     ]));
  
}
