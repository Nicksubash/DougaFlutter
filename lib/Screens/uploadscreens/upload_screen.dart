import 'package:douga2/service/image_picker_service.dart';
import 'package:douga2/widgets/media_source.dart';
import 'package:flutter/material.dart';
import '../../../widgets/action_button.dart';
import '../../../widgets/logo_widget.dart';
import '../../../widgets/falling_icons_background.dart';
import 'dart:io';
class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? _selectedMedia; 
  bool _isUploading = false;
  double _uploadProgress = 0.0;
  final ImagePickerService _imagePickerService = ImagePickerService();
  final MediaSource _mediaSource = MediaSource();

  void _startUpload() {
    setState(() {
      _isUploading = true;
      _uploadProgress = 0.0;
    });

    // Simulate upload progress
    const totalSteps = 100;
    for (int i = 0; i <= totalSteps; i++) {
      Future.delayed(Duration(milliseconds: i * 50), () {
        if (mounted) {
          setState(() {
            _uploadProgress = i / totalSteps;
            if (i == totalSteps) _isUploading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with falling icons
          const FallingIconsBackground(),

          // Main content
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                const DougaLogo(),
                const SizedBox(height: 40),

                // Upload area
                _buildUploadArea(),

                // Progress indicator
                if (_isUploading) ...[
                  const SizedBox(height: 20),
                  LinearProgressIndicator(
                    value: _uploadProgress,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${(_uploadProgress * 100).toStringAsFixed(1)}%',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],

                // Upload button
                const SizedBox(height: 40),
                ActionButton(
                  label: _isUploading ? 'Uploading...' : 'Upload Video',
                  onPressed: _selectedMedia == null || _isUploading ? null : _startUpload,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar:BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.video_call), label: 'Reel'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Analytics'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: 1,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // Handle navigation here
        },
        iconSize: 30.0,
      )
    );
  }
  Widget _buildUploadArea() {
  return GestureDetector(
    onTap: _onUploadAreaTapped,  // Open the dialog to select media
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          if (_selectedMedia == null) ...[  // Check if no media is selected
            Icon(
              Icons.cloud_upload,
              size: 60,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 10),
            Text(
              'Drag and drop your video here',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 5),
            Text(
              'or click to browse files',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ] else ...[  // If a media file is selected
            _selectedMedia!.path.endsWith('.mp4')
                ? Column(
                    children: [
                      const Icon(Icons.videocam, size: 60),
                      const SizedBox(height: 10),
                      Text('Video selected'),
                    ],
                  )
                : Image.file(
                    _selectedMedia!,  // Display selected image
                    height: 200,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedMedia = null;  // Remove selected file
                });
              },
              child: const Text("Remove File"),
            ),
          ],
        ],
      ),
    ),
  );
}

void _onUploadAreaTapped() async {
  final source = await MediaSource().show(context);  // Get the source (gallery/camera)

  if (source != null) {
    final file = await _imagePickerService.pickMedia(source);  // Pick media based on source

    if (file != null) {
      setState(() {
        _selectedMedia = file;  // Use _selectedMedia to update the class-level variable
      });
    }
  }
}
}