import 'package:flutter/material.dart';
import 'package:leap_app/usermanagement.dart';


void main() {
  runApp(
    new MaterialApp(
      title: "LEAP Companion",
      debugShowCheckedModeBanner: false,
      // checkerboardOffscreenLayers: false,
      debugShowMaterialGrid: false,
      home: UserManagement().handleAuth(),
   )
  );
}



