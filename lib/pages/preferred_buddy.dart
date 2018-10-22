import 'package:flutter/material.dart';
//latest
class PreferredBuddy extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PreferredBuddyState();
  }
}

class _PreferredBuddyState extends State<PreferredBuddy> {
  String _selectedBuddyInterests;
  //new
  void _onChangedBuddyInterests(String value) {
    setState(() {
      _selectedBuddyInterests = value;
    });
  }

  //1st checkbox:

  bool _isChecked1 = false;

  void _onChangedBuddyAge1(bool value) {
    setState(() {
      _isChecked1 = value;
    });
  }
  //2nd checkbox:

  bool _isChecked2 = false;

  void _onChangedBuddyAge2(bool value) {
    setState(() {
      _isChecked2 = value;
    });
  }
  //3rd checkbox:

  bool _isChecked3 = false;

  void _onChangedBuddyAge3(bool value) {
    setState(() {
      _isChecked3 = value;
    });
  }
  //4th checkbox:

  bool _isChecked4 = false;

  void _onChangedBuddyAge4(bool value) {
    setState(() {
      _isChecked4 = value;
    });
  }
  //5th checkbox:

  bool _isChecked5 = false;

  void _onChangedBuddyAge5(bool value) {
    setState(() {
      _isChecked5 = value;
    });
  }
  //6th checkbox:

  bool _isChecked6 = false;

  void _onChangedBuddyAge6(bool value) {
    setState(() {
      _isChecked6 = value;
    });
  }
//gender selection
//1st checkbox:

  bool _genderisChecked1 = false;

  void _onChangedBuddyGender1(bool value) {
    setState(() {
      _genderisChecked1 = value;
    });
  }
  //2nd checkbox:

  bool _genderisChecked2 = false;

  void _onChangedBuddyGender2(bool value) {
    setState(() {
      _genderisChecked2 = value;
    });
  }

  bool _travellerisChecked1 = false;

  void _onChangedBuddyTraveller1(bool value) {
    setState(() {
      _travellerisChecked1 = value;
    });
  }

  bool _travellerisChecked2 = false;

  void _onChangedBuddyTraveller2(bool value) {
    setState(() {
      _travellerisChecked2 = value;
    });
  }

  bool _travellerisChecked3 = false;

  void _onChangedBuddyTraveller3(bool value) {
    setState(() {
      _travellerisChecked3 = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: new Color(0xFFDAA520),
          ),
          title: Text('My Preferred Buddy'),
          backgroundColor: Colors.white,
          textTheme: Theme.of(context).textTheme.apply(
              bodyColor: new Color(0xFFDAA520),
              displayColor: new Color(0xFFDAA520),
              fontFamily: 'Garamond'),
        ),
        body: Container(
            child: ListView(children: <Widget>[
          new Card(
            //main card 1
            child: new Column(
              children: <Widget>[
                AppBar(
                    title: Text('Basic Details'),
                    backgroundColor: new Color(0xFF1D4886),
                    automaticallyImplyLeading: false),
                new InputDecorator(
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.wc),
                    labelStyle: TextStyle(fontSize: 23.0),
                    labelText: ('Gender'),
                  ),
                ),
                new Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Text('Male'),
                      new Checkbox(
                        value: _genderisChecked1,
                        onChanged: (bool value) {
                          _onChangedBuddyGender1(value);
                        },
                      ),
                      new Text('Female'),
                      new Checkbox(
                        value: _genderisChecked2,
                        onChanged: (bool value) {
                          _onChangedBuddyGender2(value);
                        },
                      ),
                    ],
                  ),
                ),
                new InputDecorator(
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.add),
                    labelStyle: TextStyle(fontSize: 23.0),
                    labelText: ('Age'),
                  ),
                ),
                new Container(
                  child: Column(
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Text('18 - 28 years'),
                          new Checkbox(
                            value: _isChecked1,
                            onChanged: (bool value) {
                              _onChangedBuddyAge1(value);
                            },
                          ),
                          new Text('28 - 38 years'),
                          new Checkbox(
                            value: _isChecked2,
                            onChanged: (bool value) {
                              _onChangedBuddyAge2(value);
                            },
                          ),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Text('38 - 48 years'),
                          new Checkbox(
                            value: _isChecked3,
                            onChanged: (bool value) {
                              _onChangedBuddyAge3(value);
                            },
                          ),
                          new Text('48 - 58 years'),
                          new Checkbox(
                            value: _isChecked4,
                            onChanged: (bool value) {
                              _onChangedBuddyAge4(value);
                            },
                          ),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Text('58 - 68 years'),
                          new Checkbox(
                            value: _isChecked5,
                            onChanged: (bool value) {
                              _onChangedBuddyAge5(value);
                            },
                          ),
                          new Text('68 and older'),
                          new Checkbox(
                            value: _isChecked6,
                            onChanged: (bool value) {
                              _onChangedBuddyAge6(value);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  //Column containing multiple rows
                ),
              ],
            ),
          ),
          new Card(
              //main card 2
              child: new Column(children: <Widget>[
            AppBar(
                title: Text('Additional Details'),
                backgroundColor: new Color(0xFF1D4886),
                automaticallyImplyLeading: false),
            new InputDecorator(
              decoration: new InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.card_travel),
                labelStyle: TextStyle(fontSize: 23.0),
                labelText: ('Type of Traveller:'),
              ),
            ),
            new Padding(
                padding: new EdgeInsets.only(left: 0.0),
                child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Text('Business'),
                      new Checkbox(
                        value: _travellerisChecked1,
                        onChanged: (bool value) {
                          _onChangedBuddyTraveller1(value);
                        },
                      ),
                      new Text('Leisure'),
                      new Checkbox(
                        value: _travellerisChecked2,
                        onChanged: (bool value) {
                          _onChangedBuddyTraveller2(value);
                        },
                      ),
                      new Text('Student'),
                      new Checkbox(
                        value: _travellerisChecked3,
                        onChanged: (bool value) {
                          _onChangedBuddyTraveller3(value);
                        },
                      )
                    ])),

            //new addition
            new InputDecorator(
              decoration: new InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.group),
                labelStyle: TextStyle(fontSize: 23.0),
                labelText: ('His/Her Interests:'),
              ),
            ),
            new Padding(
              padding: new EdgeInsets.only(left: 40.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.only(left: 10.0, right: 7.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Text('Food'),
                        new Radio(
                          value: 'food',
                          groupValue: _selectedBuddyInterests,
                          onChanged: (String value) {
                            _onChangedBuddyInterests(value);
                          },
                        ),
                        new Text('Technology'),
                        new Radio(
                          value: 'technology',
                          groupValue: _selectedBuddyInterests,
                          onChanged: (String value) {
                            _onChangedBuddyInterests(value);
                          },
                        )
                      ],
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(right: 10.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Text('Finance'),
                        new Radio(
                          value: 'finance',
                          groupValue: _selectedBuddyInterests,
                          onChanged: (String value) {
                            _onChangedBuddyInterests(value);
                          },
                        ),
                        new Text('Photography'),
                        new Radio(
                          value: 'photography',
                          groupValue: _selectedBuddyInterests,
                          onChanged: (String value) {
                            _onChangedBuddyInterests(value);
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            //
            new Container(
              padding:
                  new EdgeInsets.only(top: 20.0, left: 300.0, bottom: 20.0),
              child: new ButtonTheme(
                minWidth: 1.0,
                height: 5.0,
                child: new FloatingActionButton(
                    backgroundColor: new Color(0xFF1D4886),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Center(
                      child: Icon(Icons.save),
                    )),
              ),
            ),
          ]))
        ])));
  }
}
