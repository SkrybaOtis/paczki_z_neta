import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/file_utils.dart';
import '../../domain/entities/package_entity.dart';
import '../providers/packages_provider.dart';
import 'download_button.dart';
import 'package_status_badge.dart';
import 'package:hooks/hooks.dart';

class PackageCard extends ConsumerWidget {
  final PackageEntity package;

  const PackageCard({
    super.key,
    required this.package,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with status
          _PackageHeader(package: package),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and version
                _PackageTitleRow(package: package),
                
                const SizedBox(height: 8),
                
                // Description
                _PackageDescription(description: package.description),
                
                const SizedBox(height: 12),
                
                // Metadata row
                _PackageMetadata(package: package),
                
                const SizedBox(height: 12),
                
                // Tags
                if (package.tags.isNotEmpty) ...[
                  _PackageTags(tags: package.tags),
                  const SizedBox(height: 12),
                ],
                
                // Download progress or button
                _PackageActions(package: package),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PackageHeader extends StatelessWidget {
  final PackageEntity package;

  const _PackageHeader({required this.package});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'by ${package.author}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
          PackageStatusBadge(status: package.status),
        ],
      ),
    );
  }
}

class _PackageTitleRow extends StatelessWidget {
  final PackageEntity package;

  const _PackageTitleRow({required this.package});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            package.name,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            'v${package.version}',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ],
    );
  }
}

class _PackageDescription extends StatelessWidget {
  final String description;

  const _PackageDescription({required this.description});

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _PackageMetadata extends StatelessWidget {
  final PackageEntity package;

  const _PackageMetadata({required this.package});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.outline,
        );

    return Row(
      children: [
        Icon(
          Icons.storage_outlined,
          size: 14,
          color: Theme.of(context).colorScheme.outline,
        ),
        const SizedBox(width: 4),
        Text(
          FileUtils.formatFileSize(package.sizeBytes),
          style: textStyle,
        ),
        const SizedBox(width: 16),
        Icon(
          Icons.calendar_today_outlined,
          size: 14,
          color: Theme.of(context).colorScheme.outline,
        ),
        const SizedBox(width: 4),
        Text(
          _formatDate(package.createdAt),
          style: textStyle,
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _PackageTags extends StatelessWidget {
  final List<String> tags;

  const _PackageTags({required this.tags});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: tags.take(5).map((tag) => _TagChip(tag: tag)).toList(),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String tag;

  const _TagChip({required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        tag,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}

class _PackageActions extends ConsumerWidget {
  final PackageEntity package;

  const _PackageActions({required this.package});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (package.isDownloading) {
      return _DownloadProgressWidget(package: package);
    }

    return DownloadButton(
      package: package,
      onDownload: () {
        ref.read(packagesNotifierProvider.notifier).downloadPackage(package);
      },
    );
  }
}

class _DownloadProgressWidget extends ConsumerWidget {
  final PackageEntity package;

  const _DownloadProgressWidget({required this.package});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = package.downloadProgress;
    final percentage = (progress * 100).toStringAsFixed(0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '$percentage%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: () {
            ref
                .read(packagesNotifierProvider.notifier)
                .cancelDownload(package.id);
          },
          icon: const Icon(Icons.cancel_outlined, size: 18),
          label: const Text('Cancel'),
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.error,
          ),
        ),
      ],
    );
  }
}