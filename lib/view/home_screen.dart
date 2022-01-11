import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'details.dart';
import 'profile.dart';
import 'search.dart';

import 'home.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  var tabs = [];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    tabs = [GeolocatorWidget(), Search(), Profile()];
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      backgroundColor: Colors.white,
      body: Container(child:tabs[_currentIndex],),
      bottomNavigationBar: BottomNavigationBar(
          // backgroundColor: Color(0XFFFE99AC),
          // selectedItemColor:Color(0XFFFE99AC),

          backgroundColor:  Color(0xFF5B2789),
          selectedItemColor:Color(0xFF5B2789),
          unselectedItemColor: Colors.white,
          unselectedIconTheme: IconThemeData(color: Colors.white, opacity: 0.5),
          selectedIconTheme: IconThemeData(color:Color(0xFF5B2789), opacity: 0.5),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              label: '',
              activeIcon:Container(
                padding:EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(Icons.home)
              ),
              icon: Icon(Icons.home)
            ),
            BottomNavigationBarItem(
              label: '',
              activeIcon: Container(
                padding:EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(Icons.search)
              ),
              icon: Icon(Icons.search)
            ),
            BottomNavigationBarItem(
              label: '',
              activeIcon: Container(
                padding:EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child:Icon(Icons.person,color: Color(0xFF5B2789),)
              ),
              icon: Icon(Icons.person,)
            ),
          ]),
    );
  }
}
