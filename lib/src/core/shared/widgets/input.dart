import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_image_view.dart';

class AppInput extends StatefulWidget {
  const AppInput({
    super.key,
    this.label,
    this.labelText,
    this.hintText,
    this.helperText,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmit,
    this.helperStyle,
    this.hintStyle,
    this.style,
    this.labelStyle,
    this.onTap,
    this.validator,
    this.readOnly = false,
    this.autofocus = false,
    this.obscureText = false,
    this.maxLines = 1,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.onTapPrefix,
    this.onTapSuffix,
    this.fillColor,
    this.contentPadding,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
  });

  // Optional label shown above field (like your current widget)
  final String? label;

  // Field label (inside decoration)
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final TextStyle? helperStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? style;

  final TextEditingController? controller;
  final FocusNode? focusNode;

  final void Function(String)? onChanged;
  final void Function(String)? onSubmit;
  final void Function()? onTap;

  final String? Function(String?)? validator;

  final bool readOnly;
  final bool autofocus;
  final bool obscureText;
  final int maxLines;

  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;

  // Either provide widget prefix/suffix OR image path icons
  final Widget? prefix;
  final Widget? suffix;
  final String? prefixIcon;
  final String? suffixIcon;

  final VoidCallback? onTapPrefix;
  final VoidCallback? onTapSuffix;

  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;

  // Optional border overrides
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  late final FocusNode _focusNode;
  late final TextEditingController _controller;

  bool _ownsFocusNode = false;
  bool _ownsController = false;

  @override
  void initState() {
    super.initState();

    if (widget.focusNode == null) {
      _focusNode = FocusNode();
      _ownsFocusNode = true;
    } else {
      _focusNode = widget.focusNode!;
    }

    if (widget.controller == null) {
      _controller = TextEditingController();
      _ownsController = true;
    } else {
      _controller = widget.controller!;
    }

    // Submit on blur (same behavior as your current code)
    if (widget.onSubmit != null) {
      _focusNode.addListener(_handleFocusChange);
    }
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus) {
      widget.onSubmit?.call(_controller.text);
    }
  }

  @override
  void dispose() {
    if (widget.onSubmit != null) {
      _focusNode.removeListener(_handleFocusChange);
    }
    if (_ownsFocusNode) _focusNode.dispose();
    if (_ownsController) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final field = TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      validator: widget.validator,
      inputFormatters: widget.inputFormatters,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autocorrect: false,
      autofocus: widget.autofocus,
      readOnly: widget.readOnly,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      obscureText: widget.obscureText,
      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      maxLines: widget.maxLines,
      style: widget.style ?? tt.bodyMedium?.copyWith(color: cs.onSurface),

      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: widget.fillColor ?? cs.surfaceContainerHighest,

        labelText: widget.labelText,
        hintText: widget.hintText,
        helperText: widget.helperText,

        labelStyle:
            widget.labelStyle ??
            tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
        hintStyle:
            widget.hintStyle ??
            tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
        helperStyle:
            widget.helperStyle ??
            tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),

        contentPadding:
            widget.contentPadding ??
            EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),

        prefixIcon: _buildPrefix(context),
        suffixIcon: _buildSuffix(context),

        enabledBorder:
            widget.enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: cs.outlineVariant),
            ),

        focusedBorder:
            widget.focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: cs.primary, width: 1.5),
            ),

        errorBorder:
            widget.errorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: cs.error),
            ),

        focusedErrorBorder:
            widget.errorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: cs.error, width: 1.5),
            ),
      ),
    );

    if (widget.label == null) return field;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label!,
          style: tt.labelLarge?.copyWith(color: cs.onSurface),
        ),
        SizedBox(height: 6.h),
        field,
      ],
    );
  }

  Widget? _buildPrefix(BuildContext context) {
    if (widget.prefix != null) return widget.prefix;
    if (widget.prefixIcon == null) return null;

    return InkWell(
      onTap: widget.onTapPrefix,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Center(
          child: CustomImageView(
            width: 20.w,
            height: 20.w,
            fit: BoxFit.contain,
            imagePath: widget.prefixIcon,
          ),
        ),
      ),
    );
  }

  Widget? _buildSuffix(BuildContext context) {
    if (widget.suffix != null) return widget.suffix;
    if (widget.suffixIcon == null) return null;

    return InkWell(
      onTap: widget.onTapSuffix,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Center(
          child: CustomImageView(
            width: 18.w,
            height: 18.w,
            fit: BoxFit.contain,
            imagePath: widget.suffixIcon,
          ),
        ),
      ),
    );
  }
}
