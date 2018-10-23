import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:io';
import 'dart:async';

class Profiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilesState();
  }
}

class _ProfilesState extends State<Profiles> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _decriptioncontrol = new TextEditingController();
  final TextEditingController _destinationcontrol = new TextEditingController();
  String userId;
  SharedPreferences prefs;
  String id;
  readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id").toString() ?? '';
    setState(() {});
  }

  List<String> _nationalities = new List<String>();
  String _nationality;

  List<String> _languages = new List<String>();

  String _selectedSeat;

  String _language1;
  String _language2;

  String _selectedGender;
  String _selectedTraveller;
  String _selectedMatch;
  String _selectedTranslation;

  String _descrip;
  String _destination;

  String _nickname;
  String stringAge;

  int test;

  double _age = 0.0; //for age selector

// Upload profile image:
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  //
  String _selectedInterests;
  @override
  void initState() {
    _nationalities.addAll(["Singaporean", "Chinese", "Japanese", "European", "American"]);
    _languages.addAll(["English", "German", "Italian", "French", "Japanese", "Others"]);
  }

  void _onChangedNat(String value) {
    setState(() {
      _nationality = value;
    });
  }

//new
  void _onChangedInterests(String value) {
    setState(() {
      _selectedInterests = value;
    });
  }

  void _onChangedSeat(String value) {
    setState(() {
      _selectedSeat = value;
    });
  }

   void _onChangedTranslation(String value) {
    setState(() {
      _selectedTranslation = value;
    });
  }

  void _onChangedLang1(String value) {
    setState(() {
      _language1 = value;
    });
  }

  void _onChangedLang2(String value) {
    setState(() {
      _language2 = value;
    });
  }

  void _onChangedGender(String value) {
    setState(() {
      _selectedGender = value;
    });
  } //gender selection

  void _onChangedTraveller(String value) {
    setState(() {
      _selectedTraveller = value;
    });
  } //traveller type selection

  void _onChangedMatch(String value) {
    setState(() {
      _selectedMatch = value;
    });
  } //match selection

  void _onChangedAge(double value) {
    setState(() {
      _age = value;
      stringAge = _age.round().toString();
    });
  } //age selection

