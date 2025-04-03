import 'package:flutter/material.dart';
import 'upload_item.dart'; // Import UploadItem

class RecentUploads extends StatelessWidget {
  final VoidCallback onViewAllUploads;

  const RecentUploads({super.key, required this.onViewAllUploads});

  @override
  Widget build(BuildContext context) {
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
              onPressed: onViewAllUploads,
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
            itemBuilder: (context, index) => UploadItem(
                imageUrl: 'https://source.unsplash.com/random/?video,$index'),
          ),
        ),
      ],
    );
  }
}