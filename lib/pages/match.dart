import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import './preferred_buddy.dart' as preferred_buddy;
import 'package:shared_preferences/shared_preferences.dart';

<<<<<<< HEAD
// WORK
=======
>>>>>>> hanzhe
class Match extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MatchState();
  }
}

class _MatchState extends State<Match> {
  void _info() {
    infoDialog(context).then((bool value) {});
  }

  Future<bool> infoDialog(BuildContext context) {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("KrisMatch Information"),
            content: new Text(
                "Scroll through the list of other passengers to find a buddy!" +
                    " Once you found a passenger that you want to chat with simply press 'chat' to chat and find out more about each other!" +
                    "Once you find out who you want your seat buddy to be on the flight, simply press 'Match' and wait for both of you to accept" +
                    " for us to match your seats together onboard the flight."),
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
                                  child: new Text('Find Your Flight Buddy!',
                                      style: new TextStyle(
                                          fontFamily: 'Raleway',
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold))),
                              flex: 4),
                          new Expanded(
                              child: new IconButton(
                                  icon: new Icon(Icons.filter_list),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                preferred_buddy
                                                    .PreferredBuddy()));
                                  }),
                              flex: 1),
                          new Expanded(
                              child: new IconButton(
                                  icon: new Icon(Icons.info),
                                  onPressed: () {
                                    _info();
                                  }),
                              flex: 1)
                        ],
                      ))),
                  flex: 1),
              new Expanded(
                  child: new Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: new Stack(children: <Widget>[ShowInfo(context)])),
                  flex: 5)
            ]));
  }
}

class ShowInfo extends StatefulWidget {
  final BuildContext context;
  ShowInfo(this.context);
  @override
  ShowInfoState createState() => ShowInfoState(context);
}

class ShowInfoState extends State<ShowInfo> {
  BuildContext context;
  ShowInfoState(this.context);
  int _activeMeterIndex;
  List<DocumentSnapshot> databaseDocuments;
<<<<<<< HEAD
  List<DocumentSnapshot> usersDocuments;
=======
>>>>>>> hanzhe

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

  readData() async {
<<<<<<< HEAD
    final QuerySnapshot result = await Firestore.instance
        .collection('users')
        .where('id', isEqualTo: id)
        .getDocuments();
    databaseDocuments = result.documents;
  }

  readUsers() async {
    final QuerySnapshot result =
        await Firestore.instance.collection('users').getDocuments();
    usersDocuments = result.documents;
=======
      final QuerySnapshot result = await Firestore.instance
      .collection('users')
      .where('id', isEqualTo: id)
      .getDocuments();
      databaseDocuments = result.documents;
>>>>>>> hanzhe
  }

