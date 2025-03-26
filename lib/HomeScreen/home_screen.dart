import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildMultiUploadButton(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        '',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: const Icon(Iconsax.notification),
          onPressed: () {
            // TODO: Implement notification functionality
          },
        ),
        IconButton(
          icon: const Icon(Iconsax.setting_2),
          onPressed: () {
            // TODO: Implement settings functionality
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeHeader(),
          const SizedBox(height: 24),
          _buildQuickUploadCard(),
          const SizedBox(height: 24),
          _buildConnectedPlatforms(),
          const SizedBox(height: 24),
          _buildRecentUploads(),
          const SizedBox(height: 24),
          _buildPerformanceMetrics(),
        ],
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    String gretting = _getGreeting();
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$gretting, Creator! 👋',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Ready to share your content with the world?',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

//for showing greeting dynamically
  String _getGreeting(){
    int hour = DateTime.now().hour;
    if(hour<12){
      return ('Good morning!');
    }else if(hour<18){
      return ('Good afternoon!');
    }else{
      return('Good evening!');
    }
  }

  Widget _buildQuickUploadCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.purpleAccent, Colors.blueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Icon(Iconsax.video_play, size: 40, color: Colors.white),
          const SizedBox(height: 16),
          const Text(
            'Upload to All Platforms',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Select video once, publish everywhere',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Iconsax.export),
            label: const Text('Start Upload'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.purpleAccent,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: _onStartUpload,
          ),
        ],
      ),
    );
  }

  Widget _buildConnectedPlatforms() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Connected Platforms',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          childAspectRatio: 1.2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _buildPlatformCard('Instagram', Iconsax.instagram, true),
            _buildPlatformCard('TikTok', Iconsax.music, true),
            // _buildPlatformCard('YouTube', Iconsax.youtube, false),
            // _buildPlatformCard('Twitter', Iconsax.twitter, false),
            // _buildPlatformCard('Facebook', Iconsax.facebook, true),
            // _buildPlatformCard('LinkedIn', Iconsax.linkedin, false),
          ],
        ),
      ],
    );
  }

  Widget _buildPlatformCard(String name, IconData icon, bool connected) {
    return GestureDetector(
      onTap: () => _onPlatformConnect(name),
      child: Container(
        decoration: BoxDecoration(
          color: connected 
            ? Colors.green.withOpacity(0.1) 
            : Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: connected 
              ? Colors.green 
              : Colors.grey.withOpacity(0.3),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon, 
              size: 32, 
              color: connected ? Colors.green : Colors.grey,
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                color: connected ? Colors.green : Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (!connected)
              const Text(
                'Connect',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentUploads() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Uploads',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: _onViewAllUploads,
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) => _buildUploadItem(index),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadItem(int index) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage('https://source.unsplash.com/random/?video,$index'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Row(
              children: [
                const Icon(Iconsax.clock, size: 14, color: Colors.white),
                const SizedBox(width: 4),
                const Text(
                  '2h ago',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                const Spacer(),
                const Icon(Iconsax.eye, size: 14, color: Colors.white),
                const SizedBox(width: 4),
                const Text(
                  '1.2K',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Performance Overview',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _buildMetricCard('Total Views', '124K', Iconsax.eye),
            _buildMetricCard('Engagement Rate', '8.2%', Iconsax.graph),
            _buildMetricCard('New Followers', '2.4K', Iconsax.profile_2user),
            _buildMetricCard('Avg. Watch Time', '1.2m', Iconsax.clock),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.blueAccent),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMultiUploadButton() {
    return FloatingActionButton.extended(
      icon: const Icon(Iconsax.export),
      label: const Text('New Upload'),
      backgroundColor: Colors.purpleAccent,
      foregroundColor: Colors.white,
      onPressed: _onNewUpload,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  // Placeholder methods for navigation and actions
  void _onStartUpload() {
    // TODO: Implement upload functionality
  }

  void _onPlatformConnect(String platformName) {
    // TODO: Implement platform connection logic
  }

  void _onViewAllUploads() {
    // TODO: Implement view all uploads navigation
  }

  void _onNewUpload() {
    // TODO: Implement new upload functionality
  }
}