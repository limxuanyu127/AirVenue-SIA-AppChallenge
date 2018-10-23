import 'package:flutter/material.dart';
import './home.dart';
import 'package:firebase_auth/firebase_auth.dart';
<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
=======
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
>>>>>>> hanzhe

class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Last name can\'t be empty' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Booking number can\'t be empty' : null;
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({this.onSignedIn});
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  String _bookNumber;
  String _lastName;
  FirebaseUser currentUser;
  SharedPreferences prefs;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Invalid"),
          content: new Text(
              "You have entered an incorrect booking reference number or last name"),
          actions: <Widget>[
            // buttons at bottom of dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        _lastName = _lastName + '111111';
        _bookNumber = _bookNumber + '@teamfantasia.com';
        prefs = await SharedPreferences.getInstance();
        FirebaseUser firebaseUser = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _bookNumber, password: _lastName);
        print('Signed in: $firebaseUser');

        if (firebaseUser != null) {
          // final QuerySnapshot result = await Firestore.instance
          //     .collection('chatusers')
          //     .where('nickname', isEqualTo: _lastName)
          //     .getDocuments();
          // final List<DocumentSnapshot> documents = result.documents;
          // Write data to local
          // await prefs.setString('id', documents[0]['id']);
          // await prefs.setString('nickname', documents[0]['nickname']);
          // await prefs.setString('photoUrl', documents[0]['photoUrl']);
          // await prefs.setString('aboutMe', documents[0]['aboutMe']);
          await prefs.setString('id', _bookNumber);
          await prefs.setString('lastname', _lastName);
<<<<<<< HEAD
          DocumentReference documentReference = Firestore.instance
              .collection('users')
              .document(_bookNumber)
              .collection('chatUsers')
              .document('1_Chatbot');
          Map<String, String> chatData = <String, String>{
            "aboutMe": "I am a chatbot!",
            "id": "SIAchatbot",
            "photoURL":
                "http://pluspng.com/img-png/singapore-airlines-logo-png-singapore-airlines-logo-1102.jpg",
            "type": "personal",
            "displayName": "EverBot"
          };
          documentReference.setData(chatData, merge: true).whenComplete(() {
            print("chat created");
          }).catchError((e) => print(e));
          DocumentReference documentReference2 = Firestore.instance
              .collection('users')
              .document(_bookNumber)
              .collection('announcements')
              .document('1');
          Map<String, String> announcementData = <String, String>{
            "announcement": "Welcome to AirVenue! Thank you for choosing Singapore Airlines!",
            "header": "AirVenue Administrator",
            "iconURL":
                "https://png.icons8.com/ios-glyphs/60/000000/crown.png",
            "time": ""
          };
          documentReference2.setData(announcementData, merge: true).whenComplete(() {
            print("chat created");
          }).catchError((e) => print(e));
=======

>>>>>>> hanzhe
        }
        {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Home(),
            ),
          );
        }
      } catch (e) {
        print('Error: $e');
        _showDialog();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Container(
            color: Colors.white,
            alignment: FractionalOffset.center,
            child: new Center(
                child: ListView(children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 60.0,
                child: Image.asset('assets/logo.png'),
              ),
              Container(
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: buildInputs() + buildSubmitButtons(),
                      )))
            ]))));
  }

  List<Widget> buildInputs() {
    return [
      TextFormField(
        key: Key('bookingNumber'),
        decoration: InputDecoration(labelText: 'Booking Reference Number'),
        validator: PasswordFieldValidator.validate,
        onSaved: (value) => _bookNumber = value,
      ),
      TextFormField(
        key: Key('lastName'),
        decoration: InputDecoration(labelText: 'Last Name'),
        validator: EmailFieldValidator.validate,
        onSaved: (value) => _lastName = value,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    {
      return [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Material(
            borderRadius: BorderRadius.circular(30.0),
            shadowColor: Colors.lightBlueAccent.shade100,
            elevation: 5.0,
            child: MaterialButton(
              minWidth: 200.0,
              height: 42.0,
              onPressed: () {
                validateAndSubmit();
              },
              color: Color(0xFF1D4886),
              child: Text('Log In', style: TextStyle(color: Colors.white)),
            ),
          ),
        )
      ];
    }
  }
}
