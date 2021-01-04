import 'package:flutter/material.dart';
import 'package:flutter_navbar_drawer/navbar.dart';
import 'package:flutter_navbar_drawer/tab_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.feed;
  @override
  Widget build(BuildContext context) {
    return NavBar(currentTab: _currentTab, onSelectedTab: _select);
  }

  void _select(TabItem tabItem) {
    setState(() {
      _currentTab = tabItem;
    });
  }
}
