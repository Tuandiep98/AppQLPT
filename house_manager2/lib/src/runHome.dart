import 'package:flutter/material.dart';
import 'package:house_manager2/src/models/user.dart';
import 'package:house_manager2/src/resource/Dashboard_page.dart';
import 'package:house_manager2/src/resource/Home_page.dart';
import 'package:house_manager2/src/resource/House_items_page.dart';
import 'package:house_manager2/src/resource/House_page.dart';
import 'package:house_manager2/src/resource/Me_page.dart';
import 'package:house_manager2/src/resource/Product_page.dart';

class RunHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RunHomeStatefulWidget(),
    );
  }
}

class RunHomeStatefulWidget extends StatefulWidget {
  RunHomeStatefulWidget({Key key}) : super(key: key);
  @override
  _RunHomeState createState() => _RunHomeState();
}

class _RunHomeState extends State<RunHomeStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    HousePage(),
    DashboardPage(),
    MePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              backgroundColor: Colors.lightBlue
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('House'),
              backgroundColor: Colors.lightBlue
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            title: Text('Dashboard'),
              backgroundColor: Colors.lightBlue
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Me'),
            backgroundColor: Colors.lightBlue
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
