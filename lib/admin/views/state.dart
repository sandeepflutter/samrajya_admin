import 'package:samrajya_admin/admin/views/Electrical.dart';
import 'package:samrajya_admin/admin/views/Industrial.dart';
import 'package:samrajya_admin/admin/views/Mech.dart';
import 'package:samrajya_admin/admin/views/Offer.dart';
import 'package:samrajya_admin/admin/views/Slide.dart';
import 'package:flutter/material.dart';

class Rules extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Samrajya',
          theme: ThemeData(
            primaryColor: Colors.teal,
          ),
          home: HomeScreen()
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
          appBar: TabBar(
            indicatorColor: Colors.black,
            tabs: <Widget>[
              Icon(Icons.battery_charging_full),
              Icon(Icons.hardware),
              Icon(Icons.apartment),
              Icon(Icons.add_shopping_cart),
              Icon(Icons.settings_ethernet),
            ],
          ),
      body: TabBarView(children: [
        Electrical(),
        Mech(),
        Industrial(),
        Slide(),
        Offer()
      ]),
    );
  }
}

