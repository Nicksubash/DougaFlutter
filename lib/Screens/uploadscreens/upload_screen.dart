import 'package:flutter/material.dart';
import '../../../widgets/action_button.dart';
import '../../../widgets/logo_widget.dart';
import '../../../widgets/falling_icons_background.dart';
class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  bool _isUploading = false;
  double _uploadProgress = 0.0;

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
                  onPressed: _isUploading ? null : _startUpload,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadArea() {
    return Container(
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
        ],
      ),
    );
  }
}