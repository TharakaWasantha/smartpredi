import 'package:agrogenicprl/screens/dashboard.dart';
import 'package:agrogenicprl/authentication/home_screen.dart';
import 'package:agrogenicprl/screens/airventilation_screen.dart';
import 'package:flutter/material.dart';

class bottomnavi extends StatefulWidget {
  const bottomnavi({Key? key}) : super(key: key);

  @override
  State<bottomnavi> createState() => _bottomnaviState();
}

class _bottomnaviState extends State<bottomnavi> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    Airventilation(),
    Home(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.teal,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.tealAccent,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Home',
            activeIcon: Icon(
              Icons.home,
              color: Colors.purple,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.supervised_user_circle,
              color: Colors.black,
            ),
            label: 'Profile',
            activeIcon: Icon(
              Icons.supervised_user_circle,
              color: Colors.purple,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            label: 'Setting',
            activeIcon: Icon(
              Icons.settings,
              color: Colors.purple,
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );

  }
}
