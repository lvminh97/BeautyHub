import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selling_food_store/shared/utils/app_color.dart';

class SearchBar extends StatelessWidget {
  final String? hintText;
  final Color? backgroundColor;
  final Function() onSearch;

  const SearchBar({
    super.key,
    this.hintText,
    this.backgroundColor,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onSearch();
      },
      splashColor: AppColor.transparentColor,
      highlightColor: AppColor.transparentColor,
      hoverColor: AppColor.transparentColor,
      focusColor: AppColor.transparentColor,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: backgroundColor ?? AppColor.backgroundSearchBarColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Text(
          hintText ?? 'hintSearchProduct'.tr(),
          maxLines: 1,
          style: TextStyle(
            fontSize: 14.0,
            color: AppColor.hintBlackColor,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
