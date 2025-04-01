import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'platform_card.dart'; 

class ConnectedPlatforms extends StatelessWidget {
  final Function(String) onPlatformConnect;

  const ConnectedPlatforms({super.key, required this.onPlatformConnect});

  @override
  Widget build(BuildContext context) {
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
            PlatformCard(
                name: 'Instagram',
                icon: Iconsax.instagram,
                connected: true,
                onTap: () => onPlatformConnect('Instagram')),
            PlatformCard(
                name: 'TikTok',
                icon: Iconsax.music,
                connected: true,
                onTap: () => onPlatformConnect('TikTok')),
            // PlatformCard(...), // Add other PlatformCards here
          ],
        ),
      ],
    );
  }
}