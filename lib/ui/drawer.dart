import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<FirebaseUser> user = FirebaseAuth.instance.currentUser();

class LEAPDrawer extends StatefulWidget {
  @override
  _LEAPDrawerState createState() => _LEAPDrawerState();
}

class _LEAPDrawerState extends State<LEAPDrawer> {

  @override
  Widget build(BuildContext context) {

  var drawerBackground = new BoxDecoration(

    gradient: LinearGradient(colors: [Colors.redAccent, Colors.pink]),
  );

  var header = DrawerHeader(
          child: Container(
            alignment: Alignment.centerLeft,
            child: new Column(
              children: <Widget>[
                new Text("LEAP Companion"),
                new Expanded(
                  child: new Container(

                    alignment: Alignment.bottomLeft,
                    child: Profile(),
                  ),

                ),
                
              ],
            ),
          ),
          decoration: drawerBackground,

        );

var logout = new ListTile(
  title: new Text("Logout"),
  trailing: new Icon(Icons.lock),
  onTap: () => onTapSignout(context),
);


 var drawerItems = [header, logout];

    return new Drawer(
      child: new ListView(
        children: drawerItems,
      ),
    );

  }
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> user) {
        if (user.hasData) {
            return Container(
              height: 80.0,       
   
              child: new Row(
                children: <Widget>[
                  new CircleAvatar(backgroundImage: NetworkImage("${user.data.photoUrl}"),radius: 20.0,),
                  new SizedBox(
                    width: 20.0,
                  ),
                  new Container(
               
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text("Welcome", style: new TextStyle(fontWeight: FontWeight.bold)) ,
                        new Text("${user.data.email}")
                      ],
                    ),
                  )
                ],
              ),
            );
        } else {
          return new Container();
        }
      },
      
    );
  }


}
  void onTapSignout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.pop(context);
  }