import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import './subScreens/connected_platform.dart';
import './subScreens/recent_upload.dart';
import './subScreens/performance_metrics.dart';
import './subScreens/welcome_header.dart';
import './subScreens/quick_upload.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      title: const Text(
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
          const WelcomeHeader(), // Use the new WelcomeHeader widget
          const SizedBox(height: 24),
          QuickUpload(onStartUpload: _onStartUpload), // Use QuickUploadCard
          const SizedBox(height: 24),
          ConnectedPlatforms(onPlatformConnect: _onPlatformConnect), // Use ConnectedPlatforms
          const SizedBox(height: 24),
          RecentUploads(onViewAllUploads: _onViewAllUploads), // Use RecentUploads
          const SizedBox(height: 24),
          const PerformanceMetrics(), // Use PerformanceMetrics
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