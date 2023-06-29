import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
void main() async{
  runApp(Myapp());
}
class Myapp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Play(),
    );
  }
}

