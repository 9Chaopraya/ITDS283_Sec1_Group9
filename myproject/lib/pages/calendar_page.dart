import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myproject/models/list_item.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('items').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 227, 219, 246),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text("Calendar                                   "),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListItem()));
                },
                child: const Text(
                  '+ Add Task',
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
                    EasyDateTimeLine(
                      initialDate: DateTime.now(),
                      onDateChange: (selectedDate) {
                        print(selectedDate);
                      },
                      headerProps: const EasyHeaderProps(
                        monthPickerType: MonthPickerType.switcher,
                        dateFormatter: DateFormatter.fullDateDMY(),
                      ),
                      dayProps: const EasyDayProps(
                        dayStructure: DayStructure.dayStrDayNum,
                        activeDayStyle: DayStyle(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xff3371FF),
                                Color(0xff8426D6),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
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
