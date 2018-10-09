import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:leap_app/ui/home.dart';
import 'package:leap_app/ui/splash.dart';
import 'package:leap_app/ui/simpleloader.dart';
import 'package:leap_app/ui/profile.dart';
import 'package:leap_app/ui/contents.dart';

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

  logOut () {
    FirebaseAuth.instance.signOut();
  }

