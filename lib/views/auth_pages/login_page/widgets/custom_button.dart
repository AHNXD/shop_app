import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.width,
    this.height,
    this.color,
    this.borderRadius,
    this.boxShadow,
    required this.title,
    this.titleStyle,
    this.padding,
    this.margin, this.onTap,
  });
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Widget title;
  final TextStyle? titleStyle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(8),
        margin: margin,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? Colors.black,
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          boxShadow: boxShadow,
        ),
        child: Center(
          child:title,
        ),
      ),
    );
  }
}
