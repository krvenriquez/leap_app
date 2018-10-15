import 'package:flutter/material.dart';
import 'package:leap_app/ui/profile.dart';

class ProfileSetup extends StatefulWidget {
  @override
  _ProfileSetupState createState() => _ProfileSetupState();
}

class _ProfileSetupState extends State<ProfileSetup> {
  final PageController controller = new PageController();
  @override
  Widget build(BuildContext context) {
    var page1 = new Container(
        color: Colors.black,
        child: new Container(
          height: 300.0,
          width: 300.0,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.redAccent, Colors.orangeAccent])),
          margin: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 100.0),
          child: new Center(
            child: new Container(
              padding: EdgeInsets.all(40.0),
              child: new Text("Welcome to LEAP!",
                  style: new TextStyle(fontSize: 50.0)),
            ),
          ),
        ));

    var page2 = new Container(
      color: Colors.black,
      height: 300.0,
      width: 300.0,
      child: new Card(
          margin: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 100.0),
          child: new Center(
            child: new Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.redAccent, Colors.orangeAccent])),
              child: new Column(children: <Widget>[
                new Text("Tell us more about you",
                  style: new TextStyle(fontSize: 50.0)),
                  new FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    child: new Text("Tap Here!"),
                    color: Colors.greenAccent,
                    onPressed: () {
                          Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => new NewProfile()));
                    },

                  )


              ],)
            ),
          )),
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      body: new Container(
        color: Colors.black,
        child: new PageView(
          children: <Widget>[page1, page2],
          controller: controller,
        ),
      ),
    );
  }
}
