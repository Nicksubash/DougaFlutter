import 'package:flutter/material.dart';

class PlatformCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool connected;
  final VoidCallback onTap;

  const PlatformCard({
    super.key,
    required this.name,
    required this.icon,
    required this.connected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: connected ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: connected ? Colors.green : Colors.grey.withOpacity(0.3),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: connected ? Colors.green : Colors.grey,
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                color: connected ? Colors.green : Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (!connected)
              const Text(
                'Connect',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
      ),
    );
  }
}