// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButtonStyles {
  AppButtonStyles._();

  // ------------------------------------------------------------
  // Elevated (Filled) - semantic presets
  // ------------------------------------------------------------

  static ButtonStyle primary(BuildContext context, {double radius = 8}) {
    final cs = Theme.of(context).colorScheme;
    return ElevatedButton.styleFrom(
      backgroundColor: cs.primary,
      foregroundColor: cs.onPrimary,
      elevation: 0,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius.r),
      ),
    );
  }

  static ButtonStyle secondary(BuildContext context, {double radius = 12}) {
    final cs = Theme.of(context).colorScheme;
    return ElevatedButton.styleFrom(
      backgroundColor: cs.secondary,
      foregroundColor: cs.onSecondary,
      elevation: 0,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius.r),
      ),
    );
  }

  static ButtonStyle danger(BuildContext context, {double radius = 12}) {
    final cs = Theme.of(context).colorScheme;
    return ElevatedButton.styleFrom(
      backgroundColor: cs.error,
      foregroundColor: cs.onError,
      elevation: 0,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius.r),
      ),
    );
  }

  /// Good for subtle actions (like "Cancel", "Skip")
  static ButtonStyle surface(BuildContext context, {double radius = 12}) {
    final cs = Theme.of(context).colorScheme;
    return ElevatedButton.styleFrom(
      backgroundColor: cs.surfaceContainerHighest,
      foregroundColor: cs.onSurface,
      elevation: 0,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius.r),
      ),
    );
  }

  /// Example: danger background with low opacity
  static ButtonStyle dangerTint(BuildContext context, {double radius = 12}) {
    final cs = Theme.of(context).colorScheme;
    return ElevatedButton.styleFrom(
      backgroundColor: cs.error.withOpacity(0.12),
      foregroundColor: cs.error,
      elevation: 0,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius.r),
      ),
    );
  }

  // ------------------------------------------------------------
  // Outlined - semantic presets
  // ------------------------------------------------------------

  static ButtonStyle outline(BuildContext context, {double radius = 12}) {
    final cs = Theme.of(context).colorScheme;
    return OutlinedButton.styleFrom(
      backgroundColor: Colors.transparent,
      foregroundColor: cs.onSurface,
      side: BorderSide(color: cs.outline),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius.r),
      ),
    );
  }

  static ButtonStyle outlinePrimary(
    BuildContext context, {
    double radius = 12,
  }) {
    final cs = Theme.of(context).colorScheme;
    return OutlinedButton.styleFrom(
      backgroundColor: Colors.transparent,
      foregroundColor: cs.primary,
      side: BorderSide(color: cs.primary),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius.r),
      ),
    );
  }

  static ButtonStyle outlineDanger(BuildContext context, {double radius = 12}) {
    final cs = Theme.of(context).colorScheme;
    return OutlinedButton.styleFrom(
      backgroundColor: Colors.transparent,
      foregroundColor: cs.error,
      side: BorderSide(color: cs.error),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius.r),
      ),
    );
  }

  // ------------------------------------------------------------
  // Text button - semantic presets
  // ------------------------------------------------------------

  static ButtonStyle text(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TextButton.styleFrom(
      foregroundColor: cs.primary,
      padding: EdgeInsets.zero,
      elevation: 0,
    );
  }

  /// Equivalent of your old "none"
  static ButtonStyle none() {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
      elevation: WidgetStateProperty.all<double>(0),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
      side: WidgetStateProperty.all<BorderSide>(
        const BorderSide(color: Colors.transparent),
      ),
    );
  }
}
