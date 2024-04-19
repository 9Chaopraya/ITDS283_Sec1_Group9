import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:sec1_group9/pages/home_page.dart';
// import 'package:sec1_group9/pages/money_page.dart';
// import 'package:sec1_group9/pages/setting_page.dart';
// import 'package:sec1_group9/pages/calendar_page.dart';
import 'package:myproject/pages/login_page.dart';
// import 'package:sec1_group9/pages/register_page.dart';
// // import 'package:flutter_svg/flutter_svg.dart';


class MiddlePage extends StatefulWidget {
  const MiddlePage({super.key});

  @override
  State<MiddlePage> createState() => _MiddlePageState();
}

class _MiddlePageState extends State<MiddlePage> {
  int _page = 0;

  Widget bodyFunction() {
    switch (_page) {
      case 0:
        return const LoginPage();
        break;
      // case 1:
      //   return CalendarPage();
      //   break;
      // case 2:
      //   return MoneyPage();
      //   break;
      // case 3:
      //   return SettingPage();
      default:
        return const LoginPage();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // _getCategories();

    return Scaffold(
      appBar: AppBar(title: const Text('Hello User')),
      body: bodyFunction(),
      bottomNavigationBar: GNav(
          backgroundColor: const Color.fromARGB(255, 79, 9, 244),
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: const Color.fromARGB(255, 134, 104, 209),
          gap: 8,
          onTabChange: (index) {
            setState(() {
              _page = index;
            });
          },
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.calendar_month_outlined,
              text: 'Calendar',
            ),
            GButton(
              icon: Icons.money_off_rounded,
              text: 'Money',
            ),
            GButton(
              icon: Icons.settings,
              text: 'setting',
            ),
          ]),
    );
  }
}
