
import 'package:flutter/material.dart';

import '../../domain/entities/package_entity.dart';

class DownloadButton extends StatelessWidget {
  final PackageEntity package;
  final VoidCallback onDownload;

  const DownloadButton({
    super.key,
    required this.package,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (package.isDownloaded) {
      return _DownloadedButton(colorScheme: colorScheme);
    }

    if (package.hasError) {
      return _ErrorButton(
        colorScheme: colorScheme,
        errorMessage: package.errorMessage,
        onRetry: onDownload,
      );
    }

    return _AvailableButton(
      colorScheme: colorScheme,
      onDownload: onDownload,
    );
  }
}

class _DownloadedButton extends StatelessWidget {
  final ColorScheme colorScheme;

  const _DownloadedButton({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: null,
        icon: const Icon(Icons.check_circle_outline, size: 18),
        label: const Text('Downloaded'),
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.onPrimaryContainer,
          disabledBackgroundColor: colorScheme.primaryContainer,
          disabledForegroundColor: colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}

class _ErrorButton extends StatelessWidget {
  final ColorScheme colorScheme;
  final String? errorMessage;
  final VoidCallback onRetry;

  const _ErrorButton({
    required this.colorScheme,
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              errorMessage!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.error,
                  ),
            ),
          ),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh, size: 18),
            label: const Text('Retry Download'),
            style: FilledButton.styleFrom(
              backgroundColor: colorScheme.errorContainer,
              foregroundColor: colorScheme.onErrorContainer,
            ),
          ),
        ),
      ],
    );
  }
}

class _AvailableButton extends StatelessWidget {
  final ColorScheme colorScheme;
  final VoidCallback onDownload;

  const _AvailableButton({
    required this.colorScheme,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: onDownload,
        icon: const Icon(Icons.download, size: 18),
        label: const Text('Download'),
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
        ),
      ),
    );
  }
}