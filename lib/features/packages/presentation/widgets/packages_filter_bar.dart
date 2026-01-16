import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/packages_provider.dart';

class PackagesFilterBar extends ConsumerWidget {
  const PackagesFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilter = ref.watch(selectedFilterProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _FilterChip(
            label: 'All',
            isSelected: selectedFilter == PackageFilter.all,
            onSelected: () {
              ref
                  .read(selectedFilterProvider.notifier)
                  .setFilter(PackageFilter.all);
            },
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Downloaded',
            isSelected: selectedFilter == PackageFilter.downloaded,
            onSelected: () {
              ref
                  .read(selectedFilterProvider.notifier)
                  .setFilter(PackageFilter.downloaded);
            },
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Available',
            isSelected: selectedFilter == PackageFilter.available,
            onSelected: () {
              ref
                  .read(selectedFilterProvider.notifier)
                  .setFilter(PackageFilter.available);
            },
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      showCheckmark: false,
      selectedColor: colorScheme.primaryContainer,
      labelStyle: TextStyle(
        color: isSelected
            ? colorScheme.onPrimaryContainer
            : colorScheme.onSurfaceVariant,
        fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
      ),
    );
  }
}