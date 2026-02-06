import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// ============================================================
/// SPACING (SizedBox)
/// ============================================================
extension SpacingExt on num {
  SizedBox get hGap => SizedBox(width: w);
  SizedBox get vGap => SizedBox(height: h);
  SizedBox get gap => SizedBox(width: w, height: h);
}

/// ============================================================
/// PADDING
/// ============================================================
extension PaddingExt on Widget {
  Widget get p16 => Padding(padding: .all(16.w), child: this);

  Widget get px16 => Padding(
    padding: .symmetric(horizontal: 16.w),
    child: this,
  );

  Widget get py16 => Padding(
    padding: .symmetric(vertical: 16.h),
    child: this,
  );

  Widget pad(EdgeInsetsGeometry padding) =>
      Padding(padding: padding, child: this);
}

/// ============================================================
/// LAYOUT
/// ============================================================
extension LayoutExt on Widget {
  Widget get expanded => Expanded(child: this);
  Widget get flexible => Flexible(child: this);
}

/// ============================================================
/// GESTURE
/// ============================================================
extension GestureExt on Widget {
  Widget onTap(VoidCallback onTap) =>
      GestureDetector(onTap: onTap, child: this);

  Widget onLongPress(VoidCallback onLongPress) =>
      GestureDetector(onLongPress: onLongPress, child: this);
}

/// ============================================================
/// VISIBILITY
/// ============================================================
extension VisibilityExt on Widget {
  Widget showIf(bool condition) => condition ? this : const SizedBox.shrink();
}

/// ============================================================
/// CONTEXT SHORTCUTS
/// ============================================================
extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get text => Theme.of(this).textTheme;
  ColorScheme get colors => Theme.of(this).colorScheme;

  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  void pop<T extends Object?>([T? result]) => Navigator.of(this).pop(result);

  Future<T?> push<T>(Widget page) =>
      Navigator.of(this).push(MaterialPageRoute(builder: (_) => page));
}
