import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Forum extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ForumState();
  }
}

class ForumState extends State<Forum> {
  void _info() {
    infoDialog(context).then((bool value) {});
  }

  Future<bool> infoDialog(BuildContext context) {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("Forum Information"),
            content: new Text(
                "Scroll through the list of forums to join a discussion that you are interested!" +
                    " Once you find a forum that you are interested in, simply press 'Join Forum' to be added to the group!"),
            actions: <Widget>[
              new FlatButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Colors.grey[200],
        child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Expanded(
                  child: new Container(
                      padding: new EdgeInsets.only(top: 10.0),
                      child: new Card(
                          child: new Row(
                        children: <Widget>[
                          new Expanded(
                              child: new Padding(
                                  padding: new EdgeInsets.all(8.0),
                                  child: new Text('Find your interest!',
                                      style: new TextStyle(
                                          fontFamily: 'Raleway',
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold))),
                              flex: 4),
                          new Expanded(
                            child: new IconButton(
                                icon: new Icon(Icons.info),
                                onPressed: () {
                                  _info();
                                }),
                          )
                        ],
                      ))),
                  flex: 1),
              new Expanded(
                  child: new Stack(
                    children: <Widget>[
                      BuildForums(context),
                      new Align(
                        alignment: FractionalOffset(0.9, 0.95),
                        child: new FloatingActionButton(
                          child: Icon(Icons.add),
                          onPressed: () {
                            _createForum(context);
                          },
                          elevation: 5.0,
                          backgroundColor: Color(0xFF1D4886),
                        ),
                      ),
                    ],
                  ),
                  flex: 5)
            ]));
  }
}

Future _createForum(BuildContext context) async {
  String forumName;
  String forumDesc;
  await showDialog(
    context: context,
    builder: (BuildContext context) => new Dialog(
          child: new SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                new Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
                  child: Text("Create a New Forum",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      )),
                  color: Color(0xFF1D4886),
                ),
                new Container(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Container(
                        padding: EdgeInsets.all(10.0),
                        child: FloatingActionButton(
                            onPressed: () {},
                            backgroundColor: Color(0xFF1D4886),
                            child: Icon(Icons.add_a_photo)),
                      ),
                      new Container(
                        padding: EdgeInsets.all(10.0),
                        child: new Text("Add a Picture"),
                      )
                    ],
                  ),
                ),
                new Container(
                  padding: EdgeInsets.all(5.0),
                  child: new Card(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            "Forum Name:",
                            style: TextStyle(
                              color: Color(0xFF1D4886),
                            ),
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.all(5.0),
                          child: new TextField(
                            onChanged: (String name) {
                              forumName = name;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF1D4886), width: 0.5)),
                            ),
                            maxLines: 2,
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            "Forum Description:",
                            style: TextStyle(
                              color: Color(0xFF1D4886),
                            ),
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.all(5.0),
                          child: new TextField(
                            onChanged: (String desc) {
                              forumDesc = desc;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF1D4886), width: 0.5))),
                            maxLines: 6,
                          ),
                        ),
                        new Align(
                            alignment: Alignment.bottomRight,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                new FlatButton(
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                    child: Text("BACK",
                                        style: TextStyle(
                                            color: Color(0xFF1D4886)))),
                                new FlatButton(
                                    onPressed: () {
                                      print(forumName);
                                      print(forumDesc);
                                      if (forumName == null ||
                                          forumDesc == null) {
                                        showDialog(
                                          context: context,
                                          child: new AlertDialog(
                                            content: Text(
                                                "Please fill in required fields"),
                                            title:
                                                Text("Incomplete information"),
                                          ),
                                        );
                                      } else {
                                        DocumentReference documentReference =
                                            Firestore.instance
                                                .collection('forums')
                                                .document(forumName);
                                        Map<String, String> forumData =
                                            <String, String>{
                                          "name": forumName,
                                          "description": forumDesc,
                                          "imageURL":
                                              "https://d30zbujsp7ao6j.cloudfront.net/wp-content/uploads/2017/07/unnamed.png",
                                          "count": "1",
                                        };
                                        documentReference
                                            .setData(forumData, merge: true)
                                            .whenComplete(() {
                                          print("forum created");
                                          //print(count.toString());
                                          //print(prevMessage);
                                        }).catchError((e) => print(e));
                                      }
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                    child: Text("CREATE FORUM",
                                        style: TextStyle(
                                            color: Color(0xFF1D4886)))),
                              ],
                            )),
                      ],
                    ),
                    color: Colors.grey[50],
                    elevation: 3.0,
                  ),
                ),
              ],
            ),
          ),
        ),
  );
}

