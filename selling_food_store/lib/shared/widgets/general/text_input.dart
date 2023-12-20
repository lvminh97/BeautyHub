import 'package:flutter/material.dart';

import '../../utils/app_color.dart';

class TextInput extends StatelessWidget {
  final String? title;
  final String? label;
  final String? hint;
  final String? error;
  final String? help;
  final TextEditingController textController;
  final bool? isVisible;
  final Widget? suffixWidget;
  final IconData? prefixIcon;
  final bool? isHaveTitle;

  const TextInput({
    Key? key,
    this.title,
    this.label,
    this.hint,
    required this.textController,
    this.isVisible,
    this.error,
    this.suffixWidget,
    this.prefixIcon,
    this.help,
    this.isHaveTitle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        isHaveTitle == true
            ? Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  title!,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: AppColor.darkColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : const SizedBox(),
        TextField(
          controller: textController,
          obscureText: isVisible ?? true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8.0),
            labelText: label,
            labelStyle: const TextStyle(
              fontSize: 16.0,
              color: AppColor.baseColor,
            ),
            hintText: hint,
            prefixIcon: Icon(prefixIcon),
            suffixIcon: suffixWidget,
            errorText: error,
            helperText: help,
            helperMaxLines: 2,
            border: const OutlineInputBorder()
          ),
        ),
      ],
    );
  }
}