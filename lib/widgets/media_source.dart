import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MediaSource {
  Future<String?> show(BuildContext context) async {
    return await showDialog<String>(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Upload Content',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 24),
              _buildSourceButton(
                context,
                icon: Iconsax.gallery,
                label: 'From Gallery',
                value: 'gallery',
              ),
              const SizedBox(height: 16),
              _buildSourceButton(
                context,
                icon: Iconsax.camera,
                label: 'Use Camera',
                value: 'camera',
              ),
              const SizedBox(height: 16),
              TextButton(
                child: Text('Cancel',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.error)),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

   Widget _buildSourceButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () => Navigator.pop(context, value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 12),
          Text(label),
        ],
      ),
    );
  }
}
