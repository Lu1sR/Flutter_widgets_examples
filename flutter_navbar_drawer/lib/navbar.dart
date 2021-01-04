import 'package:flutter/material.dart';
import 'package:flutter_navbar_drawer/tab_item.dart';

class NavBar extends StatelessWidget {
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectedTab;

  const NavBar(
      {Key key, @required this.currentTab, @required this.onSelectedTab})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TabItem.values.length,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            FlatButton(
              child: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {},
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          child: Icon(
            Icons.add,
          ),
          onPressed: () => {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Container(
              child: Center(child: Text('Home')),
            ),
            Container(
              child: Center(child: Text('Profile')),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              boxShadow: [
                BoxShadow(
                  color: Colors.indigo[100],
                  blurRadius: 3,
                  offset: Offset(0, -3),
                ),
              ],
            ),
            child: TabBar(
              indicator: BoxDecoration(),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.indigo,
              tabs: <Widget>[
                _buildItem(TabItem.feed),
                _buildItem(TabItem.info),
              ],
              onTap: (index) => onSelectedTab(TabItem.values[index]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(TabItem tabItem) {
    final itemData = TabItemData.allTabs[tabItem];
    if (currentTab == tabItem) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(itemData.icon, color: Colors.indigo),
          Container(
            margin: EdgeInsets.only(top: 4.0),
            decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: new BorderRadius.all(Radius.circular(2.5))),
            height: 5,
            width: 5,
          )
        ],
      );
    } else {
      return Icon(
        itemData.iconOutline,
        color: Colors.grey,
      );
    }
  }
}
