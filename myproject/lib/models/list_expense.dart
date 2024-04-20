import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myproject/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:myproject/pages/middle_page.dart';
import 'package:myproject/pages/money_page.dart';

class ListExpense extends StatefulWidget {
  const ListExpense({super.key});

  @override
  State<ListExpense> createState() => _ListExpenseState();
}

class _ListExpenseState extends State<ListExpense> {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _item = FirebaseFirestore.instance.collection('money');

  final TextEditingController myName = TextEditingController();

  final TextEditingController myDate = TextEditingController();

  final TextEditingController myPrice = TextEditingController();

  @override
  void dispose() {
    myName.dispose();
    myDate.dispose();
    myPrice.dispose();
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
                backgroundColor: Color.fromARGB(255, 89, 31, 224),
                title: Text(
                  "Create Expense",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: ListView(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 20.0)),
                        TextField(
                          controller: myName,
                          decoration: InputDecoration(
                            label: Text("Name"),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 20.0)),
                        TextField(
                          controller: myDate,
                          decoration: InputDecoration(
                            label: Text("Date"),
                            border: OutlineInputBorder(),
                          ),
                        ),Padding(padding: EdgeInsets.only(top: 20.0)),
                        TextField(
                          controller: myPrice,
                          decoration: InputDecoration(
                            label: Text("Price"),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 20.0)),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              await _item.add({
                                "Name": myName.text,
                                "Date": myDate.text,
                                "Price":myPrice.text
                              });

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Add Expense Complete",style: TextStyle(color: Colors.white),),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor:
                                    Color.fromARGB(255, 79, 9, 244),
                                elevation: 0,
                              ));

                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MiddlePage()));
                            } on FirebaseAuthException catch (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Error"),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor:
                                    Color.fromARGB(255, 79, 9, 244),
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
                      ],
                    ),
                  ]));
          // }
        });
  }
}
