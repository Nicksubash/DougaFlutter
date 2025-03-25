import 'package:flutter/material.dart';

class SocialMediaButton extends StatelessWidget{
  final String platfrom;
  final Function onPressed;

  SocialMediaButton({required this.platfrom, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:() => onPressed(),
      child: Text('Link With $platfrom'),
      );    
  }
}