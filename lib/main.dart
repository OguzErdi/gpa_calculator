import 'package:flutter/material.dart';
import 'app/gpa_home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GPA Calculator',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.white,
        accentColor: Color(0xFF00e0e7),
        backgroundColor: Color(0xFF525660),
        scaffoldBackgroundColor:Color(0xFF2a3036),
        textTheme: TextTheme(
          headline6: TextStyle(fontSize: 20.0),
          headline4: TextStyle(fontSize: 20.0, color: Color(0xFF00e0e7)),
          bodyText1: TextStyle(fontSize: 18.0),
          bodyText2: TextStyle(fontSize: 16.0),
        ),
      ),
      home: GPAHomePage(),
    );
  }
}
