import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ReelScreen extends StatefulWidget {
  @override
  _ReelScreenState createState() => _ReelScreenState();
}

class _ReelScreenState extends State<ReelScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Dummy data for demonstration
  final List<Map<String, dynamic>> _reels = List.generate(10, (index) => {
    'user': 'User ${index + 1}',
    'description': 'Amazing video content #${index + 1}',
    'likes': (index + 1) * 123,
    'comments': (index + 1) * 45,
    'shares': (index + 1) * 12,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: _buildProgressIndicator(),
      ),
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        onPageChanged: (page) => setState(() => _currentPage = page),
        itemCount: _reels.length,
        itemBuilder: (context, index) => _buildReelCard(_reels[index]),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Row(
      children: List.generate(_reels.length, (index) => Expanded(
        child: Container(
          height: 2,
          margin: EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: _currentPage == index ? Colors.white : Colors.white38,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    ),
    );
  }

  Widget _buildReelCard(Map<String, dynamic> reel) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Video Player Placeholder
        Container(
          color: Colors.grey[900],
          child: Icon(Iconsax.play, color: Colors.white, size: 50),
        ),

        // Content Overlay
        Positioned(
          bottom: 40,
          left: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(reel['user'], 
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(reel['description'], 
                style: TextStyle(color: Colors.white)),
              SizedBox(height: 16),
              _buildMusicInfo(),
            ],
          ),
        ),

        // Right Action Buttons
        Positioned(
          bottom: 40,
          right: 16,
          child: Column(
            children: [
              _buildActionButton(Iconsax.heart, reel['likes']),
              SizedBox(height: 20),
              _buildActionButton(Iconsax.message, reel['comments']),
              SizedBox(height: 20),
              _buildActionButton(Iconsax.share, reel['shares']),
              SizedBox(height: 20),
              _buildProfileButton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMusicInfo() {
    return Row(
      children: [
        Icon(Iconsax.musicnote, color: Colors.white, size: 16),
        SizedBox(width: 8),
        Text('Original Sound - ', style: TextStyle(color: Colors.white)),
        Expanded(
          child: Text('Artist Name', 
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, int count) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        SizedBox(height: 4),
        Text('${count.formatCount()}', 
          style: TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }

  Widget _buildProfileButton() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage('https://i.pravatar.cc/150'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// Extension for formatting numbers
extension NumberFormatting on int {
  String formatCount() {
    if (this >= 1000000) return '${(this / 1000000).toStringAsFixed(1)}M';
    if (this >= 1000) return '${(this / 1000).toStringAsFixed(1)}K';
    return toString();
  }
}