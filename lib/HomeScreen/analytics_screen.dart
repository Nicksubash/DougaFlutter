import 'package:flutter/material.dart';

class AnalyticsScreen  extends StatelessWidget{
  const AnalyticsScreen({super.key});

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