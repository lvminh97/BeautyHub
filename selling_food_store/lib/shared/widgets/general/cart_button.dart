import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:badges/badges.dart' as badges;

import '../../utils/app_color.dart';
import '../../utils/strings.dart';

class CartButton extends StatefulWidget {
  final int numberCart;
  const CartButton({
    super.key,
    required this.numberCart,
  });

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  int number = 0;
  @override
  void initState() {
    number = widget.numberCart;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CartButton oldWidget) {
    if (oldWidget.numberCart != widget.numberCart) {
      number = widget.numberCart;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: badges.Badge(
          position: badges.BadgePosition.topEnd(top: 4, end: 4),
          showBadge: number != 0,
          badgeContent: Text(
            number <= 100 ? number.toString() : Strings.upTenCart,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 8.0,
            ),
          ),
          child: IconButton(
            onPressed: () {
              context.goNamed('cart');
            },
            splashColor: AppColor.transparentColor,
            highlightColor: AppColor.transparentColor,
            focusColor: AppColor.transparentColor,
            hoverColor: AppColor.transparentColor,
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: AppColor.blackColor,
            ),
          )),
    );
  }
}
