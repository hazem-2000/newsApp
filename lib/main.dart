import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news/dio%20helper.dart';
import 'package:news/layout.dart';



void main() {

  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(

        ),

      ),
      home:NewsLayout(),
    );
  }
}

