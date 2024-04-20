import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myproject/models/list_item.dart';
import 'package:myproject/models/list_expense.dart';

class MoneyPage extends StatefulWidget {
  const MoneyPage({super.key});

  @override
  _MoneyPageState createState() => _MoneyPageState();
}

class _MoneyPageState extends State<MoneyPage> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('money').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 227, 219, 246),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text("Your Account                      "),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListExpense()));
                },
                child: const Text(
                  '+ Add Expense',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100.0, 50),
                  backgroundColor: const Color.fromARGB(255, 79, 9, 244),
                ),
              )
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 227, 219, 246),
        body: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child:
                        CircularProgressIndicator()); // Improved loading indicator
              }

              final documents = snapshot.data!.docs;
              return Column(
                  // Use Column to stack widgets vertically
                  children: [
                    // Add your custom widgets here (e.g., Text, ElevatedButton, etc.)

                    Expanded(
                      // Use Expanded to fill remaining space
                      child: ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          final doc = documents[index];
                          final data = doc.data()! as Map<String, dynamic>;
                          return ListTile(
                            title: Text(data['Name']),
                            subtitle: Text(data['Date']),
                            trailing: Text(data['Price'] + " baht"),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(15.0)),
                          );
                        },
                      ),
                    ),
                  ]);
            }));
  }
}
