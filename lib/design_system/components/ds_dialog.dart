import 'package:flutter/material.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_spacing.dart';

abstract class DsDialog {
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    String? message,
    Widget? content,
    String? confirmLabel,
    String? cancelLabel,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool isDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: isDismissible,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: content ??
            (message != null
                ? Text(message)
                : null),
        actions: [
          if (cancelLabel != null)
            TextButton(
              onPressed: () {
                onCancel?.call();
                Navigator.of(context).pop();
              },
              child: Text(cancelLabel),
            ),
          if (confirmLabel != null)
            FilledButton(
              onPressed: () {
                onConfirm?.call();
                Navigator.of(context).pop(true);
              },
              child: Text(confirmLabel),
            ),
        ],
        actionsPadding: const EdgeInsets.all(DsSpacing.md),
      ),
    );
  }
}
