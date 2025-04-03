import 'package:flutter/material.dart';
import 'package:douga2/service/image_picker_service.dart'; // Import your services
import 'package:douga2/widgets/media_source.dart';
import 'home/home_screen.dart';
import './reel_screen.dart';
import './analytics_screen.dart';
import './setting_screen.dart';
import 'dart:io';
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final ImagePickerService _imagePickerService = ImagePickerService();
  final MediaSource _mediaSource = MediaSource();

  final List<Widget> _tabs = [
    const HomeScreen(),
    const ReelScreen(),
    const SizedBox.shrink(), // Placeholder for upload
    const AnalyticsScreen(),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        if (index == 2) {
          _handleUploadAction(); // Trigger upload when middle item tapped
          return;
        }
        setState(() => _currentIndex = index);
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.amber,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.video_library), label: 'Reels'),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline, size: 32), // Larger icon
          label: 'Upload',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Analytics'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }

  Future<void> _handleUploadAction() async {
    final source = await _mediaSource.show(context);
    if (source == null) return;

    final file = await _imagePickerService.pickMedia(source);
    if (file != null) {
      // Handle the selected file (use your existing upload logic)
      _processSelectedFile(file);
    }
  }

  void _processSelectedFile(File file) {
    // Your existing upload handling logic here
    // This replaces what was in _onNewUpload()
    debugPrint('Selected file: ${file.path}');
    
    // Example: Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Selected: ${file.path.split('/').last}')),
    );
    
    // TODO: Add your actual upload implementation
  }
}