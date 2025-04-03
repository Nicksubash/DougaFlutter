import 'package:douga2/widgets/media_source.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'subScreens/connected_platform.dart';
import 'subScreens/recent_upload.dart';
import 'subScreens/performance_metrics.dart';
import 'subScreens/welcome_header.dart';
import 'subScreens/quick_upload.dart';
import 'dart:io';
import '../../../service/image_picker_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _selectedMedia;
  final ImagePickerService _imagePickerService = ImagePickerService();
  final MediaSource _mediaSource = MediaSource();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(), // Restore original app bar
      body: _buildBody(),
      // FloatingActionButton removed (now handled by bottom nav)
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('', style: TextStyle(fontWeight: FontWeight.bold)),
      actions: [
        IconButton(
          icon: const Icon(Iconsax.notification),
          onPressed: () {/* TODO */},
        ),
        IconButton(
          icon: const Icon(Iconsax.setting_2),
          onPressed: () {/* TODO */},
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
          const WelcomeHeader(),
          const SizedBox(height: 24),
          QuickUpload(onStartUpload: _onStartUpload),
          const SizedBox(height: 24),
          ConnectedPlatforms(onPlatformConnect: _onPlatformConnect),
          const SizedBox(height: 24),
          RecentUploads(onViewAllUploads: _onViewAllUploads),
          const SizedBox(height: 24),
          const PerformanceMetrics(),
          const SizedBox(height: 24),
          if (_selectedMedia != null)
            _selectedMedia!.path.endsWith('.mp4')
                ? Text('Selected Video: ${_selectedMedia!.path}')
                : Image.file(_selectedMedia!, height: 200),
        ],
      ),
    );
  }

  // Keep all your existing methods but remove _buildMultiUploadButton:
  void _onStartUpload() {/* Your existing implementation */}
  void _onPlatformConnect(String platformName) {/* Your existing implementation */}
  void _onViewAllUploads() {/* Your existing implementation */}
  
  // Keep this for when you need to trigger upload from other places
  Future<void> _onNewUpload() async {
    final source = await _mediaSource.show(context);
    if (source == null) return;

    final file = await _imagePickerService.pickMedia(source);
    if (file != null) {
      setState(() => _selectedMedia = file);
      // TODO: Call your upload service
    }
  }
}