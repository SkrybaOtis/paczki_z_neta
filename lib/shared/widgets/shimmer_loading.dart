
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPackagesList extends StatelessWidget {
  const ShimmerPackagesList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: 5,
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: ShimmerPackageCard(),
        );
      },
    );
  }
}

class ShimmerPackageCard extends StatelessWidget {
  const ShimmerPackageCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Shimmer.fromColors(
      baseColor: colorScheme.surfaceContainerHighest,
      highlightColor: colorScheme.surface,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ShimmerBox(width: 80, height: 16),
                  _ShimmerBox(width: 60, height: 20, radius: 12),
                ],
              ),
              const SizedBox(height: 12),
              
              // Title
              _ShimmerBox(width: 200, height: 20),
              const SizedBox(height: 8),
              
              // Description
              _ShimmerBox(width: double.infinity, height: 14),
              const SizedBox(height: 4),
              _ShimmerBox(width: double.infinity, height: 14),
              const SizedBox(height: 4),
              _ShimmerBox(width: 150, height: 14),
              const SizedBox(height: 12),
              
              // Metadata
              Row(
                children: [
                  _ShimmerBox(width: 60, height: 12),
                  const SizedBox(width: 16),
                  _ShimmerBox(width: 80, height: 12),
                ],
              ),
              const SizedBox(height: 12),
              
              // Tags
              Row(
                children: [
                  _ShimmerBox(width: 50, height: 24, radius: 12),
                  const SizedBox(width: 8),
                  _ShimmerBox(width: 70, height: 24, radius: 12),
                  const SizedBox(width: 8),
                  _ShimmerBox(width: 40, height: 24, radius: 12),
                ],
              ),
              const SizedBox(height: 16),
              
              // Button
              _ShimmerBox(width: double.infinity, height: 40, radius: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const _ShimmerBox({
    required this.width,
    required this.height,
    this.radius = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}