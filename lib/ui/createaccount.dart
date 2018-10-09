import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;

class CreateAccount extends StatefulWidget {
  
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String _email;
  String _password;
  String _passwordValidation;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _autoValidate = false;

  

  @override
  Widget build(BuildContext context) {
    final double _screenwidth = MediaQuery.of(context).size.width;
    final double _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.blue,
        body: new SingleChildScrollView(
          child: new Center(
            child: new Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                margin: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 50.0),
                child: new Form(
                  autovalidate: _autoValidate,
                  key: formKey,
                  child: new Container(
                    margin: EdgeInsets.all(20.0),
                    height: 500.0,
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          height: 70.0,
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.bottomLeft,
                          child: new Text(
                            "Register",
                            style: new TextStyle(
                                color: Colors.blueAccent, fontSize: 30.0),
                          ),
                        ),
                        new Divider(),
                        new Container(
                          height: 20.0,
                        ),
                        new TextFormField(
                          decoration: new InputDecoration(
                            labelText: "Email",
                            icon: Icon(Icons.mail),
                          ),
                          validator: validateEmail,
                          onSaved: (str) => _email = str,
                          maxLength: 50,
                        ),
                        new TextFormField(
                          obscureText: true,
                          decoration: new InputDecoration(
                            labelText: "Password",
                            helperText: "Minimum of 8 characters",
                            
                            icon: Icon(Icons.lock),
                          ),
                          maxLength: 18,
                          validator: validatePassword,
                          onSaved: (str) => _password = str,
                        ),
                        new TextFormField(
                          obscureText: true,
                          decoration: new InputDecoration(
                            labelText: "Validate Password",
                            icon: Icon(Icons.lock),
                          ),
                          maxLength: 18,
                          validator: validatePassword,
                          onSaved: (str) => _passwordValidation = str,
                        ),
                        new Container(
                          height: 30.0,
                        ),
                        new MaterialButton(
                          height: 50.0,
                          onPressed: onSubmit,
                          color: Colors.pinkAccent,
                          child: new Text(
                            "Register",
                            style: new TextStyle(fontSize: 20.0),
                          ),
                          textColor: Colors.white,
                          minWidth: _screenwidth - 200.0,
                          splashColor: Colors.blue,
                        ),
                        //                         new MaterialButton(
                        //   height: 50.0,
                        //   onPressed: createDummyProfile,
                        //   color: Colors.pinkAccent,
                        //   child: new Text(
                        //     "Dummy",
                        //     style: new TextStyle(fontSize: 20.0),
                        //   ),
                        //   textColor: Colors.white,
                        //   minWidth: _screenwidth - 200.0,
                        //   splashColor: Colors.blue,
                        // ),
                      ],
                    ),
                  ),
                )),
          ),
        ));
  }

  void onSubmit() {
    var form = formKey.currentState;

    if (form.validate()) {
      form.save();
      if (_password == _passwordValidation) {
        print("Password : $_password is equal to $_passwordValidation");
        _registerUser();
      } else {
        var snackbar = SnackBar(
          backgroundColor: Colors.red,
          content: Text('Passwords do not match'),
          duration: Duration(milliseconds: 5000),
        );

        scaffoldKey.currentState.showSnackBar(snackbar);
      }
    } else {
      setState(() {
              _autoValidate = true;
            });
      
    }
  }


  Future _registerUser() async {
    FirebaseUser user = await _auth.createUserWithEmailAndPassword(email: _email, password: _password).then((user) {
          var snackbar = SnackBar(
          backgroundColor: Colors.red,
          content: Text('Succesfully registered user'),
          duration: Duration(milliseconds: 5000),
        );

        createProfile(user);

        scaffoldKey.currentState.showSnackBar(snackbar);
        Navigator.pop(context);
    }).catchError((error) {
         var snackbar = SnackBar(
          backgroundColor: Colors.red,
          content: Text('${error.message}'),
          duration: Duration(milliseconds: 5000),
        );

        scaffoldKey.currentState.showSnackBar(snackbar);


    });

  }

  String validateEmail (String str) {
     Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (str.length == 0) {
      return "Email is required";
    } else if(!regex.hasMatch(str)){
      return "Not a valid email address";
    }else {
      return null;
    }
  }

    String validateName (String str) {
      String pattern = r'(^[a-zA-Z ] * $)';
      RegExp regExp = new RegExp(pattern);

    if (str.length == 0) {
      return "Field is required";
    } else if (!regExp.hasMatch(str)) {
      return "Numbers or special characters on name is not allowed";
    } 
    else {
      return null;
    }
  }

  String validatePassword (String str) {
    if (str.length < 8 ) {
      return "Password must have a minimum of 8 characters";
    } else {
      return null;
    }
  }

  void createProfile(FirebaseUser user) {
    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference = Firestore.instance.collection('profiles');

      await reference.document("${user.uid}").setData({
        "email": "${user.email}",
        "displayName": "${user.displayName}",
        "photoURL": "${user.photoUrl}",
        "uid":  "${user.uid}",
        "status": "New Profile",
      
       
      });

      // await reference.document("${user.uid}").setData(data)

    

    });
  }

    void createDummyProfile() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference = Firestore.instance.collection('profiles');

      await reference.document('test').setData({
        "email": "test",
        "displayName": "test",
        "photoURL": "test",
        "uid":  "test",
        "status": "New Profile",
      
       
      });

      
      // await reference.add({
      //   "email": "test",
      //   "displayName": "test",
      //   "photoURL": "test",
      //   "uid":  "test",
      //   "status": "New Profile",
      
       
      // });

      // await reference.document("${user.uid}").setData(data)

    

    });
  }

}
