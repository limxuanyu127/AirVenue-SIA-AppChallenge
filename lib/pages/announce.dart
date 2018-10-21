import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Announce extends StatefulWidget {
  const Announce({Key key, this.title}) : super(key: key);
  final String title;
  @override
  State<StatefulWidget> createState() {
    return AnnounceState();
  }
}


class AnnounceState extends State<Announce> {

  String userId;
  SharedPreferences prefs;
  String id;
  


  readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id").toString() ?? '';
    setState(() {
   });
   }
  
  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return new Container(
      child: new Container(
        child: new Card(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ListTile(
                  leading: Container(
                      height: 36.0,
                      width: 36.0,
                      padding: EdgeInsets.only(right: 12.0),
                      decoration: new BoxDecoration(
                          border: new Border(
                              right: new BorderSide(
                                  width: 1.0, color: Colors.black))),
                      child:
                          new Image(image: NetworkImage(document['iconURL']))),
                  title: new Text(document['header']),
                  subtitle: Row(children: <Widget>[
                    new Expanded(
                        child: new Text(document['announcement']), flex: 5),
                    new Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.0, top: 40.0),
                          child: new Text(
                            document['time'],
                            style: TextStyle(
                                fontSize: 9.0, fontStyle: FontStyle.italic),
                          ),
                        ),
                        flex: 1)
                  ]))
            ],
          ),
        ),
      ),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    readLocal();
    return new Container(
        color: Colors.grey[200],
        child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Expanded(
                  child: new Container(
                      padding: new EdgeInsets.only(top: 10.0),
                      child: new Card(
                          color: Color(0xFF1D4886),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              new ListTile(
                                  leading: Container(
                                    height: 56.0,
                                    width: 56.0,
                                    child: new Image.asset(
                                        'assets/logo_announce.png'),
                                  ),
                                  title: new Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: new Container(
                                        child: new Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 5.0),
                                            child: new Text(
                                              "SQ632  |  30 Sept",
                                              style: new TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Helvetica',
                                                  color: Colors.white),
                                            )),
                                        decoration: new BoxDecoration(
                                            border: new Border(
                                                bottom: new BorderSide(
                                                    width: 3.0,
                                                    color: new Color(
                                                        0xFFFCB130)))),
                                      )),
                                  subtitle: new Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        new Padding(
                                            padding: EdgeInsets.only(top: 5.0),
                                            child: new Text(
                                                "Singapore to Tokyo(HND)",
                                                style: new TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Helvetica',
                                                    color: Colors.white))),
                                        new Text("0800 - 1555",
                                            style: new TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Helvetica',
                                                color: Colors.white))
                                      ]))
                            ],
                          ))),
                  flex: 2),
              new Expanded(
                  child: new StreamBuilder(
                      stream: Firestore.instance
                          .collection('users').document(id).collection('announcements')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const Text('Loading...');
                        return new ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          padding: const EdgeInsets.only(top: 10.0),
                          itemBuilder: (context, index) => _buildListItem(
                              context, snapshot.data.documents[index]),
                        );
                      }),
                  flex: 6)
            ]));
  }
}
