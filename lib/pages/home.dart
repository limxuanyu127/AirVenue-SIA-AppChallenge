import 'package:flutter/material.dart';
import './match.dart' as match;
import './forum.dart' as forum;
import './announce.dart' as announce;
import './messenger_home.dart' as chat;
import './profiles.dart' as profiles;

class Home extends StatefulWidget {
  Home({this.onSignedOut});
  final VoidCallback onSignedOut;
  @override
  MyTabsState createState() => new MyTabsState();
}

class MyTabsState extends State<Home> with SingleTickerProviderStateMixin {
  final List<MyTabs> _tabs = [
    new MyTabs(title: "NotiFly"),
    new MyTabs(title: "KrisMatch"),
    new MyTabs(title: "KrisTalk"),
    new MyTabs(title: "KrisChat")
  ];

  MyTabs handler;
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 4, initialIndex: 0);
    handler = _tabs[1];
    controller.addListener(handleSelected);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void handleSelected() {
    setState(() {
      handler = _tabs[controller.index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text(handler.title),
            backgroundColor: Colors.white,
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: new Color(0xFFDAA520),
                  displayColor: new Color(0xFFDAA520),
                  fontFamily: 'Garamond',
                ),
            actions: <Widget>[
              new IconButton(
                icon: new Icon(Icons.account_circle),
                color: new Color(0xFFDAA520),
                tooltip: 'Profiles',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => profiles.Profiles()));
                },
              ),
            ]),
        bottomNavigationBar: new Material(
            color: Colors.white,
            child: new TabBar(
                controller: controller,
                tabs: <Tab>[
                  new Tab(icon: new Icon(Icons.announcement)),
                  new Tab(icon: new Icon(Icons.group)),
                  new Tab(icon: new Icon(Icons.forum)),
                  new Tab(icon: new Icon(Icons.message))
                ],
                indicatorColor: new Color(0xFFDAA520),
                labelColor: new Color(0xFFDAA520),
                unselectedLabelColor: Colors.grey)),
        body: new TabBarView(controller: controller, children: <Widget>[
          new announce.Announce(),
          new match.Match(),
          new forum.Forum(),
          new chat.MessengerHome()
        ]));
  }
}

class MyTabs {
  final String title;
  MyTabs({this.title});
}
