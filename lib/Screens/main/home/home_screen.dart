import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:douga2/widgets/media_source.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker
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
  File? _selectedMedia; // To store the picked file (image or video)
  final ImagePickerService _imagePickerService = ImagePickerService();
  final MediaSource _mediaSource = MediaSource();
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
      title: const Text('', style: TextStyle(fontWeight: FontWeight.bold)),
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
          const WelcomeHeader(), // Use the new WelcomeHeader widget
          const SizedBox(height: 24),
          QuickUpload(), // Use QuickUploadCard
          const SizedBox(height: 24),
          ConnectedPlatforms(
            onPlatformConnect: _onPlatformConnect,
          ), // Use ConnectedPlatforms
          const SizedBox(height: 24),
          RecentUploads(
            onViewAllUploads: _onViewAllUploads,
          ), // Use RecentUploads
          const SizedBox(height: 24),
          const PerformanceMetrics(), // Use PerformanceMetrics
          const SizedBox(height: 24),
          // Display the selected media (for testing)
          if (_selectedMedia != null)
            _selectedMedia!.path.endsWith('.mp4') //check if its video
                ? Text('Selected Video : ${_selectedMedia!.path}')
                : Image.file(_selectedMedia!, height: 200),
        ],
      ),
    );
  }

  // ... rest of your HomeScreen class ( _buildAppBar, _buildMultiUploadButton, _onStartUpload, _onPlatformConnect, _onViewAllUploads, _onNewUpload )
  Widget _buildMultiUploadButton() {
    return FloatingActionButton.extended(
      icon: const Icon(Iconsax.export),
      label: const Text('New Upload'),
      backgroundColor: Colors.purpleAccent,
      foregroundColor: Colors.white,
      onPressed: _onNewUpload,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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

  Future<void> _onNewUpload() async {
    final source = await _mediaSource.show(context);
    if (source == null) return;

    final file = await _imagePickerService.pickMedia(source);
    if (file == null) return;

    setState(() => _selectedMedia = file);
    // TODO: Call upload service
  }
}
