import 'dart:core';
import 'dart:developer';
import 'dart:io';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/models/product.dart';
import 'package:selling_food_store/modules/home/bloc/home_bloc.dart';
import 'package:selling_food_store/modules/home/bloc/home_event.dart';
import 'package:selling_food_store/modules/home/bloc/home_state.dart';
import 'package:selling_food_store/modules/home/view/bestselling_product_list.dart';
import 'package:selling_food_store/modules/home/view/hotselling_product_list.dart';
import 'package:selling_food_store/modules/home/view/recommend_product_list.dart';
import 'package:selling_food_store/modules/home/view/category_list.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';
import 'package:selling_food_store/shared/services/hive_service.dart';
import 'package:selling_food_store/shared/utils/image_constants.dart';
import 'package:selling_food_store/shared/utils/show_dialog_utils.dart';
import 'package:selling_food_store/shared/widgets/banner/slide_banner.dart';
import 'package:selling_food_store/shared/widgets/general/avatar_profile.dart';
import 'package:selling_food_store/shared/widgets/general/cart_button.dart';
import 'package:selling_food_store/shared/widgets/items/item_result_search.dart';
import 'package:selling_food_store/shared/widgets/items/item_suggestion_product.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/utils/app_color.dart';
import '../../../shared/utils/strings.dart';
import '../../../shared/widgets/banner/banner_ads.dart';
import '../../../shared/widgets/general/search_bar.dart' as searchBar;

import 'package:badges/badges.dart' as badges;

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    int numberCart = 0;
    return BlocConsumer<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is DisplayProductListState) {
          numberCart = HiveService.getCartList().length;
        } else if (state is ConfirmRemoveItemCartState) {
          numberCart = HiveService.getCartList().length;
          log('Number Cart: $numberCart');
        }
        return Scaffold(
          backgroundColor: AppColor.whiteColor,
          appBar: AppBar(
            backgroundColor: AppColor.whiteColor,
            title: searchBar.SearchBar(
              onSearch: () {
                showSearch(
                  context: context,
                  delegate: ProductSearchDelegate(),
                );
              },
            ),
            titleSpacing: 0.0,
            automaticallyImplyLeading: false,
            leading: InkWell(
              onTap: () {
                context.goNamed('profile');
              },
              child: Container(
                margin: const EdgeInsets.all(6.0),
                child: const AvatarProfile(
                  avatar: Strings.avatarDemo,
                  isEdit: false,
                ),
              ),
            ),
            elevation: 0.0,
            actions: [
              CartButton(numberCart: numberCart),
              Center(
                child: badges.Badge(
                    showBadge: true,
                    badgeContent: const Text(
                      Strings.upTenCart,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8.0,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        context.goNamed('notifications');
                      },
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: const Icon(
                        Icons.notifications_none_outlined,
                        color: AppColor.blackColor,
                      ),
                    )),
              ),
              const SizedBox(width: 16.0),
            ],
          ),
          body: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SlideBanner(),
                SizedBox(height: 16.0),
                RecommendProductList(),
                SizedBox(height: 24.0),
                CategoryList(),
                SizedBox(height: 24.0),
                HotSellingProductList(),
                SizedBox(height: 12.0),
                BannerAds(image: ImageConstants.bannerOne),
                SizedBox(height: 12.0),
                BestSellingProductList(),
                SizedBox(height: 12.0),
                BannerAds(image: ImageConstants.bannerTwo),
              ],
            ),
          ),
          floatingActionButton: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  _openChatBot();
                },
                heroTag: "Messenger",
                backgroundColor: AppColor.transparentColor,
                child: Image.asset(ImageConstants.iconChatBot),
              ),
              const SizedBox(height: 16.0),
              FloatingActionButton(
                onPressed: () {
                  _makePhoneCall('0941699575');
                },
                heroTag: "Call",
                backgroundColor: Colors.redAccent,
                child: const Icon(
                  Icons.call,
                  color: AppColor.whiteColor,
                ),
              )
            ],
          ),
        );
      },
      listener: (context, state) {
        if (state is RequestSignInState) {
          ShowDialogUtils.showDialogRequestSignIn(context, () {
            context.goNamed('signIn');
          }, () {
            context.read<HomeBloc>().add(OnCloseDialogEvent());
          });
        } else if (state is DialogCloseState) {
          log('Dialog is closed');
        } else if (state is ConfirmAddProductToCartState) {
          numberCart = HiveService.getCartList().length;
          log('Number Cart: $numberCart');
        }
      },
    );
  }

  Future<void> _openChatBot() async {
    bool isInstalled = await isAppInstalled();
    String uri = '';
    if (isInstalled) {
      if (Platform.isAndroid) {
        uri = 'fb-messenger://user/${Strings.facebookId}';
      } else if (Platform.isIOS) {
        uri = 'https://m.me/${Strings.facebookId}';
      }
      final Uri url = Uri.parse(uri);
      if (!await launchUrl(url)) {
        EasyLoading.showError('Could not launch $url');
      }
    } else {
      uri = 'https://www.facebook.com/${Strings.facebookId}';
      final Uri url = Uri.parse(uri);
      if (!await launchUrl(url,
          mode: LaunchMode.externalNonBrowserApplication)) {
        EasyLoading.showError('Could not launch $url');
      }
    }
  }

  Future<bool> isAppInstalled() {
    return DeviceApps.getInstalledApplications().then((value) =>
        value.any((element) => element.packageName == 'com.facebook.orca'));
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}

class ProductSearchDelegate extends SearchDelegate {
  List<Product> productList = [];

  ProductSearchDelegate() {
    getProductList();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
        backgroundColor: AppColor.whiteColor,
        iconTheme: IconThemeData(color: AppColor.blackColor),
        actionsIconTheme: IconThemeData(color: AppColor.blackColor),
      ),
      inputDecorationTheme:
          const InputDecorationTheme(border: InputBorder.none),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isNotEmpty) {
              query = '';
            } else {
              context.pop();
            }
          },
          icon: const Icon(Icons.clear)),
      const SizedBox(width: 12.0),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.pop();
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Product> resultList =
        productList.where((e) => e.name == query).toList();
    return GridView.builder(
        itemCount: resultList.length,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.55,
        ),
        itemBuilder: ((context, index) =>
            ItemResultSearch(product: resultList[index])));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> suggestionList =
        productList.where((e) => e.name.contains(query)).toList();
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) => ItemSuggestionProduct(
              product: suggestionList[index],
              onClick: (nameProduct) {
                query = nameProduct;
              },
            ),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: suggestionList.length);
  }

  Future<void> getProductList() async {
    productList = await FirebaseService.fetchProducts();
  }
}
