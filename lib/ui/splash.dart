import 'package:flutter/material.dart';
import 'package:leap_app/usermanagement.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leap_app/ui/simpleloader.dart';

String _email;
String _password;


final FirebaseAuth _auth = FirebaseAuth.instance;

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
     final loginFormKey = new GlobalKey<FormState>();
     GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
 
  @override
  Widget build(BuildContext context) {


    final double _screenwidth = MediaQuery.of(context).size.width;
    final double _screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      key: scaffoldKey,
      children: <Widget>[
        // new Container(
        //   color: Colors.blueAccent,
        // )
        new Container(
          decoration: new BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/splash.jpg"),
            fit: BoxFit.fill,
          )),
        ),
        new Center(
            child: new Container(
          height: _screenHeight - 150.0,
          width: _screenwidth - 70.0,
          child: new Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            elevation: 13.0,
            color: Colors.white,
            child: new Container(
              margin: EdgeInsets.all(20.0),
              child: new Form(
                key: loginFormKey,
                            child: new Column(
                children: <Widget>[
                  new Container(
                    height: 120.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/leap_logo.png'))),
                  ),
                  new Container(
                    height: 20.0,
                  ),
                  new TextFormField(
                    validator: validateEmail,
                    onSaved: (str) => _email = str,
                    decoration: new InputDecoration(
                        fillColor: Colors.green, labelText: "Email"),
                  ),
                  new TextFormField(
                    obscureText: true,
                    validator: validatePassword,
                    onSaved: (str) => _password = str,
                    decoration: new InputDecoration(
                        fillColor: Colors.green, labelText: "Password"),
                  ),
                  new Container(
                    height: 30.0,
                  ),
                  new MaterialButton(
                    onPressed: () => onLoginWithEmail(context),
                    color: Colors.pinkAccent,
                    child: new Text("Login"),
                    textColor: Colors.white,
                    minWidth: _screenwidth - 200.0,
                    splashColor: Colors.blue,
                  ),
                  new MaterialButton(
                    onPressed: () {UserManagement().gSignin();},
                    color: Colors.blueAccent,
                    child: new Text("Login with Google"),
                    textColor: Colors.white,
                    minWidth: _screenwidth - 200.0,
                    splashColor: Colors.lightBlueAccent,
                  ),
                  new MaterialButton(
                    onPressed: () {
                      UserManagement().onTapCreateAccount(context);
                    },
                    color: Colors.lightBlueAccent,
                    child: new Text("Register"),
                    textColor: Colors.white,
                    minWidth: _screenwidth - 200.0,
                    splashColor: Colors.pinkAccent,
                  ),
                  new MaterialButton(
                    onPressed: () {onTapForgotPassword(context);},
                      
                        
                      
                    
                    color: Colors.lightBlueAccent,
                    child: new Text("Forgot password"),
                    textColor: Colors.white,
                    minWidth: _screenwidth - 200.0,
                    splashColor: Colors.pinkAccent,
                  ),
                ],
              ),
              ),
  
            ),
          ),
        ),
        )
      ],
    );
  }



  
 void onTapForgotPassword(BuildContext context) {
    var passwordreset = new SimpleDialog(
      children: <Widget>[
        new Container(
            margin: EdgeInsets.all(20.0),
            height: 300.0,
            width: 420.0,
            child: new Form(
                key: passwordResetForm,
                child: new Column(
                  children: <Widget>[
                    new Text(
                      "Password reset",
                      textAlign: TextAlign.left,
                      style: new TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    new Divider(),
                    new Text(
                        "By tapping reset password, a link will be sent\nto your email, please check your inbox"),
                    new Container(
                      height: 30.0,
                    ),
                    new TextFormField(
                      decoration: InputDecoration(labelText: "Email"),
                      validator: validateEmail,
                      onSaved: (str) => _email = str,
                    ),
                    new SizedBox(
                      height: 10.0,
                    ),
                    new RaisedButton(
                      onPressed: () {
                        onTapReset(context);
                      },
                      child: new Text("Reset password"),
                    ),
                  ],
                )))
      ],
    );

    showDialog(context: context, child: passwordreset);
  }

  Future onSubmitReset(BuildContext context) async {
    print("onSubmitReset $_email");
    FirebaseUser user =
        await _auth.sendPasswordResetEmail(email: _email).then((value) {
      Navigator.pop(context);

      var confirmsuccess = new SimpleDialog(
        children: <Widget>[
          new Container(
            width: 200.0,
            height: 200.0,
            padding: EdgeInsets.all(20.0),
            child: new Column(
              children: <Widget>[
         new Text("Password reset"),
          new Divider(),
          new Text("Succesfully sent email for a password reset"),
          new FlatButton(
            child: new Text("OK"),
            onPressed: () => Navigator.pop(context),
          )



              ],
            ),
          )
       
        ],
      );

      showDialog(context: context, child: confirmsuccess);
    }).catchError((errormessage) {
            var errorWithRequest = new SimpleDialog(
        children: <Widget>[
          new Container(
            width: 200.0,
            height: 200.0,
            padding: EdgeInsets.all(20.0),
            child: new Column(
              children: <Widget>[
            new Text("Password reset"),
          new Divider(),
          new Text("$errormessage"),
          new FlatButton(
            child: new Text("OK"),
            onPressed: () => Navigator.pop(context),
          )
              ],
            ),
          )
       
        ],
      );
     showDialog(context: context, child: errorWithRequest);
    });
  }

  void onTapReset(BuildContext context) {
  var form = passwordResetForm.currentState;
  print("onTapReset $_email");
  if (form.validate()) {
    form.save();
    setState(() {});
   onSubmitReset(context);
  }
}

String validateEmail(String str) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  print("Validating $_email");
  if (str.length == 0) {
    return "Please enter your email address";
  } else if (!regex.hasMatch(str)) {
    return "Not a valid email address";
  } else {
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


void onLoginWithEmail(BuildContext context) {
  bool showLoader = true;

  if (showLoader == true) {
    showDialog(context: context, child: Loadscreen().show());
  } 

  print("onLoginWithEmail");
  var loginform = loginFormKey.currentState;
  print("Validating");
  if (loginform.validate()) {
    loginform.save();
    print("Validated");
    print("_email");
    showLoader = false;
    UserManagement().emailSignIn(context, _email, _password);

  } else {
    showLoader = false;
    print("Not Validated");
      
  }
}

}
