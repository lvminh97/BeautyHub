import 'package:flutter/material.dart';
import 'package:selling_food_store/shared/utils/app_color.dart';

class GeneralButton extends StatelessWidget {
  final String title;
  final double? radius;
  final Widget? child;
  final bool? isTransparent;
  final bool? isStroke;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final Function() onClick;

  const GeneralButton({
    super.key,
    required this.title,
    this.radius,
    this.child,
    this.isTransparent,
    this.isStroke,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        onClick();
      },
      minWidth: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 4.0),
        side: isStroke == true
            ? BorderSide(width: 1.0, color: borderColor ?? AppColor.primaryAppColor)
            : BorderSide.none,
      ),
      color: isTransparent == true
          ? AppColor.whiteColor
          : backgroundColor ?? AppColor.primaryAppColor,
      child: child ??
          Text(
            title,
            style: TextStyle(
              color: textColor ?? AppColor.whiteColor,
            ),
          ),
    );
  }
}
