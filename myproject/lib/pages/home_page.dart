import 'package:myproject/models/get_items.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('items').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ));
  }
}
