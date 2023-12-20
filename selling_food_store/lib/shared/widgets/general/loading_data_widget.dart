import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../utils/app_color.dart';

class LoadingDataWidget extends StatelessWidget {
  final LoadingDataType loadingType;
  const LoadingDataWidget({
    super.key,
    required this.loadingType,
  });

  @override
  Widget build(BuildContext context) {
    switch (loadingType) {
      case LoadingDataType.loadingRecommendProductList:
        return _buidlLoadingRecommendListProduct(context);
      case LoadingDataType.loadingProductDetail:
        return _buildLoadingProductDetail(context);
      case LoadingDataType.loadingHotSellingProductList:
        return _buidlLoadingHotSellingListProduct(context);
      case LoadingDataType.loadingCartList:
        return _buildLoadingCartList();
      case LoadingDataType.loadingUserInfo:
        return _buildLoadingUserInfo(context);
      case LoadingDataType.loadingItemEmpty:
        return _buildLoadingItemEmpty();
      case LoadingDataType.loadingBrandInfo:
        return _buildLoadingBrandInfo(context);
    }
  }

  Widget _buidlLoadingRecommendListProduct(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          10,
          (index) => Container(
            width: 180.0,
            padding: const EdgeInsets.only(left: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 220.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: AppColor.shimmerColor,
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 12.0,
                  color: AppColor.shimmerColor,
                ),
                const SizedBox(height: 8.0),
                Container(
                  width: 100.0,
                  height: 18.0,
                  color: AppColor.shimmerColor,
                ),
                const SizedBox(height: 8.0),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 16.0,
                  color: AppColor.shimmerColor,
                ),
                const SizedBox(height: 8.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Container(
                        height: 18.0,
                        color: AppColor.shimmerColor,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Container(
                        height: 18.0,
                        color: AppColor.shimmerColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buidlLoadingHotSellingListProduct(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 360.0,
      child: GridView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 2.0,
        ),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 220.0,
                decoration: BoxDecoration(
                  color: AppColor.shimmerColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              const SizedBox(height: 8.0),
              Container(
                height: 12.0,
                color: AppColor.shimmerColor,
              ),
              const SizedBox(height: 8.0),
              Container(
                height: 16.0,
                color: AppColor.shimmerColor,
              ),
              const SizedBox(height: 8.0),
              Container(
                height: 48.0,
                decoration: BoxDecoration(
                  color: AppColor.shimmerColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              const SizedBox(height: 8.0),
              RatingBar.builder(
                  itemCount: 5,
                  itemSize: 16.0,
                  itemBuilder: ((context, index) => Icon(
                        Icons.star,
                        color: AppColor.shimmerColor,
                      )),
                  onRatingUpdate: (value) {})
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingProductDetail(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: AppColor.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 280.0,
            decoration: BoxDecoration(color: AppColor.shimmerColor),
          ),
          const SizedBox(height: 8.0),
          Container(
            width: MediaQuery.of(context).size.width - 12 * 2,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 12.0,
            color: AppColor.shimmerColor,
          ),
          const SizedBox(height: 8.0),
          Container(
            width: MediaQuery.of(context).size.width - 12 * 2,
            height: 12.0,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            color: AppColor.shimmerColor,
          ),
          const SizedBox(height: 8.0),
          Container(
            width: MediaQuery.of(context).size.width - 12 * 2,
            height: 12.0,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            color: AppColor.shimmerColor,
          ),
          const SizedBox(height: 12.0),
          Container(
            width: MediaQuery.of(context).size.width - 12 * 2 - 56.0,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.discount,
                  size: 32.0,
                  color: AppColor.shimmerColor,
                ),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 100.0,
                      height: 12.0,
                      color: AppColor.shimmerColor,
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      width: 150.0,
                      height: 12.0,
                      color: AppColor.shimmerColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          Container(
            width: MediaQuery.of(context).size.width - 12 * 2,
            height: 12.0,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            color: AppColor.shimmerColor,
          ),
          const SizedBox(height: 8.0),
          Container(
            width: MediaQuery.of(context).size.width - 12 * 2,
            height: 12.0,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            color: AppColor.shimmerColor,
          ),
          const SizedBox(height: 8.0),
          Container(
            width: MediaQuery.of(context).size.width - 12 * 2,
            height: 12.0,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            color: AppColor.shimmerColor,
          ),
          const SizedBox(height: 8.0),
          Container(
            width: MediaQuery.of(context).size.width - 12 * 2,
            height: 12.0,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            color: AppColor.shimmerColor,
          ),
          const SizedBox(height: 8.0),
          Container(
            width: MediaQuery.of(context).size.width - 12 * 2,
            height: 12.0,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            color: AppColor.shimmerColor,
          ),
          const SizedBox(height: 8.0),
          Container(
            width: MediaQuery.of(context).size.width - 12 * 2,
            height: 12.0,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            color: AppColor.shimmerColor,
          ),
          const SizedBox(height: 12.0),
          Container(
            width: 150.0,
            height: 12.0,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            color: AppColor.shimmerColor,
          ),
          const SizedBox(height: 8.0),
          Container(
            width: MediaQuery.of(context).size.width - 12 * 2,
            height: 12.0,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            color: AppColor.shimmerColor,
          ),
          const SizedBox(height: 8.0),
          Container(
            width: MediaQuery.of(context).size.width - 12 * 2,
            height: 12.0,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            color: AppColor.shimmerColor,
          ),
          const SizedBox(height: 8.0),
          Container(
            width: MediaQuery.of(context).size.width - 12 * 2,
            height: 12.0,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            color: AppColor.shimmerColor,
          ),
          const SizedBox(height: 8.0),
          Container(
            width: MediaQuery.of(context).size.width - 12 * 2,
            height: 12.0,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            color: AppColor.shimmerColor,
          ),
          const SizedBox(height: 12.0),
          Container(
            width: 150.0,
            height: 12.0,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            color: AppColor.shimmerColor,
          ),
          const SizedBox(height: 8.0),
          Container(
            width: MediaQuery.of(context).size.width - 12 * 2,
            height: 12.0,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            color: AppColor.shimmerColor,
          ),
          const SizedBox(height: 8.0),
          Container(
            width: MediaQuery.of(context).size.width - 12 * 2,
            height: 12.0,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            color: AppColor.shimmerColor,
          ),
          const SizedBox(height: 8.0),
          Container(
            width: MediaQuery.of(context).size.width - 12 * 2,
            height: 12.0,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            color: AppColor.shimmerColor,
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.shimmerColor,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Container(
                      width: 150.0,
                      height: 12.0,
                      color: AppColor.shimmerColor,
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                RatingBar.builder(
                    itemCount: 5,
                    initialRating: 3,
                    allowHalfRating: true,
                    unratedColor: AppColor.shimmerColor,
                    itemSize: 12.0,
                    itemBuilder: (context, index) =>
                        Icon(Icons.star, color: AppColor.shimmerColor),
                    onRatingUpdate: (newValue) {}),
                const SizedBox(height: 12.0),
                Container(
                  width: MediaQuery.of(context).size.width - 12 * 2,
                  height: 12.0,
                  color: AppColor.shimmerColor,
                ),
                const SizedBox(height: 8.0),
                Container(
                  width: 200,
                  height: 12.0,
                  color: AppColor.shimmerColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingCartList() {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) => Card(
          color: AppColor.whiteColor,
          elevation: 0.0,
          margin: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 200.0,
                  height: 12.0,
                  color: AppColor.shimmerColor,
                ),
                const SizedBox(height: 8.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: AppColor.shimmerColor,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 200.0,
                            height: 12.0,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            color: AppColor.shimmerColor,
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 14.0,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  color: AppColor.shimmerColor,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Container(
                                  height: 14.0,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  color: AppColor.shimmerColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Container(
                            width: 150.0,
                            height: 12.0,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            color: AppColor.shimmerColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 16.0),
      ),
    );
  }

  Widget _buildLoadingUserInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 60.0,
                  height: 60.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.shimer200Color,
                  )),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 200.0,
                      height: 12.0,
                      color: AppColor.shimer200Color,
                    ),
                    const SizedBox(height: 6.0),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 12.0,
                      color: AppColor.shimer200Color,
                    ),
                    const SizedBox(height: 6.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 50.0,
                          height: 12.0,
                          color: AppColor.shimer200Color,
                        ),
                        const SizedBox(width: 8.0),
                        Container(
                          width: 80.0,
                          height: 12.0,
                          color: AppColor.shimer200Color,
                        ),
                        const SizedBox(width: 12.0),
                        Container(
                          width: 50.0,
                          height: 12.0,
                          color: AppColor.shimer200Color,
                        ),
                        const SizedBox(width: 8.0),
                        Container(
                          width: 80.0,
                          height: 12.0,
                          color: AppColor.shimer200Color,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 24.0,
                  width: 24.0,
                  color: AppColor.shimer200Color,
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Container(
                    height: 24.0,
                    color: AppColor.shimer200Color,
                  ),
                ),
                const SizedBox(width: 24.0),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 24.0,
                  width: 24.0,
                  color: AppColor.shimer200Color,
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Container(
                    height: 24.0,
                    color: AppColor.shimer200Color,
                  ),
                ),
                const SizedBox(width: 24.0),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 24.0,
                  width: 24.0,
                  color: AppColor.shimer200Color,
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Container(
                    height: 24.0,
                    color: AppColor.shimer200Color,
                  ),
                ),
                const SizedBox(width: 24.0),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 24.0,
                  width: 24.0,
                  color: AppColor.shimer200Color,
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Container(
                    height: 24.0,
                    color: AppColor.shimer200Color,
                  ),
                ),
                const SizedBox(width: 24.0),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 24.0,
                  width: 24.0,
                  color: AppColor.shimer200Color,
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Container(
                    height: 24.0,
                    color: AppColor.shimer200Color,
                  ),
                ),
                const SizedBox(width: 24.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingItemEmpty() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 200.0,
          height: 12.0,
          color: AppColor.shimmerColor,
        ),
        const SizedBox(height: 8.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: AppColor.shimmerColor,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 200.0,
                    height: 12.0,
                    margin: const EdgeInsets.symmetric(horizontal: 12.0),
                    color: AppColor.shimmerColor,
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Container(
                          height: 14.0,
                          margin: const EdgeInsets.symmetric(horizontal: 12.0),
                          color: AppColor.shimmerColor,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Container(
                          height: 14.0,
                          margin: const EdgeInsets.symmetric(horizontal: 12.0),
                          color: AppColor.shimmerColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    width: 150.0,
                    height: 12.0,
                    margin: const EdgeInsets.symmetric(horizontal: 12.0),
                    color: AppColor.shimmerColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoadingBrandInfo(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.shimer200Color,
                    )),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          width: 60.0,
                          height: 10.0,
                          color: AppColor.shimer200Color),
                      const SizedBox(height: 4.0),
                      Container(
                          width: 100.0,
                          height: 5.0,
                          color: AppColor.shimer200Color),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          Container(
            width: baseWidth,
            height: 10.0,
            color: AppColor.shimer200Color,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
          ),
          const SizedBox(height: 8.0),
          Container(
            width: baseWidth,
            height: 10.0,
            color: AppColor.shimer200Color,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
          ),
          const SizedBox(height: 8.0),
          Container(
            width: baseWidth,
            height: 10.0,
            color: AppColor.shimer200Color,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
          ),
          const SizedBox(height: 16.0),
          Container(
            width: 150.0,
            height: 10.0,
            color: AppColor.shimer200Color,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
          ),
          const SizedBox(height: 12.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 12.0),
            child: Row(
                children: List.generate(
              10,
              (index) => Container(
                width: 150.0,
                height: 200.0,
                color: AppColor.shimer200Color,
                margin: const EdgeInsets.only(right: 12.0),
              ),
            )),
          )
        ],
      ),
    );
  }
}

enum LoadingDataType {
  loadingRecommendProductList,
  loadingHotSellingProductList,
  loadingProductDetail,
  loadingCartList,
  loadingUserInfo,
  loadingItemEmpty,
  loadingBrandInfo,
}
