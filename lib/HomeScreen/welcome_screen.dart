import 'package:douga2/AuthScreen/auth_service.dart';
import 'package:douga2/widgets/falling_icons_background.dart';
import 'package:douga2/widgets/gradient_title.dart';
import 'package:douga2/widgets/social_media_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
              Color(0xFF0F3460),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            const FallingIconsBackground(),
            _buildContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
  return Center(
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const GradientTitle(text: "Connect Your\nSocial Media"),
          const SizedBox(height: 40),
          _buildSocialButtons(),
          const SizedBox(height: 40),
          _buildContinueButton(context),
        ],
      ),
    ),
  );
}

  Widget _buildSocialButtons() {
  return Wrap(
    spacing: 25,
    runSpacing: 25,
    children: [
      SocialMediaButton(
        icon: FontAwesomeIcons.instagram,
        color: Colors.pink,
        onPressed: () => AuthService.linkSocialMedia("Instagram"),
      ),
      SocialMediaButton(
        icon: FontAwesomeIcons.tiktok,
        color: Colors.black,
        onPressed: () => AuthService.linkSocialMedia("TikTok"),
      ),
      SocialMediaButton(
        icon: FontAwesomeIcons.youtube,
        color: Colors.red,
        onPressed: () => AuthService.linkSocialMedia("YouTube"),
      ),
    ],
  );
}


  Widget _buildContinueButton(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushReplacementNamed(context, "/home"),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Colors.purple,
              blurRadius: 15,
              offset: Offset(0, 5),
            )
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 12),
            Text(
              'Skip for now ',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
                letterSpacing: 0.5,
              ),
            ),
            Icon(Icons.arrow_forward_rounded, color: Colors.white),
          ],
        ),
      ),
    );
  }
}