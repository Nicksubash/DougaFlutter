import 'package:flutter/material.dart';

class GradientTitle extends StatelessWidget {
  final String text;
  final List<Color> gradientColors;
  final List<double> gradientStops;

  const GradientTitle({
    super.key,
    required this.text,
    this.gradientColors = const [Colors.pinkAccent, Colors.purpleAccent, Colors.blueAccent],
    this.gradientStops = const [0.0, 0.5, 1.0],
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: gradientColors,
        stops: gradientStops,
      ).createShader(bounds),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w800,
          height: 1.2,
          color: Colors.white, // Base color for gradient masking
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}