import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leap_app/ui/home.dart';

class NewProfile extends StatefulWidget {
  @override
  _NewProfileState createState() => _NewProfileState();
}

class _NewProfileState extends State<NewProfile> {
  bool newProfile = false;
  
  String _firstName, _middleName, _lastName, _batch, _group;
  DateTime _birthDay;
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black,
        title: new Text("Profile"),
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(50.0),
            child: new Form(
              key: formkey,
              child: new Column(
                children: <Widget>[
                  new TextFormField(
                    decoration: new InputDecoration(labelText: "First Name"),
                    validator: validateName,
                    onSaved: (str) => _firstName = str,
                  ),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: "Middle Name"),
                    validator: validateName,
                    onSaved: (str) => _middleName = str,
                  ),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: "Last Name"),
                    validator: validateName,
                    onSaved: (str) => _lastName = str,
                  ),
                  new DateTimePickerFormField(
                    format: DateFormat("MMMM d, yyyy"),
                    enabled: true,
                    dateOnly: true,
                    decoration: new InputDecoration(
                      labelText: "Date",
                    ),
                    onSaved: (str) => _birthDay = str,
                  ),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: "Batch"),
                    validator: validateName,
                    onSaved: (str) => _batch = str,
                  ),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: "Group"),
                    validator: validateName,
                    onSaved: (str) => _group = str,
                  ),
                  new FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      child: new Text("Save"),
                      color: Colors.greenAccent,
                      onPressed: onSubmit)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  String validateName(String str) {
    String pattern = r'(^[a-zA-Z ] * $)';
    RegExp regExp = new RegExp(pattern);

    if (str.length == 0) {
      return "Field is required";
    }
    // else if (!regExp.hasMatch(str)) {
    //   return "Numbers or special characters is not allowed";
    // }
    else {
      return null;
    }
  }

  void onSubmit() {
    var form = formkey.currentState;
    if (form.validate()) {
      form.save();   
    var confirmation = SimpleDialog(
      children: <Widget>[
        new Text("We're all set $_firstName"),
        new FlatButton(
          child: new Text("Tap here"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

      updateProfile();
        Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => new Home()));
              showDialog(context: context, child: confirmation);
    }
  }

  

  void updateProfile() {
    FirebaseAuth.instance.currentUser().then((user) async {
      DocumentReference _docRef =
          Firestore.instance.collection('profiles').document("${user.uid}");
      Firestore.instance.runTransaction((transaction) async {
        await transaction.update(_docRef, {
          "first_name": _firstName,
          "middle_name": _middleName,
          "last_name": _lastName,
          "birth_day": _birthDay,
          "group": _group,
          "batch": _batch,
          "status": "Done"
        });
      });
    });
  }





}
