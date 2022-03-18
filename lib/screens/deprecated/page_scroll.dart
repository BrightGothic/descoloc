/* import 'dart:ui';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class scroll extends StatefulWidget{
  @override
  State<scroll> createState() => _scrollState();
}

class _scrollState extends State<scroll> {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      color : Colors.lightBlue,
      debugShowCheckedModeBanner: false,
      title: 'MonApp',
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: (){print("iii");},),
          title: const Text(
            'Unit Converter',
            style: TextStyle(fontSize: 20.0),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
              child: const Text(
                "Test",
              ),
            ),
            Builder(
                builder: (context) {
                  return TextButton( child: Text("Test"), onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
                  },);
                }
            )
          ],
          backgroundColor: Colors.amberAccent,
        ),
        body: Container(
          child: affichage(true),
        ),
      ),
    );
  }
}


 */