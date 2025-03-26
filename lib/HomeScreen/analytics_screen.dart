import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnalyticsScreen  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("welcome",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.amber
        ),),
      ),
    );    
  }
}