import 'package:flutter/material.dart';
import 'package:flutter_clean_template/design_system/design_system.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, this.message, this.onRetry});

  final String? message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(DsSpacing.md),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: DsSpacing.md),
            Text(
              message ?? 'Something went wrong',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: DsSpacing.lg),
              DsButton(
                label: 'Retry',
                onPressed: onRetry,
                variant: DsButtonVariant.secondary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
