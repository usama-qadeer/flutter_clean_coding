// ignore_for_file: deprecated_member_use

import 'package:folder_stuture/core/extensions/extensions.dart';
import 'package:folder_stuture/core/shared/widgets/custom_elevted_button.dart';
import 'package:folder_stuture/main_exports.dart';

class AppDialogs {
  AppDialogs._(); // no instance

  // 🔹 Permission required dialog
  static Future<void> permissionRequired({
    required BuildContext context,
    required String message,
    bool showSettings = false,
    VoidCallback? onRetry,
    VoidCallback? onOpenSettings,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Permission Required"),
        content: Text(message),
        actions: [
          if (showSettings)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onOpenSettings?.call();
              },
              child: const Text("Open Settings"),
            ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onRetry?.call();
            },
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }

  // 🔹 Generic error dialog
  static Future<void> error({
    required BuildContext context,
    required String message,
    String title = "Error",
  }) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  // 🔹 Confirm dialog (yes/no)
  static Future<bool?> confirm({
    required BuildContext context,
    required String title,
    required String message,
    String yesText = "Yes",
    String noText = "Cancel",
  }) {
    return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(noText),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(yesText),
          ),
        ],
      ),
    );
  }

  static Future<void> status({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = "Go Home",
    VoidCallback? onButtonPressed,

    IconData icon = Icons.check,
    Color? accentColor,
    bool barrierDismissible = false,
    bool showClose = true,
    double maxWidth = 360,
  }) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final acc = accentColor ?? cs.primary;

    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(24, 26, 24, 20),
                decoration: BoxDecoration(
                  color: cs.surface,
                  borderRadius: BorderRadius.circular(18.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                        cs.brightness == Brightness.dark ? 0.35 : 0.12,
                      ),
                      blurRadius: 18,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 86.w,
                      height: 86.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: acc.withOpacity(0.12),
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        width: 58.w,
                        height: 58.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: acc,
                        ),
                        child: Icon(icon, color: cs.onPrimary, size: 30),
                      ),
                    ),

                    16.vGap,

                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: cs.onSurface,
                      ),
                    ),

                    10.vGap,

                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: cs.onSurface.withOpacity(0.75),
                      ),
                    ),

                    const SizedBox(height: 18),
                    CustomElevatedButton(
                      text: "Go Home",
                      onPressed: onButtonPressed,
                    ),
                  ],
                ),
              ),

              if (showClose)
                Positioned(
                  right: 8,
                  top: 8,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, color: cs.outline),
                    splashRadius: 18,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Convenience helpers (optional)
  static Future<void> success({
    required BuildContext context,
    String title = "Success!",
    required String message,
    String buttonText = "Go Home",
    VoidCallback? onButtonPressed,
  }) {
    return status(
      context: context,
      title: title,
      message: message,
      buttonText: buttonText,
      onButtonPressed: onButtonPressed,
      icon: Icons.check,
      accentColor: const Color(0xFF22C55E),
    );
  }

  static Future<void> failure({
    required BuildContext context,
    String title = "Error",
    required String message,
    String buttonText = "OK",
    VoidCallback? onButtonPressed,
  }) {
    return status(
      context: context,
      title: title,
      message: message,
      buttonText: buttonText,
      onButtonPressed: onButtonPressed,
      icon: Icons.close,
      accentColor: const Color(0xFFEF4444), // red
    );
  }

  static Future<void> warning({
    required BuildContext context,
    String title = "Warning",
    required String message,
    String buttonText = "OK",
    VoidCallback? onButtonPressed,
  }) {
    return status(
      context: context,
      title: title,
      message: message,
      buttonText: buttonText,
      onButtonPressed: onButtonPressed,
      icon: Icons.warning_rounded,
      accentColor: const Color(0xFFF59E0B), // amber
    );
  }
}
