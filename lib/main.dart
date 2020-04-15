import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peeklist/pages/my_profile.dart';
import 'package:peeklist/pages/notifications_page.dart';
import 'package:peeklist/pages/root.dart';
import 'package:peeklist/pages/create_task.dart';

import 'pages/search.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peek List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.red,
        accentColor: Colors.grey,
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.black.withOpacity(0),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
        accentColor: Colors.black,
      ),
      home: new Root(),
      routes: <String, WidgetBuilder>{
        '/search': (context) => Search(),
        '/myprofile': (context) => MyProfile(),
        '/createtask':(context) => CreateTask(),
        '/notifications': (context) => NotificationsPage(),
      },
    );
  }
}