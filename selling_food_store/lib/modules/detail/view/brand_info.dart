import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/modules/detail/bloc/brand_info_bloc.dart';
import 'package:selling_food_store/modules/detail/bloc/brand_info_state.dart';
import 'package:selling_food_store/modules/detail/view/introduct_text_view.dart';
import 'package:selling_food_store/shared/widgets/general/loading_data_widget.dart';
import 'package:selling_food_store/shared/widgets/items/item_suggest.dart';

import '../../../shared/utils/app_color.dart';

class BrandInfo extends StatelessWidget {
  const BrandInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandInfoBloc, BrandInfoState>(
        builder: (context, state) => state is DisplayBrandInfoState
            ? state.detailBrand != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                width: 40.0,
                                height: 40.0,
                                imageUrl: state.detailBrand!.logo,
                                fit: BoxFit.cover,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                        margin: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: imageProvider),
                                        )),
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) => Icon(
                                    Icons.error,
                                    color: AppColor.hintGreyColor),
                              ),
                              const SizedBox(width: 12.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      state.detailBrand!.name,
                                      style: const TextStyle(
                                        color: AppColor.blackColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      state.detailBrand!.address,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10.0,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            'descProduct'.tr(),
                            style: const TextStyle(
                              color: AppColor.blackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        IntroduceTextView(content: state.detailBrand!.desc),
                        const SizedBox(height: 16.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            'maybeProduct'.tr(),
                            style: const TextStyle(
                              color: AppColor.primaryAppColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Row(
                              children: List.generate(
                                  state.detailBrand!.products.length,
                                  (index) => ItemSuggest(
                                      product:
                                          state.detailBrand!.products[index]))),
                        )
                      ],
                    ),
                  )
                : const SizedBox()
            : const LoadingDataWidget(
                loadingType: LoadingDataType.loadingBrandInfo));
  }
}
