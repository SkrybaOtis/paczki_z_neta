
import 'package:flutter/material.dart';

import '../../domain/entities/package_entity.dart';

class PackageStatusBadge extends StatelessWidget {
  final PackageStatus status;

  const PackageStatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final (color, icon, label) = _getStatusConfig(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }

  (Color, IconData, String) _getStatusConfig(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return switch (status) {
      PackageStatus.available => (
          colorScheme.primary,
          Icons.cloud_outlined,
          'Available',
        ),
      PackageStatus.downloading => (
          colorScheme.tertiary,
          Icons.downloading,
          'Downloading',
        ),
      PackageStatus.downloaded => (
          Colors.green,
          Icons.check_circle_outline,
          'Downloaded',
        ),
      PackageStatus.error => (
          colorScheme.error,
          Icons.error_outline,
          'Error',
        ),
    };
  }
}