import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'metric_card.dart';

class PerformanceMetrics extends StatelessWidget {
  const PerformanceMetrics({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Performance Overview',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            MetricCard(
                title: 'Total Views', value: '124K', icon: Iconsax.eye),
            MetricCard(
                title: 'Engagement Rate', value: '8.2%', icon: Iconsax.graph),
            MetricCard(
                title: 'New Followers',
                value: '2.4K',
                icon: Iconsax.profile_2user),
            MetricCard(
                title: 'Avg. Watch Time', value: '1.2m', icon: Iconsax.clock),
          ],
        ),
      ],
    );
  }
}