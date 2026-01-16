
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/packages_provider.dart';

class PackagesSearchBar extends ConsumerStatefulWidget {
  const PackagesSearchBar({super.key});

  @override
  ConsumerState<PackagesSearchBar> createState() => _PackagesSearchBarState();
}

class _PackagesSearchBarState extends ConsumerState<PackagesSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _controller,
        onChanged: (value) {
          ref.read(searchQueryProvider.notifier).setQuery(value);
        },
        decoration: InputDecoration(
          hintText: 'Search packages...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    ref.read(searchQueryProvider.notifier).setQuery('');
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}