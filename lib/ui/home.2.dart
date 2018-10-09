import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:async/async.dart';
import 'package:leap_app/ui/drawer.dart';

String userID;

class Home extends StatefulWidget {
  Home({AsyncSnapshot snapshot});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userID;
  @override
  Widget build(BuildContext context) {
    setProfile();

    return Scaffold(
      drawer: LEAPDrawer(),
      appBar: new AppBar(
        backgroundColor: Colors.black,
        title: new Text("LEAP Companion"),
      ),
      body: new CheckStatus(),
    );
  }

  void setProfile() {
    print("setProfile");
    Future<FirebaseUser> _user =
        FirebaseAuth.instance.currentUser().then((user) {
      print("instance.CurrentUser.then");
      Firestore.instance
          .collection("profiles")
          .document("${user.uid}")
          .get()
          .then((reference) {
        print("instance.doucument.then");
        if (reference.data == null) {
          print("User does not exist");
          _createProfile(user);
        } else {
          print("User exists");
          print(reference.data['status']);
        }
      });
    });
  }

  void _createProfile(FirebaseUser user) {
    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference = Firestore.instance.collection('profiles');
      print("_createProfile");

      await reference.document("${user.uid}").setData({
        "status": "New Profile",
      });
    });
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}

class CheckStatus extends StatefulWidget {
  @override
  _CheckStatusState createState() => _CheckStatusState();
}

class _CheckStatusState extends State<CheckStatus> {
  Future<String> uid = FirebaseAuth.instance.currentUser().then((value) {
    String id = value.uid;
    return id;
  });
  
  
  @override
  Widget build(BuildContext context) {
    CollectionReference reference = Firestore.instance.collection('profiles');
    print("printing uid $uid");

    print("Going to Futurebuilder");
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> user) {
        if (user.hasData) {
          return FutureBuilder(
            future: reference.document("${user.data.uid}").get(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
              if (snapshot.data['status'] == "New Profile") {
                print("isNewProfile");
                return new Container(
                  color: Colors.red,
                  child: new Text("Heyo"),
                  // height: 400.0,
                );
              } else {
                return CircularProgressIndicator();
              }
              } else {
                  return CircularProgressIndicator();
              }

            },
          );
        } else {
          print("No data");
          return CircularProgressIndicator();
        }
      },
    );
  }
}






















































// class CheckStatus extends StatefulWidget {
//   @override
//   _CheckStatusState createState() => _CheckStatusState();
// }

// class _CheckStatusState extends State<CheckStatus> {
//   Future<FirebaseUser> user = FirebaseAuth.instance.currentUser().then((_userValue) {
//     String uid = _userValue.uid;  
//   });
  

//   @override
//   Widget build(BuildContext context) {
//     CollectionReference reference = Firestore.instance.collection('profiles');

//     print("Going to Futurebuilder");
//     return FutureBuilder(
//       future: FirebaseAuth.instance.currentUser(),
//       builder: (BuildContext context, AsyncSnapshot<FirebaseUser> user) {
//         if (user.hasData) {
//           return FutureBuilder(
//             future: reference.document("${user.data.uid}").get(),
//             builder: (BuildContext context, AsyncSnapshot snapshot) {
//               if (snapshot.hasData) {
//               if (snapshot.data['status'] == "New Profile") {
//                 print("isNewProfile");
//                 return new Container(
//                   color: Colors.red,
//                   child: new Text("Heyo"),
//                   height: 400.0,
//                 );
//               } else {
//                 return CircularProgressIndicator(

//                 );
//               }
//               } else {
//                 return new Container();
//               }

//             },
//           );
//         } else {
//           print("No data");
//           return Container(child: new Text("sad"));
//         }
//       },
//     );
//   }
// }
// ----------------------------------------------------------------------------------------------------
// class CheckStatus extends StatefulWidget {
//   @override
//   _CheckStatusState createState() => _CheckStatusState();
// }

// class _CheckStatusState extends State<CheckStatus> {
//   @override
//   Widget build(BuildContext context) {
//     CollectionReference reference = Firestore.instance.collection('profiles');

//     print("Going to Futurebuilder");
//     return FutureBuilder(
//       future: FirebaseAuth.instance.currentUser(),
//       builder: (BuildContext context, AsyncSnapshot<FirebaseUser> user) {
//        if (user.hasData) {
//          print("User has data");
//          print("Getting doc reference");
//          DocumentReference docReference = reference.document("${user.data.uid}");
//          docReference.get().then((snapshot) {
//            print("Snapshot : $snapshot");
//            print("Values : ${snapshot.data.values} ");
//            print("Status : ${snapshot.data['status']}");
//            if(snapshot.data['status'] == "New Profile") {
//              print("isNewProfile");
//              return new Container(
//                color: Colors.red,
//                child: new Text("Heyo"),
//                height: 400.0,
//              );
//            } else {
//              print("No Status");
//            }

//          });

//          return Container(
//       child: new Text("happy")
//          );
//        } else {
//          print("No data");
//          return Container(
//            child: new Text("sad")
//          );
//        }

//       },

//     );
//   }

