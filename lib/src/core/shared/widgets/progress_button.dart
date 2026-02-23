import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProgressText extends StatelessWidget {
  const CustomProgressText({
    super.key,
    this.width,
    this.style,
    this.fontSize,
    this.lable = '',
    this.textAlign = TextAlign.center,
    this.textColor = const Color(0xFFFFFFFF),
  });

  final double? width;
  final String lable;
  final Color? textColor;
  final double? fontSize;
  final TextStyle? style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          lable,
          textAlign: textAlign,
          style: style ?? TextStyle(fontSize: fontSize, color: textColor),
        ),
        SizedBox(
          width: width,
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              TyperAnimatedText(
                '...',
                textStyle:
                    style ?? TextStyle(fontSize: fontSize, color: textColor),
                textAlign: TextAlign.center,
                speed: const Duration(milliseconds: 500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomProgressButton extends StatelessWidget {
  const CustomProgressButton({
    super.key,
    this.style,
    this.fontSize,
    this.textColor,
    this.lable = '',
    this.typer = false,
    this.indicator = true,
    this.textAlign = TextAlign.center,
    this.indicatorColor = const Color(0XFFFFFFFF),
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final bool typer;
  final String lable;
  final bool indicator;
  final double? fontSize;
  final TextStyle? style;
  final TextAlign? textAlign;
  final Color? textColor, indicatorColor;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        if (indicator) CupertinoActivityIndicator(color: indicatorColor),
        if (indicator) SizedBox(width: 4.w),
        Text(
          lable,
          textAlign: textAlign,
          style: style ?? TextStyle(fontSize: fontSize, color: indicatorColor),
        ),
        if (typer)
          SizedBox(
            width: 12.w,
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                TyperAnimatedText(
                  '...',
                  textStyle:
                      style ?? TextStyle(fontSize: fontSize, color: textColor),
                  textAlign: TextAlign.center,
                  speed: const Duration(milliseconds: 500),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
