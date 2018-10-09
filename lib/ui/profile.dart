import 'package:flutter/material.dart';
import 'package:leap_app/usermanagement.dart';


class ProfileSetup extends StatefulWidget {
  @override
  _ProfileSetupState createState() => _ProfileSetupState();
}

class _ProfileSetupState extends State<ProfileSetup> {
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed:() {} ,
      ),
      
      body: new Container(

        child: new Center(child: new Text("We would like to know you better!"),),
        

        
      ),
      
    );
  }
}