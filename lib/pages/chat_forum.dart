import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final ThemeData iOSTheme = new ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: Colors.white,
  primaryColorBrightness: Brightness.light,
);

final ThemeData androidTheme = new ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: Colors.white,
  primaryColorBrightness: Brightness.light,
);

String forum;

const String defaultUserName = "AirVenue Administrator";

class ChatForum extends StatefulWidget {
  final String forumName;
  @override
  ChatForum(this.forumName);
  @override
  State createState() => new ChatForumScreen(forumName);
}

class ChatForumScreen extends State<ChatForum> with TickerProviderStateMixin {
  final String forumName;
  ChatForumScreen(this.forumName);
  final TextEditingController _textController = new TextEditingController();
  bool _isWriting = false;
  final ScrollController listScrollController = new ScrollController();

  SharedPreferences prefs;
  String id;
  readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id").toString() ?? '';
    setState(() {});
  }

  List<DocumentSnapshot> databaseDocuments;
  readData() async {
    final QuerySnapshot result = await Firestore.instance
        .collection('users')
        .where('id', isEqualTo: id)
        .getDocuments();
    databaseDocuments = result.documents;
  }

  @override
  Widget build(BuildContext ctx) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(forumName, style: new TextStyle(fontSize: 16.0)),
        backgroundColor: new Color(0xFF1D4886),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 6.0,
      ),
      body: new Column(children: <Widget>[
        new Flexible(
            child: new StreamBuilder(
                stream: Firestore.instance
                    .collection('forums')
                    .document(forumName)
                    .collection('messages')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text('Loading...');
                  return new ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    padding: const EdgeInsets.all(6.0),
                    itemBuilder: (context, index) => _buildListItem(
                        context, snapshot.data.documents[index]),
                        controller: listScrollController
                  );
                })),
        new Divider(height: 1.0),
        new Container(
          child: _buildComposer(),
          decoration: new BoxDecoration(color: Theme.of(ctx).cardColor),
        ),
      ]),
    );
  }

  Widget _buildComposer() {
    readLocal();
    readData();
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 9.0),
          child: new Row(
            children: <Widget>[
              new Flexible(
                child: new TextField(
                  controller: _textController,
                  onChanged: (String txt) {
                    setState(() {
                      _isWriting = txt.length > 0;
                    });
                  },
                  onSubmitted: _submitMsg,
                  decoration: new InputDecoration.collapsed(
                      hintText: "Enter some text to send a message"),
                ),
              ),
              new Container(
                  margin: new EdgeInsets.symmetric(horizontal: 3.0),
                  child: Theme.of(context).platform == TargetPlatform.iOS
                      ? new CupertinoButton(
                          child: new Text("Submit"),
                          onPressed: _isWriting
                              ? () => _submitMsg(_textController.text)
                              : null)
                      : new IconButton(
                          icon: new Icon(Icons.send),
                          onPressed: _isWriting
                              ? () => _submitMsg(_textController.text)
                              : null,
                        )),
            ],
          ),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? new BoxDecoration(
                  border: new Border(top: new BorderSide(color: Colors.brown)))
              : null),
    );
  }

  void _submitMsg(String txt) {
    String userName = databaseDocuments[0]['Name'];
    String photoURL = databaseDocuments[0]['imageURL'];
    _textController.clear();
    setState(() {
      _isWriting = false;
    });
    DocumentReference documentReference = Firestore.instance
        .collection('forums')
        .document(forumName)
        .collection('messages')
        .document(DateTime.now().millisecondsSinceEpoch.toString());
    Map<String, String> profilesData = <String, String>{
      "displayName": userName,
      "id": DateTime.now().millisecondsSinceEpoch.toString(),
      "photoURL": photoURL,
      "content": txt,
    };
    documentReference.setData(profilesData, merge: true).whenComplete(() {
      print("message added");
    }).catchError((e) => print(e));
    listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return new  Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                    margin: const EdgeInsets.only(right: 18.0),
                    child: new CircleAvatar(
                        backgroundImage:
                            new NetworkImage(document['photoURL']))),
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(document['displayName'],
                          style: new TextStyle(fontWeight: FontWeight.bold)),
                      new Container(
                        margin: const EdgeInsets.only(top: 6.0),
                        child: new Text(document['content']),
                      ),
                    ],
                  ),
                ),
              ],
            ));
  }
}
