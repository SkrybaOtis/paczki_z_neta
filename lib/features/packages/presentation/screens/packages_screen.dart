
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/packages_provider.dart';
import '../widgets/packages_list.dart';
import '../widgets/packages_filter_bar.dart';
import '../widgets/packages_search_bar.dart';
import '../../../../shared/widgets/app_error_widget.dart';
import '../../../../shared/widgets/shimmer_loading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PackagesScreen extends ConsumerWidget {
  const PackagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packagesState = ref.watch(packagesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('JSON Packages'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(packagesProvider.notifier).refresh();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const PackagesSearchBar(),
          const PackagesFilterBar(),
          Expanded(
            child: _buildContent(context, ref, packagesState),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    PackagesState state,
  ) {
    if (state.isLoading) {
      return const ShimmerPackagesList();
    }

    if (state.errorMessage != null && state.packages.isEmpty) {
      return AppErrorWidget(
        message: state.errorMessage!,
        onRetry: () {
          ref.read(packagesProvider.notifier).loadPackages();
        },
      );
    }

    return const PackagesList();
  }
}