class BuildForums extends StatefulWidget {
  BuildContext context;
  BuildForums(this.context);
  @override
  BuildForumsState createState() => BuildForumsState(context);
}

class BuildForumsState extends State<BuildForums> {
  BuildContext context;
  BuildForumsState(this.context);
  int _activeMeterIndex;

  SharedPreferences prefs;
  String id;
  readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id").toString() ?? '';
    setState(() {});
  }

  void _confirm() {
    confirmDialog(context).then((bool value) {});
  }

  Future<bool> confirmDialog(BuildContext context) {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("Joined Forum"),
            content: new Text("This forum has been added to your chats!"),
            actions: <Widget>[
              new FlatButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    readLocal();
    return Container(
      child: new StreamBuilder(
          stream: Firestore.instance.collection('forums').orderBy('count', descending: true).snapshots(),
    return Container(
      child: new StreamBuilder(
          stream: Firestore.instance.collection('forums').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Loading...');
            return snapshot.data != null
                ? new ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 70.0),
                    itemBuilder: (BuildContext context, int i) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        elevation: 3.0,
                        margin:
                            const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
                        child: new ExpansionPanelList(
                          expansionCallback: (int index, bool status) {
                            setState(() {
                              _activeMeterIndex =
                                  _activeMeterIndex == i ? null : i;
                            });
                          },
                          children: [
                            new ExpansionPanel(
                              isExpanded: _activeMeterIndex == i,
                              headerBuilder: (BuildContext context,
                                      bool isExpanded) =>
                                  new Container(
                                      padding: EdgeInsets.fromLTRB(
                                          5.0, 5.0, 0.0, 5.0),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: new NetworkImage(
                                              snapshot.data.documents[i]
                                                  ['imageURL']),
                                          radius: 32.0,
                                        ),
                                        title: Container(
                                          padding: EdgeInsets.only(bottom: 6.0),
                                          child: Text(
                                              snapshot.data.documents[i]
                                                  ['name'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF1D4886),
                                                fontSize: 15.0,
                                              ),
                                              overflow: TextOverflow.clip),
                                        ),
                                        subtitle: Text(snapshot
                                                .data.documents[i]['count'] +
                                            " members"),
                                      )),
                              body: new Card(
                                  elevation: 4.0,
                                  color: Colors.grey[50],
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  margin: EdgeInsets.fromLTRB(
                                      20.0, 0.0, 20.0, 20.0),
                                  child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(bottom: 5.0),
                                          child: Text(
                                            "Forum Description",
                                            style: TextStyle(
                                              color: Color(0xFF1D4886),
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          snapshot.data.documents[i]
                                              ['description'],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            FlatButton(
                                              onPressed: () {
                                                _confirm();
                                                String forumId = snapshot
                                                    .data.documents[i]['name'];
                                                DocumentReference
                                                    documentReference =
                                                    Firestore.instance
                                                        .collection('users')
                                                        .document(id)
                                                        .collection('chatUsers')
                                                        .document(forumId);
                                                Map<String, String> forumsData =
                                                    <String, String>{
                                                  "displayName": snapshot.data
                                                      .documents[i]['name'],
                                                  "id": snapshot.data
                                                      .documents[i]['name'],
                                                  "photoURL": snapshot.data
                                                      .documents[i]['imageURL'],
                                                  "aboutMe":
                                                      "Join in the discussion here!",
                                                  "type": "forum"
                                                };
                                                documentReference
                                                    .setData(forumsData,
                                                        merge: true)
                                                    .whenComplete(() {
                                                  print("forum created");
                                                }).catchError((e) => print(e));
                                              },
                                              child: Text("JOIN FORUM",
                                                  style: TextStyle(
                                                    color: Color(0xFF1D4886),
                                                  )),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      );
                    })
                : new Container();
          }),
    )
      ));}
}
