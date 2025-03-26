import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';

class FallingIconsBackground extends StatefulWidget {
  final List<IconData> icons;
  final Color iconColor;
  final int totalIcons;
  final double baseFallSpeed;
  final double shuffleIntensity;

  const FallingIconsBackground({
    super.key,
    this.icons = const [
      Icons.videocam,
      FontAwesomeIcons.tiktok,
      FontAwesomeIcons.instagram,
      FontAwesomeIcons.youtube,
    ],
    this.iconColor = const Color.fromRGBO(128, 128, 128, 0.3),
    this.totalIcons = 40,
    this.baseFallSpeed = 0.2,
    this.shuffleIntensity = 30.0,
  });

  @override
  State<FallingIconsBackground> createState() => _FallingIconsBackgroundState();
}

class _FallingIconsBackgroundState extends State<FallingIconsBackground> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();
  List<Map<String, dynamic>> _iconStates = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initializeIcons());
  }

  void _initializeIcons() {
    final screenSize = MediaQuery.of(context).size;
    _iconStates = List.generate(widget.totalIcons, (index) => ({
      'icon': widget.icons[index % widget.icons.length],
      'speed': _random.nextDouble() * 0.3 + 1.4,
      'x': _random.nextDouble() * screenSize.width,
      'y': -_random.nextDouble() * screenSize.height * 0.5,
      'size': _random.nextDouble() * 15 + 20,
      'horizontalSpeed': _random.nextDouble() * 1.5 - 0.75,
      'opacity': _random.nextDouble() * 0.4 + 0.3,
    }));
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Stack(
          children: List.generate(widget.totalIcons, (index) => _buildFallingIcon(index)),
        );
      },
    );
  }

  Widget _buildFallingIcon(int index) {
    final state = _iconStates[index];
    final screenHeight = MediaQuery.of(context).size.height;
    final animationValue = _controller.value;

    return Positioned(
      left: state['x'] + (animationValue * widget.shuffleIntensity * state['horizontalSpeed']),
      top: state['y'] + (animationValue * screenHeight * 1.5 * widget.baseFallSpeed * state['speed']),
      child: Opacity(
        opacity: state['opacity'] * (1 - animationValue * 0.8),
        child: Icon(
          state['icon'],
          color: widget.iconColor.withOpacity(0.8 - animationValue * 0.5),
          size: state['size'],
        ),
      ),
    );
  }
}