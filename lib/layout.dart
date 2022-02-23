import 'package:flutter/material.dart';
import 'package:news/Bus.dart';
import 'package:news/scinenc%20screen.dart';
import 'package:news/search%20screen.dart';
import 'package:news/search.dart';
import 'package:news/seting%20screen.dart';
import 'package:news/sport%20screen.dart';

import 'dio helper.dart';

class NewsLayout extends StatefulWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  _NewsLayoutState createState() => _NewsLayoutState();
}

class _NewsLayoutState extends State<NewsLayout> {
  var current = 0;



  void change(int index) {
    setState(() {



      current = index;
    });
  }

  var x;

  List<Widget> screen = [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
    SearchScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(
          "news",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor:Color.fromARGB(255, 214, 77, 96),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 214, 77, 96),
                  Color.fromARGB(0, 214, 77, 96),
                ]
              )
            ),
          ),
          screen[current],
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(color: Colors.red),
        selectedItemColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        currentIndex: current,
        onTap: (index) {
          change(index);
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports),
            label: 'Sport',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.science),
            label: 'Science',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