  Future<bool> confirmDialog(BuildContext context) {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("User Added"),
            content: new Text("This passenger has been added to your chats!"),
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

  void _confirm2() {
    confirmDialog2(context).then((bool value) {});
  }

  Future<bool> confirmDialog2(BuildContext context) {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("Request Sent"),
            content: new Text(
                "Your request to sit with this passenger has been sent!"),
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

<<<<<<< HEAD
  List<DocumentSnapshot> filterDocuments;
  readData2() async {
    final QuerySnapshot result = await Firestore.instance
        .collection('users')
        .document(id)
        .collection('filters')
        .getDocuments();
    filterDocuments = result.documents;
  }

  List<DocumentSnapshot> userDocuments;
  readUser() async {
    final QuerySnapshot result =
        await Firestore.instance.collection('users').getDocuments();
    userDocuments = result.documents;
  }

  Stream dataStream() {
    Stream stream;
    String interest;
    if (databaseDocuments[0]['filter'] == 'yes') {
        interest = filterDocuments[0]['interest'];
        stream = Firestore.instance
        .collection('users')
        .where('interest', isEqualTo: interest)
        .where('Match', isEqualTo: 'Yes')
        .snapshots();
    } else{
    stream = Firestore.instance
        .collection('users')
        .where('Match', isEqualTo: 'Yes')
        .snapshots();
    }
    return stream;
  }

//new new
=======
>>>>>>> hanzhe
  @override
  Widget build(BuildContext context) {
    readData();
    readLocal();
    return Container(
      child: new StreamBuilder(
<<<<<<< HEAD
          stream: dataStream(),
=======
          stream: Firestore.instance.collection('users').snapshots(),
>>>>>>> hanzhe
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Loading...');
            return snapshot.data != null
                ? new ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    padding: const EdgeInsets.only(top: 10.0),
                    itemBuilder: (BuildContext context, int i) {
<<<<<<< HEAD
                      // if (snapshot.data.documents[i]['id'] != id)
                      // if (databaseDocuments[0]['filter'] == 'yes') {
                      //   if (snapshot.data.documents[i]['interest'] == interest) {
                      //       return _buildListItem(context, snapshot.data.documents[i], i);
                      //   }
                      // } else
                      // return _buildListItem(
                      //     context, snapshot.data.documents[i], i);
=======
>>>>>>> hanzhe
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
                                                  ['Name'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF1D4886),
                                                fontSize: 15.0,
                                              ),
                                              overflow: TextOverflow.clip),
                                        ),
                                        subtitle: Text("Gender: " +
                                            snapshot.data.documents[i]
                                                ['Gender'] +
                                            " \nAge: " +
                                            snapshot.data.documents[i]['Age']),
                                      )),
                              body: new Card(
                                  elevation: 4.0,
                                  color: Colors.white,
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
                                            "Profile",
                                            style: TextStyle(
                                              color: Color(0xFF1D4886),
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Description: " +
                                              snapshot.data.documents[i]
                                                  ['Description'],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13.0,
                                          ),
                                        ),
                                        Text(
                                          "Languages: " +
                                              snapshot.data.documents[i]
                                                  ['Languages1'] +
                                              " & " +
                                              snapshot.data.documents[i]
                                                  ['Languages2'],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13.0,
                                          ),
                                        ),
                                        Text(
                                          "Nationality: " +
                                              snapshot.data.documents[i]
                                                  ['Nationality'],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13.0,
                                          ),
                                        ),
                                        Text(
<<<<<<< HEAD
                                          "Interest: " +
                                              snapshot.data.documents[i]
                                                  ['interest'],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13.0,
                                          ),
                                        ),
                                        Text(
=======
>>>>>>> hanzhe
                                          "Type Of Traveller: " +
                                              snapshot.data.documents[i]
                                                  ['Type'],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13.0,
                                          ),
                                        ),
                                        Text(
                                          "Next Destination: " +
                                              snapshot.data.documents[i]
                                                  ['Destination'],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13.0,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            FlatButton(
                                              onPressed: () {
                                                _confirm();
                                                String chatId = snapshot
                                                    .data.documents[i]['id'];
                                                DocumentReference
                                                    documentReference =
                                                    Firestore.instance
                                                        .collection('users')
                                                        .document(id)
                                                        .collection('chatUsers')
                                                        .document(chatId);
                                                Map<String, String>
                                                    profilesData =
                                                    <String, String>{
                                                  "displayName": snapshot.data
                                                      .documents[i]['Name'],
                                                  "id": snapshot
                                                      .data.documents[i]['id'],
                                                  "photoURL": snapshot.data
                                                      .documents[i]['imageURL'],
                                                  "aboutMe":
                                                      "I am a fellow passenger!",
                                                  "type": "personal"
                                                };
                                                documentReference
                                                    .setData(profilesData,
                                                        merge: true)
                                                    .whenComplete(() {
                                                  print("chat created");
                                                }).catchError((e) => print(e));
                                                DocumentReference
                                                    documentReference2 =
                                                    Firestore.instance
                                                        .collection('users')
                                                        .document(chatId)
                                                        .collection('chatUsers')
                                                        .document(id);
                                                Map<String, String>
                                                    profilesData2 =
                                                    <String, String>{
<<<<<<< HEAD
                                                  "displayName":
                                                      databaseDocuments[0]
                                                          ['Name'],
                                                  "id": chatId,
                                                  "photoURL":
                                                      databaseDocuments[0]
                                                          ['imageURL'],
=======
                                                  "displayName": databaseDocuments[0]['Name'],
                                                  "id": chatId,
                                                  "photoURL": databaseDocuments[0]['imageURL'],
>>>>>>> hanzhe
                                                  "aboutMe":
                                                      "I am a fellow passenger!",
                                                  "type": "personal"
                                                };
                                                documentReference2
                                                    .setData(profilesData2,
                                                        merge: true)
                                                    .whenComplete(() {
                                                  print("other chat created");
<<<<<<< HEAD
                                                }).catchError((e) => print(
                                                        "Errorrrrrrrrrrrr" +
                                                            e));
=======
                                                }).catchError((e) => print("Errorrrrrrrrrrrr" + e));
>>>>>>> hanzhe
                                              },
                                              child: Text("CHAT",
                                                  style: TextStyle(
                                                    color: Color(0xFF1D4886),
                                                  )),
                                            ),
                                            FlatButton(
                                              onPressed: () {
                                                _confirm2();
                                              },
                                              child: Text("MATCH",
                                                  style: TextStyle(
                                                    color: Color(0xFF1D4886),
                                                  )),
                                            )
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
    );
  }
