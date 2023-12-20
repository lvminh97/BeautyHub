import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/models/product_detail.dart';
import 'package:selling_food_store/modules/detail/bloc/product_detail_bloc.dart';
import 'package:selling_food_store/modules/detail/view/introduct_text_view.dart';
import 'package:selling_food_store/shared/widgets/items/item_use.dart';

import '../../../shared/utils/app_color.dart';

class ProductDetailTabView extends StatelessWidget {
  final ProductDetail detail;

  const ProductDetailTabView({
    super.key,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
        buildWhen: (previous, current) =>
            previous.runtimeType != current.runtimeType,
        builder: (context, state) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    'introduce'.tr(),
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: AppColor.blackColor,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                IntroduceTextView(content: detail.introduce ?? ''),
                const SizedBox(height: 12.0),
                detail.ingredients != null
                    ? Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'ingredient'.tr(),
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: AppColor.blackColor,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: detail.ingredients!
                                  .map(
                                    (e) => Text(
                                      e,
                                      maxLines: 3,
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(height: 12.0),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    'uses'.tr(),
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: AppColor.blackColor,
                    ),
                  ),
                ),
                detail.uses.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ListView.builder(
                            itemCount: detail.uses.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                                ItemUse(use: detail.uses[index])),
                      )
                    : const SizedBox(),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 12.0),
                  child: Text(
                    'howToUse'.tr(),
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: AppColor.blackColor,
                    ),
                  ),
                ),
                detail.howToUse.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: detail.howToUse
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, right: 12.0),
                                  child: Text(
                                    e,
                                    maxLines: 20,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ))
                    : const SizedBox(),
                const SizedBox(height: 24.0),
              ],
            ));
  }
}
