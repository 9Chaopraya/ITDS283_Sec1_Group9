import 'package:myproject/models/get_items.dart';
import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myproject/models/list_item.dart';

String myDay = "";

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('items').snapshots();
  // late String myDay;
  // TextEditingController myDay = TextEditingController();
  // String myDay = "";
  // String myDay = "2024-04-20";

  final EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();
  
  // EasyInfiniteDateTimeLine d=
  // EasyInfiniteDateTimeLine(
  //   // controller = const _controller,
  //   firstDate: DateTime(2023),
  //   focusDate: _focusDate,
  //   lastDate: DateTime(2023, 12, 31),
  //   onDateChange: (selectedDate) {
  //     setState(() {
  //       _focusDate = selectedDate;
  //     });
  //   },
  // ),

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 227, 219, 246),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
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
          stream: FirebaseFirestore.instance.collection('items').snapshots(),
          builder: (context, snapshots) {
            if (snapshots.hasError) {
              return Text('Something went wrong');
            }

            if (snapshots.connectionState == ConnectionState.waiting) {
              return Center(
                  child:
                      CircularProgressIndicator()); // Improved loading indicator
            }
// myDay = selectedDate.toString();
            // myDay = myDay.substring(0, 11);
            // print("myDay " + myDay);
            return Column(
              // Use Column to stack widgets vertically
              children: [
                // Add your custom widgets here (e.g., Text, ElevatedButton, etc.)
                EasyInfiniteDateTimeLine(
                  firstDate: DateTime(2024),
                  focusDate: DateTime.now(),
                  lastDate: DateTime(2025),
                  controller: _controller,
                  onDateChange: (selectedDate) {
                    //
                    // _focusDate = selectedDate;

                    // myDay = selectedDate.toString();
                    // myDay = myDay.substring(0, 11);
                  },
                  // headerProps: const EasyHeaderProps(
                  //   monthPickerType: MonthPickerType.switcher,
                  //   dateFormatter: DateFormatter.fullDateDMY(),
                  // ),
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
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshots.data!.docs[index].data()
                          as Map<String, dynamic>;
                      // print("Hooray " + myDay.toString());

                      // return ListTile(
                      //   title: Text(data['Name']),
                      //   subtitle: Text(data['Date']),
                      // );
                      if (myDay.isEmpty) {
                        return ListTile(
                          title: Text(data['Name']),
                          subtitle: Text(data['Date']),
                        );
                      }

                      print("data " + data['Date']);
                      print("");
                      if (data['Date'].toString() == myDay.toString()) {
                        return ListTile(
                          title: Text(data['Name']),
                          subtitle: Text(data['Date']),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ],
            );
          },
        ));
  }
}
class EasyInfiniteDateTimeLineExample extends StatefulWidget {
  const EasyInfiniteDateTimeLineExample({super.key});

  @override
  State<EasyInfiniteDateTimeLineExample> createState() =>
      _EasyInfiniteDateTimeLineExampleState();
}

class _EasyInfiniteDateTimeLineExampleState
    extends State<EasyInfiniteDateTimeLineExample> {
  final EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();
  DateTime? _focusDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EasyInfiniteDateTimeLine(
          selectionMode: const SelectionMode.autoCenter(),
          controller: _controller,
          firstDate: DateTime(2024),
          focusDate: _focusDate,
          lastDate: DateTime(2024, 12, 31),
          onDateChange: (selectedDate) {
            setState(() {
              _focusDate = selectedDate;
            });
          },
        ),
        const SizedBox(
          height: 16,
        ),
        Column(
          children: [
            ElevatedButton(
              onPressed: () {
                _controller.animateToFocusDate();
              },
              child: const Text('Animate To Focus Date'),
            ),
            ElevatedButton(
              onPressed: () {
                _controller.animateToCurrentData();
              },
              child: const Text('Animate To Current Date'),
            ),
            ElevatedButton(
              onPressed: () {
                _controller.animateToDate(DateTime(2024, 6, 5));
              },
              child: const Text('Animate To 2024-6-5 '),
            ),
          ],
        ),
      ],
    );
  }
}