<<<<<<< HEAD

  Widget _buildListItem(
      BuildContext context, DocumentSnapshot document, int i) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 3.0,
      margin: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
      child: new ExpansionPanelList(
        expansionCallback: (int index, bool status) {
          setState(() {
            _activeMeterIndex = _activeMeterIndex == i ? null : i;
          });
        },
        children: [
          new ExpansionPanel(
            isExpanded: _activeMeterIndex == i,
            headerBuilder: (BuildContext context, bool isExpanded) =>
                new Container(
                    padding: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: new NetworkImage(document['imageURL']),
                        radius: 32.0,
                      ),
                      title: Container(
                        padding: EdgeInsets.only(bottom: 6.0),
                        child: Text(document['Name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1D4886),
                              fontSize: 15.0,
                            ),
                            overflow: TextOverflow.clip),
                      ),
                      subtitle: Text("Gender: " +
                          document['Gender'] +
                          " \nAge: " +
                          document['Age']),
                    )),
            body: new Card(
                elevation: 4.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          "Profile",
                          style: TextStyle(
                            color: Color(0xFF1D4886),
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "Description: " + document['Description'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                        ),
                      ),
                      Text(
                        "Languages: " +
                            document['Languages1'] +
                            " & " +
                            document['Languages2'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                        ),
                      ),
                      Text(
                        "Nationality: " + document['Nationality'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                        ),
                      ),
                      Text(
                        "Interest: " + document['interest'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                        ),
                      ),
                      Text(
                        "Type Of Traveller: " + document['Type'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                        ),
                      ),
                      Text(
                        "Next Destination: " + document['Destination'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              _confirm();
                              String chatId = document['id'];
                              DocumentReference documentReference = Firestore
                                  .instance
                                  .collection('users')
                                  .document(id)
                                  .collection('chatUsers')
                                  .document(chatId);
                              Map<String, String> profilesData =
                                  <String, String>{
                                "displayName": document['Name'],
                                "id": document['id'],
                                "photoURL": document['imageURL'],
                                "aboutMe": "I am a fellow passenger!",
                                "type": "personal"
                              };
                              documentReference
                                  .setData(profilesData, merge: true)
                                  .whenComplete(() {
                                print("chat created");
                              }).catchError((e) => print(e));
                              DocumentReference documentReference2 = Firestore
                                  .instance
                                  .collection('users')
                                  .document(chatId)
                                  .collection('chatUsers')
                                  .document(id);
                              Map<String, String> profilesData2 =
                                  <String, String>{
                                "displayName": databaseDocuments[0]['Name'],
                                "id": chatId,
                                "photoURL": databaseDocuments[0]['imageURL'],
                                "aboutMe": "I am a fellow passenger!",
                                "type": "personal"
                              };
                              documentReference2
                                  .setData(profilesData2, merge: true)
                                  .whenComplete(() {
                                print("other chat created");
                              }).catchError(
                                      (e) => print("Errorrrrrrrrrrrr" + e));
                            },
                            child: Text("CHAT",
                                style: TextStyle(
                                  color: Color(0xFF1D4886),
                                )),
                          ),
                          FlatButton(
                            onPressed: () {
                              _confirm2();
                            },
                            child: Text("MATCH",
                                style: TextStyle(
                                  color: Color(0xFF1D4886),
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
=======
>>>>>>> hanzhe
}
