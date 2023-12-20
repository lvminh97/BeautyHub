import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../utils/app_color.dart';
import '../../utils/image_constants.dart';

class EmptyDataWidget extends StatelessWidget {
  final EmptyType emptyType;
  final Function()? onClick;

  const EmptyDataWidget({
    super.key,
    required this.emptyType,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    switch (emptyType) {
      case EmptyType.cartEmpty:
        return _buildCartsEmpty();
      case EmptyType.profileEmpty:
        return Center(child: _buildUserInfoEmpty(context));
      case EmptyType.productListEmpty:
        return _buildUIProductListEmpty(context);
      case EmptyType.userNotSigIn:
        return _buildUINotSignIn();
      case EmptyType.orderListEmpty:
        return _buildOrderListEmpty();
    }
  }

  Widget _buildCartsEmpty() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.shopping_bag_outlined,
              size: 56.0,
            ),
            const SizedBox(height: 12.0),
            Text(
              'emptyCartText'.tr(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoEmpty(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          ImageConstants.imageUnLogin,
          width: 150.0,
          height: 150.0,
        ),
        const SizedBox(height: 12.0),
        Text('youNotLogin'.tr()),
        const SizedBox(height: 12.0),
        MaterialButton(
          onPressed: () {
            if (onClick != null) {
              onClick!();
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: const BorderSide(color: AppColor.primaryAppColor),
          ),
          elevation: 0.0,
          focusElevation: 0.0,
          highlightElevation: 0.0,
          disabledElevation: 0.0,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          color: AppColor.whiteColor,
          child: Text(
            'textSignIn'.tr(),
            style: const TextStyle(
              color: AppColor.primaryAppColor,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildUIProductListEmpty(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 48.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'productListEmpty'.tr(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUINotSignIn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [],
    );
  }

  Widget _buildOrderListEmpty() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'titleOrderListEmpty'.tr(),
            style: const TextStyle(
              fontSize: 16.0,
              color: AppColor.blackColor,
            ),
          ),
        ],
      ),
    );
  }
}

enum EmptyType {
  cartEmpty,
  profileEmpty,
  productListEmpty,
  userNotSigIn,
  orderListEmpty
}
