import 'package:douga2/AuthScreen/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';
import '../widgets/logo_widget.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> 
    with SingleTickerProviderStateMixin {
  // Animation controls
  final double _baseFallSpeed = 0.2; // Reduced for slower fall
  final double _shuffleIntensity = 30.0; // Reduced horizontal movement
  final int _totalIcons = 40; // Increased number of icons
  
  late AnimationController _controller;
  final Random _random = Random();
  final List<IconData> _fallingIcons = [
    Icons.videocam,
    Icons.movie,
    FontAwesomeIcons.tiktok,
    FontAwesomeIcons.instagram,
    Icons.camera_alt,
    FontAwesomeIcons.youtube,
    FontAwesomeIcons.twitter,
  ];

  List<Map<String, dynamic>> _iconStates = [];

  @override
  void initState() {
    super.initState();
    DougaLogo();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30), // Increased duration for slower animation
    )..repeat();
    
    // Initialize icon states after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) => _initializeIcons());
  }

  void _initializeIcons() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    _iconStates = List.generate(_totalIcons, (index) {
      return {
        'icon': _fallingIcons[index % _fallingIcons.length],
        'speed': _random.nextDouble() * 0.3 + 1.4, // 0.4-0.7 speed variation
        'x': _random.nextDouble() * screenWidth,
        'y': -_random.nextDouble() * screenHeight * 0.5, // Start above screen
        'size': _random.nextDouble() * 15 + 20, // 20-35 size variation
        'horizontalSpeed': _random.nextDouble() * 1.5 - 0.75, // Reduced shuffle
        'opacity': _random.nextDouble() * 0.4 + 0.3, // 0.3-0.7 initial opacity
      };
    });
    
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildFallingIcon(int index, Animation<double> animation) {
    final state = _iconStates[index];
    final screenHeight = MediaQuery.of(context).size.height;

    return Positioned(
      left: state['x'] + (animation.value * _shuffleIntensity * state['horizontalSpeed']),
      top: state['y'] + (animation.value * screenHeight * 1.5 * _baseFallSpeed * state['speed']),
      child: Opacity(
        opacity: state['opacity'] * (1 - animation.value * 0.8),
        child: Icon(
          state['icon'],
          color: Color.fromRGBO(
            128,  
            128,  
            128, 
            0.8 - animation.value * 0.5,  // Control the opacity of the green color dynamically
            ),
            size: state['size'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Colors.white.withOpacity(0.8)),
            onPressed: () => Navigator.pushReplacementNamed(context, "/home"),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A1A2E).withOpacity(0.95),
              Color(0xFF16213E).withOpacity(0.97),
              Color(0xFF0F3460),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Falling icons background
            if (_iconStates.isNotEmpty)
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Stack(
                    children: List.generate(_totalIcons, 
                      (index) => _buildFallingIcon(index, _controller)),
                  );
                },
              ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    _buildTitle(),
                    SizedBox(height: 40),
                    _buildSocialButtons(),
                    SizedBox(height: 40),
                    _buildContinueButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [const Color.fromARGB(255, 232, 217, 222), Colors.purpleAccent, Colors.blueAccent],
        stops: [0.0, 0.5, 1.0],
      ).createShader(bounds),
      child: Text(
        "Connect Your\nSocial Media",
        style: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w800,
          height: 1.2,
          shadows: [
            Shadow(
              color: Colors.white,
              blurRadius: 15,
              offset: Offset(2, 2),
            )
          ],
        ),
        textAlign: TextAlign.center,
      ),
    ),
    );
    
  }

  Widget _buildSocialButtons() {
    return Wrap(
      spacing: 25,
      runSpacing: 25,
      children: [
        _buildSocialButton(
          icon: FontAwesomeIcons.instagram,
          color: Colors.pink,
          onPressed: () => AuthService.linkSocialMedia('Instagram'),
        ),
        _buildSocialButton(
          icon: FontAwesomeIcons.tiktok,
          color: Colors.black,
          onPressed: () => AuthService.linkSocialMedia('Tiktok'),
        ),
        _buildSocialButton(
          icon: FontAwesomeIcons.youtube,
          color: Colors.red,
          onPressed: () => AuthService.linkSocialMedia('YouTube'),
        ),
      ],
    );
  }

  Widget _buildSocialButton({required IconData icon, required Color color, required Function onPressed}) {
    return ScaleTransition(
      scale: Tween(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.elasticOut,
          reverseCurve: Curves.easeInBack,
        ),
      ),
      child: InkWell(
        onTap: () => onPressed(),
        borderRadius: BorderRadius.circular(40),
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: color.withOpacity(0.9),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 15,
                spreadRadius: 3,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 30),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 500),
      opacity: 1.0,
      child: InkWell(
        onTap: () => Navigator.pushReplacementNamed(context, "/home"),
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blueAccent.shade400,
                Colors.purpleAccent.shade400,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.purple.withOpacity(0.3),
                blurRadius: 15,
                offset: Offset(0, 5),
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.arrow_forward_rounded, color: Colors.white),
              SizedBox(width: 12),
              Text(
                'Continue to App',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}