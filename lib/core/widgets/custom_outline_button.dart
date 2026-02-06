// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folder_stuture/core/theme/app_button_style.dart';
import 'package:folder_stuture/core/widgets/base_button.dart';

class CustomOutlinedButton extends BaseButton {
  const CustomOutlinedButton({
    super.key,
    required super.text,
    super.onPressed,
    super.buttonStyle,
    super.buttonTextStyle,
    super.isDisabled,
    super.alignment,
    super.height,
    super.width,
    super.margin,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    this.label,
  });

  final BoxDecoration? decoration;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final Widget? label;

  @override
  Widget build(BuildContext context) {
    final _ = Theme.of(context).colorScheme;
    final _ = Theme.of(context).textTheme;

    Widget btn = Container(
      margin: margin,
      decoration: decoration,
      child: OutlinedButton(
        style: buttonStyle ?? AppButtonStyles.primary(context),
        onPressed: isDisabled == true ? null : (onPressed ?? () {}),
        child: label ?? _content(context),
      ),
    );

    if (alignment != null) {
      btn = Align(alignment: alignment!, child: btn);
    }
    return btn;
  }

  Widget _content(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leftIcon != null) ...[leftIcon!, SizedBox(width: 8.w)],
        Text(text, style: buttonTextStyle ?? tt.labelLarge),
        if (rightIcon != null) ...[SizedBox(width: 8.w), rightIcon!],
      ],
    );
  }
}