//Confrimation dialog when saved
  void _confirm() {
    confirmDialog(context).then((bool value) {});
  }

  void _confirmNull() {
    nullDialog(context).then((bool value) {});
  }

  Future<bool> nullDialog(BuildContext context) {
    return showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("Sorry"),
            content: new Text("Please fill up all the fields in the form!"),
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

  Future<bool> confirmDialog(BuildContext context) {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("Saved!"),
            content: new Text("Your profile has been updated!"),
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
    return new Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: new Color(0xFFDAA520),
          ),
          title: Text('Profile'),
          backgroundColor: Colors.white,
          textTheme: Theme.of(context).textTheme.apply(
              bodyColor: new Color(0xFFDAA520),
              displayColor: new Color(0xFFDAA520),
              fontFamily: 'Garamond'),
        ),
        body: new Container(
            color: Colors.grey[200],
            child: new ListView(children: <Widget>[
              new Container(
                margin: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
                child: Column(
                  children: <Widget>[
                    new Container(
                      padding: new EdgeInsets.all(10.0),
                      child: new FloatingActionButton(
                          heroTag: 1,
                          backgroundColor: new Color(0xFF1D4886),
                          onPressed: getImage,
                          child: Icon(Icons.add_a_photo)),
                    ),
                    new Text(
                      'Add Profile Picture',
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
              new Card(
                //main card 1
                child: Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      AppBar(
                          title: Text('Basic Info'),
                          backgroundColor: new Color(0xFF1D4886),
                          automaticallyImplyLeading: false),
                      TextField(
                          onChanged: (String n) {
                            setState(() {
                              _nickname = n;
                            });
                          },
                          decoration: new InputDecoration(
                              icon: const Icon(Icons.person),
                              labelText: 'Nickname:')),
                      new InputDecorator(
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.wc),
                          labelStyle: TextStyle(fontSize: 23.0),
                          labelText: ('Gender'),
                        ),
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Text('Male'),
                          new Radio(
                            value: 'Male',
                            groupValue: _selectedGender,
                            onChanged: (String value) {
                              _onChangedGender(value);
                            },
                          ),
                          new Text('Female'),
                          new Radio(
                            value: 'Female',
                            groupValue: _selectedGender,
                            onChanged: (String value) {
                              _onChangedGender(value);
                            },
                          ),
                        ],
                      ),
                      new InputDecorator(
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.add),
                          labelStyle: TextStyle(fontSize: 23.0),
                          labelText: ('Age'),
                        ),
                      ),
                      new Column(
                        children: <Widget>[
                          new Padding(
                            padding: new EdgeInsets.only(left: 30.0),
                            child: new Slider(
                              min: 0.0,
                              max: 110.0,
                              value: _age,
                              onChanged: (double value) {
                                _onChangedAge(value);
                              },
                            ),
                          ),
                          new Text(
                            "I am ${_age.round()} years old",
                            style: new TextStyle(fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      new InputDecorator(
                          decoration: new InputDecoration(
                              icon: Icon(
                                Icons.flag,
                              ),
                              labelText: 'Nationality:',
                              labelStyle: TextStyle(fontSize: 23.0),
                              contentPadding: EdgeInsets.only(top: 50.0)),
                          isEmpty: _nationality == '',
                          child: new DropdownButtonHideUnderline(
                              child: new DropdownButton<String>(
                                  value: _nationality,
                                  items: _nationalities.map((String value) {
                                    return new DropdownMenuItem(
                                      value: value,
                                      child: new Row(children: <Widget>[
                                        new Text('${value}'),
                                      ]),
                                    );
                                  }).toList(),
                                  onChanged: (String value) {
                                    _onChangedNat(value);
                                  }))),
                      new InputDecorator(
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          labelStyle: TextStyle(fontSize: 23.0),
                          icon: Icon(
                            Icons.language,
                          ),
                          labelText: 'Languages I Speak',
                        ),
                        isEmpty: _language1 == '',
                      ),
                      new Align(
                        heightFactor: (1.0),
                        alignment: FractionalOffset(0.99, 0.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            new DropdownButton<String>(
                                value: _language1,
                                items: _languages.map((String value) {
                                  return new DropdownMenuItem(
                                    value: value,
                                    child: new Row(children: <Widget>[
                                      new Text('${value}'),
                                    ]),
                                  );
                                }).toList(),
                                onChanged: (String value) {
                                  _onChangedLang1(value);
                                }),
                            new DropdownButton<String>(
                                value: _language2,
                                items: _languages.map((String value) {
                                  return new DropdownMenuItem(
                                    value: value,
                                    child: new Row(children: <Widget>[
                                      new Text('${value}'),
                                    ]),
                                  );
                                }).toList(),
                                onChanged: (String value) {
                                  _onChangedLang2(value);
                                }),
                          ],
                        ),
                      ),
                      new InputDecorator(
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.g_translate),
                          labelStyle: TextStyle(fontSize: 20.0),
                          labelText: ('Translation to your first language?'),
                        ),
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Text('Yes'),
                          new Radio(
                            value: 'true',
                            groupValue: _selectedTranslation,
                            onChanged: (String value) {
                              _onChangedTranslation(value);
                            },
                          ),
                          new Text('No'),
                          new Radio(
                            value: 'false',
                            groupValue: _selectedTranslation,
                            onChanged: (String value) {
                              _onChangedTranslation(value);
                            },
                          ),
                        ],
                      ),
                    ])),
              ),
              new Card(
                  // main card 2
                  child: new Column(
                children: <Widget>[
                  AppBar(
                      title: Text('Additional Info'),
                      backgroundColor: new Color(0xFF1D4886),
                      automaticallyImplyLeading: false),
                  new InputDecorator(
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.card_travel),
                      labelStyle: TextStyle(fontSize: 23.0),
                      labelText: ('Type of Traveller'),
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(left: 30.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Text('Business'),
                        new Radio(
                          value: 'Business',
                          groupValue: _selectedTraveller,
                          onChanged: (String value) {
                            _onChangedTraveller(value);
                          },
                        ),
                        new Text('Leisure'),
                        new Radio(
                          value: 'Leisure',
                          groupValue: _selectedTraveller,
                          onChanged: (String value) {
                            _onChangedTraveller(value);
                          },
                        ),
                        new Text('Student'),
                        new Radio(
                          value: 'Student',
                          groupValue: _selectedTraveller,
                          onChanged: (String value) {
                            _onChangedTraveller(value);
                          },
                        ),
                      ],
                    ),
                  ),
                  new InputDecorator(
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.airline_seat_recline_normal),
                      labelStyle: TextStyle(fontSize: 23.0),
                      labelText: ('Type Of Seat'),
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(left: 30.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Text('Window'),
                        new Radio(
                          value: 'Window',
                          groupValue: _selectedSeat,
                          onChanged: (String value) {
                            _onChangedSeat(value);
                          },
                        ),
                        new Text('Aisle'),
                        new Radio(
                          value: 'Aisle',
                          groupValue: _selectedSeat,
                          onChanged: (String value) {
                            _onChangedSeat(value);
                          },
                        ),
                        new Text('Anything'),
                        new Radio(
                          value: 'Anything',
                          groupValue: _selectedSeat,
                          onChanged: (String value) {
                            _onChangedSeat(value);
                          },
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    padding: EdgeInsets.only(top: 10.0),
                    child: new InputDecorator(
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.chat_bubble_outline),
                        labelStyle: TextStyle(fontSize: 23.0),
                        labelText: ('Description about yourself:'),
                      ),
                    ),
                  ),
                  new Container(
                    padding: EdgeInsets.only(left: 40.0, right: 10.0),
                    child: new TextField(
                      maxLength: 200,
                      maxLengthEnforced: true,
                      controller: _decriptioncontrol,
                      onChanged: (String e) {
                        setState(() {
                          _descrip = e;
                        });
                      },
                    ),
                  ),
                  new Container(
                    padding: EdgeInsets.only(top: 10.0),
                    child: new InputDecorator(
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.chat_bubble_outline),
                        labelStyle: TextStyle(fontSize: 23.0),
                        labelText: ('Your trip itinerary:'),
                      ),
                    ),
                  ),
                  new Container(
                    padding: EdgeInsets.only(left: 40.0, right: 10.0),
                    child: new TextField(
                      maxLength: 200,
                      maxLengthEnforced: true,
                      controller: _destinationcontrol,
                      onChanged: (String a) {
                        setState(() {
                          _destination = a;
                        });
                      },
                    ),
                  ),
                  new InputDecorator(
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.group),
                      labelStyle: TextStyle(fontSize: 23.0),
                      labelText: ('Want a flight buddy?'),
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(left: 30.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Text('Yes'),
                        new Radio(
                          value: 'Yes',
                          groupValue: _selectedMatch,
                          onChanged: (String value) {
                            _onChangedMatch(value);
                          },
                        ),
                        new Text('No'),
                        new Radio(
                          value: 'No',
                          groupValue: _selectedMatch,
                          onChanged: (String value) {
                            _onChangedMatch(value);
                          },
                        )
                      ],
                    ),
                  ),
                  //new addition
                  new InputDecorator(
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.group),
                      labelStyle: TextStyle(fontSize: 23.0),
                      labelText: ('Your Interests:'),
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
                                value: 'Food',
                                groupValue: _selectedInterests,
                                onChanged: (String value) {
                                  _onChangedInterests(value);
                                },
                              ),
                              new Text('Technology'),
                              new Radio(
                                value: 'Technology',
                                groupValue: _selectedInterests,
                                onChanged: (String value) {
                                  _onChangedInterests(value);
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
                                value: 'Finance',
                                groupValue: _selectedInterests,
                                onChanged: (String value) {
                                  _onChangedInterests(value);
                                },
                              ),
                              new Text('Photography'),
                              new Radio(
                                value: 'Photography',
                                groupValue: _selectedInterests,
                                onChanged: (String value) {
                                  _onChangedInterests(value);
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
                    padding: new EdgeInsets.only(
                        top: 20.0, left: 300.0, bottom: 20.0),
                    child: new ButtonTheme(
                      minWidth: 1.0,
                      height: 5.0,
                      child: new FloatingActionButton(
                          backgroundColor: new Color(0xFF1D4886),
                          onPressed: () {
                            if (_nickname != null &&
                                _selectedGender != null &&
                                stringAge != null &&
                                _nationality != null &&
                                _selectedTraveller != null &&
                                _selectedSeat != null &&
                                _descrip != null &&
                                _destination != null &&
                                _selectedMatch != null &&
                                _selectedInterests != null) {
                              if (_formKey.currentState.validate()) {
                                DocumentReference documentReference = Firestore
                                    .instance
                                    .collection('users')
                                    .document(id);
                                Map<String, dynamic> profilesData =
                                    <String, dynamic>{
                                  "Name": _nickname,
                                  "Gender": _selectedGender,
                                  "Age": stringAge,
                                  "Nationality": _nationality,
                                  "Languages1": _language1,
                                  "Languages2": _language2,
                                  "Type": _selectedTraveller,
                                  "Seat": _selectedSeat,
                                  "Description": _descrip,
                                  "Destination": _destination,
                                  "Match": _selectedMatch,
                                  "imageURL":
                                      "http://www.desiformal.com/assets/images/default-userAvatar.png",
                                  "id": id,
                                  "interest": _selectedInterests,
                                  "filter": 'no',
                                  "wantsTranslation": _selectedTranslation
                                };
                                Navigator.of(context).pop(true);
                                documentReference
                                    .setData(profilesData, merge: true)
                                    .whenComplete(() {
                                  print("profile created");
                                }).catchError((e) => print(e));
                                _confirm();
                              }
                            } else {
                              _confirmNull();
                            }
                          },
                          child: Center(
                            child: Icon(Icons.save),
                          )),
                    ),
                  )
                ],
              ))
            ])));
  }
}
