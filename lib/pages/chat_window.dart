import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String defaultUserName = "Passenger";

class Chat extends StatefulWidget {
  final String name;
  Chat(this.name);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ChatWindow(name);
  }
}

class ChatWindow extends State<Chat> with TickerProviderStateMixin {
  final String name;
  ChatWindow(this.name);
  final List<Msg> _messages = <Msg>[];
  final TextEditingController _textController = new TextEditingController();

  bool _isWriting = false;

  @override
  Widget build(BuildContext context) {
    _reset();
    print(count);
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(name),
        backgroundColor: new Color(0xFF1D4886),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 6.0,
      ),
      body: new Column(children: <Widget>[
        new Flexible(
            child: new ListView.builder(
          itemBuilder: (_, int index) => _messages[index],
          itemCount: _messages.length,
          reverse: true,
          padding: new EdgeInsets.all(6.0),
        )),
        new Divider(height: 1.0),
        new Container(
          child: _buildComposer(),
          decoration: new BoxDecoration(
            color: Theme.of(context).cardColor,
          ),
        ),
      ]),
    );
  }

  Widget _buildComposer() {
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
                decoration:
                    new InputDecoration.collapsed(hintText: "Enter a message"),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 3.0),
              child: Theme.of(context).platform == TargetPlatform.iOS
                  ? new CupertinoButton(
                      child: new Text("Submit"),
                      onPressed: _isWriting
                          ? () {
                              //_reset(); print(prevMessage); print(count.toString());
                              _submitMsg(_textController.text);
                              print(prevMessage);
                              print(count.toString());
                            }
                          : null)
                  : new IconButton(
                      icon: new Icon(Icons.message),
                      onPressed: _isWriting
                          ? () {
                              //_reset(); print(prevMessage); print(count.toString());
                              _submitMsg(_textController.text);
                              print(prevMessage);
                              print(count.toString());
                            }
                          : null,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  var prevMessage;
  var count = 0;
  void _reset() {
    final docReferenceGet = Firestore.instance.document("users/" + name);
    docReferenceGet.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          prevMessage = datasnapshot.data['lastMessage'];
          count = datasnapshot.data.length + 1;
        });
      }
    });
  }

  void _submitMsg(String txt) {
    _textController.clear();
    setState(() {
      _isWriting = false;
    });

    Msg msg = new Msg(
      txt: txt,
      animationController: new AnimationController(
          vsync: this, duration: new Duration(milliseconds: 800)),
    );
    setState(() {
      _messages.insert(0, msg);
    });
    msg.animationController.forward();

    final docReferencePost = Firestore.instance.document("users/" + name);

    Map<String, String> data = <String, String>{
      count.toString(): prevMessage,
      "name": name,
      "lastMessage": txt,
      "time": DateTime.now().hour.toString() +
          ":" +
          DateTime.now().minute.toString(),
      "imageURL":
          "https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png",
    };

    docReferencePost.setData(data, merge: true).whenComplete(() {
      print("message sent");
      //print(count.toString());
      //print(prevMessage);
    }).catchError((e) => print(e));
  }

  @override
  void dispose() {
    for (Msg msg in _messages) {
      msg.animationController.dispose();
    }
    super.dispose();
  }
}

class Msg extends StatelessWidget {
  Msg({this.txt, this.animationController});
  final String txt;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
        parent: animationController,
        curve: Curves.bounceOut,
      ),
      axisAlignment: 0.0,
      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(right: 18.0),
              child: new CircleAvatar(child: new Text(defaultUserName[0])),
            ),
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(defaultUserName,
                      style: Theme.of(context).textTheme.subhead),
                  new Container(
                    margin: const EdgeInsets.only(top: 6.0),
                    child: new Text(txt),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
