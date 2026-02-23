// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folder_stuture/core/shared/widgets/base_button.dart';
import 'package:folder_stuture/core/theme/app_button_style.dart';

class CustomElevatedButton extends BaseButton {
  const CustomElevatedButton({
    super.key,
    required super.text,
    super.onPressed,
    super.buttonStyle,
    super.buttonTextStyle,
    super.isDisabled,
    super.height,
    super.width,
    super.margin,
    super.alignment,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    this.padding,
    this.isCircle = false,
    this.textBelow = false,
  });

  final Widget? leftIcon;
  final Widget? rightIcon;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;

  /// Circular icon-only button mode
  final bool isCircle;

  /// For circle mode: show text under the circle button
  final bool textBelow;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    Widget child = isCircle
        ? _buildCircle(context, cs, tt)
        : _buildNormal(context, cs, tt);

    if (alignment != null) {
      child = Align(alignment: alignment!, child: child);
    }
    return child;
  }

  Widget _buildCircle(BuildContext context, ColorScheme cs, TextTheme tt) {
    final icon = leftIcon ?? rightIcon ?? const SizedBox.shrink();

    final _ =
        ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
          backgroundColor: cs.primary,
          foregroundColor: cs.onPrimary,
          elevation: 0,
        ).copyWith(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return cs.primary.withOpacity(0.4);
            }
            return cs.primary;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return cs.onPrimary.withOpacity(0.6);
            }
            return cs.onPrimary;
          }),
        );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: height ?? 56.h,
          width: width ?? 56.h,
          margin: margin,
          decoration:
              decoration ??
              BoxDecoration(
                shape: BoxShape.circle,
                color: cs.primary, // purely visual container
              ),
          child: ElevatedButton(
            style: buttonStyle ?? AppButtonStyles.primary(context),
            onPressed: isDisabled == true ? null : (onPressed ?? () {}),
            child: icon,
          ),
        ),
        if (textBelow)
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Text(
              text,
              style:
                  buttonTextStyle ??
                  tt.labelSmall?.copyWith(color: cs.onSurfaceVariant),
            ),
          ),
      ],
    );
  }

  Widget _buildNormal(BuildContext context, ColorScheme cs, TextTheme tt) {
    final defaultStyle =
        ElevatedButton.styleFrom(
          minimumSize: Size(width ?? double.infinity, height ?? 44.h),
          padding:
              padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          backgroundColor: cs.primary,
          foregroundColor: cs.onPrimary,
          elevation: 0,
          textStyle: tt.labelLarge,
        ).copyWith(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return cs.primary.withOpacity(0.4);
            }
            return cs.primary;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return cs.onPrimary.withOpacity(0.6);
            }
            return cs.onPrimary;
          }),
        );

    return Container(
      margin: margin,
      decoration: decoration,
      child: ElevatedButton(
        style: buttonStyle ?? defaultStyle,
        onPressed: isDisabled == true ? null : (onPressed ?? () {}),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leftIcon != null) ...[leftIcon!, SizedBox(width: 8.w)],
            Text(
              text,
              style:
                  buttonTextStyle ??
                  tt.labelLarge?.copyWith(color: cs.onPrimary),
            ),
            if (rightIcon != null) ...[SizedBox(width: 8.w), rightIcon!],
          ],
        ),
      ),
    );
  }
}
