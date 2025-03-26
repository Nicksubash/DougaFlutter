import 'package:flutter/material.dart';

class SocialMediaButton extends StatelessWidget{
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;
  final Animation<double>? scaleAnimation;

  // final String platfrom;
  // final Function onPressed;

  const SocialMediaButton({
    super.key,
    required this.icon,
    required this.color,
    required this.onPressed,
    this.scaleAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation ?? const AlwaysStoppedAnimation(1.0),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(40),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withAlpha((0.9 * 255).toInt()),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(128,29,119,92),
                blurRadius: 15,
                spreadRadius: 4,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child:Icon(icon, color: Colors.white,size: 30,)
        ),
      ),
      );  
  }
}