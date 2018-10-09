import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:async/async.dart';




import 'package:leap_app/ui/drawer.dart';
import 'package:leap_app/usermanagement.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(child:new CircularProgressIndicator()),
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

