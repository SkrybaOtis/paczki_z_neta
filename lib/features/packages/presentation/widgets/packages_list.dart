
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/package_entity.dart';
import '../providers/packages_provider.dart';
import 'package_card.dart';

class PackagesList extends ConsumerStatefulWidget {
  const PackagesList({super.key});

  @override
  ConsumerState<PackagesList> createState() => _PackagesListState();
}

class _PackagesListState extends ConsumerState<PackagesList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      ref.read(packagesNotifierProvider.notifier).loadMorePackages();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    final packages = ref.watch(searchedPackagesProvider);
    final packagesState = ref.watch(packagesNotifierProvider);

    if (packages.isEmpty) {
      return const _EmptyPackagesWidget();
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(packagesNotifierProvider.notifier).refresh();
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: packages.length + (packagesState.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= packages.length) {
            return const _LoadingMoreIndicator();
          }
          
          return _PackageListItem(
            key: ValueKey(packages[index].id),
            package: packages[index],
            index: index,
          );
        },
      ),
    );
  }
}

class _PackageListItem extends StatelessWidget {
  final PackageEntity package;
  final int index;

  const _PackageListItem({
    super.key,
    required this.package,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // Use RepaintBoundary for complex widgets
    return RepaintBoundary(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: PackageCard(package: package),
      ),
    );
  }
}

class _EmptyPackagesWidget extends StatelessWidget {
  const _EmptyPackagesWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'No packages found',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
        ],
      ),
    );
  }
}

class _LoadingMoreIndicator extends StatelessWidget {
  const _LoadingMoreIndicator();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}