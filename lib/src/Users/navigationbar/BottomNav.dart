import 'package:flutter/material.dart';
import 'package:global/src/Users/User%20profile/home/Profile.dart';

import '../welcome/Welcome.dart';






class btmnavigation extends StatefulWidget {
  @override
  _btmnavigationState createState() => _btmnavigationState();
}

class _btmnavigationState extends State<btmnavigation> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _getBodyWidget(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        iconSize: 30,

        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'person',
          ),

        ],
      ),
    );
  }

  _getBodyWidget() {
    switch (_currentIndex) {
      case 0:
        return Welcome();
      case 1:
        return ProfilePage();
      default:
        return Container();
    }
  }
}