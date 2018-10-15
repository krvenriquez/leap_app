import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


import 'package:leap_app/ui/home.dart';
import 'package:leap_app/ui/splash.dart';
import 'package:leap_app/ui/simpleloader.dart';
import 'package:leap_app/ui/profilesetup.dart';
import 'package:leap_app/ui/createaccount.dart';



final GoogleSignIn _googleSignIn = new GoogleSignIn();
final passwordResetForm = GlobalKey<FormState>();
final FirebaseAuth _auth = FirebaseAuth.instance;


class UserManagement {
  Widget handleAuth() {
    return new StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return ProfileManagement().handleProfile();
          } else {
            return Splash();
          }
        });
  }

  void onTapCreateAccount(BuildContext context) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => new CreateAccount()));
  }

  void onTapSignout(BuildContext context) {
  FirebaseAuth.instance.signOut();
  Navigator.pop(context);
}

 void gSignin() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    print("User is : ${user.photoUrl}");
  
  }

  Future<FirebaseUser> emailSignIn(BuildContext context,String _email, String _password) async {

  


    FirebaseUser user = await _auth.signInWithEmailAndPassword(email: _email, password: _password).catchError((error) {
        var onError = SimpleDialog(contentPadding: EdgeInsets.all(10.0),children: <Widget>[
          new Text("${error.message}")
    ],);
    showDialog(context: context, child: onError);
    });


    assert(user != null);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return user;
  }

 
}

class ProfileManagement {
  CollectionReference reference = Firestore.instance.collection('profiles');
  Widget handleProfile() {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> user) {
        if (user.hasData) {
          return FutureBuilder(
            future: reference.document("${user.data.uid}").get(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data['status'] == "New Profile") {
                  //show profile setup
                  return ProfileSetup();
                } else {
                  // show home
                  return Home();
                }
              } else {
                //show loading data
                return Loadscreen().show();
              }
            },
          );
        } else {
          //show loading data
          return Loadscreen().show();
        }
      },
    );
  }
}







