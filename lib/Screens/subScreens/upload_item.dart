import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class UploadItem extends StatelessWidget {
  final String imageUrl;

  const UploadItem({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
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
}