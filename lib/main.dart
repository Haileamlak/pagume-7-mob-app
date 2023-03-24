import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:project1/routes/Fastings.dart';
import 'package:project1/routes/HomePage.dart';
import 'package:project1/routes/calendar.dart';
import 'package:project1/routes/Holidays.dart';
import 'package:project1/routes/DateConvertor.dart';
import 'package:project1/routes/NumberConvertor.dart';
import 'package:project1/routes/FindTheDay.dart';
import 'package:project1/routes/BasicCalculations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pagume 7',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage();
  @override
  State<StatefulWidget> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 229, 137, 10),
          title: const Text("Pagume ፯"),
          // actions: const [Icon(Icons.calendar_month)],
          bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: Colors.blue,
              tabs: const [
                Tab(text: "Home"),
                Tab(text: "Calendar"),
                Tab(text: "Holidays"),
                Tab(text: "Fasings"),
                Tab(text: "Date Convertor"),
                Tab(text: "Number Convertor"),
                Tab(text: "Find the Day"),
                Tab(text: "Basic Calculations")
              ])),
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(
                  // color: Colors.lightBlue,
                  ),
              child: Center(
                child: ImageIcon(
                  AssetImage("images/white-logo.png"),
                  color: Color.fromARGB(255, 229, 137, 10),
                  size: 64,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings_outlined),
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 16),
              ),
            ),
            // ListTile(
            //   selectedTileColor: Colors.lightBlue,
            //   leading: Icon(Icons.info),
            //   title: Text('About Us', style: TextStyle(fontSize: 16)),
            // ),
            AboutListTile(
              icon: Icon(Icons.info_outline),
              applicationName: "Pagume 7",
              applicationVersion: "1.0",
              applicationIcon: ImageIcon(
                AssetImage("images/white-logo.png"),
                color: Color.fromARGB(255, 229, 137, 10),
                size: 32,
              ),
              applicationLegalese: "\u{a9} 2015 E.C Haileamlak Belachew",
            )
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: const [
        HomePage(),
        Calendar(),
        Holidays(),
        Fastings(),
        DateConvertor(),
        NumberConvertor(),
        FindTheDay(),
        BasicCalculations()
      ]),
    );
  }
}
