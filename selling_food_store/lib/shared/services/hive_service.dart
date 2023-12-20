import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:selling_food_store/models/cart.dart';

class HiveService {
  static void addCart(Cart cart) {
    var cartBox = Hive.box<Cart>('cartList');
    cartBox
        .put(cart.cartID, cart)
        .then((value) => log('Add Cart Successfully'));
  }

  static List<Cart> getCartList() {
    var cartBox = Hive.box<Cart>('cartList');
    final cartModelList = cartBox.values.toList();
    return cartModelList;
  }

  static void addAllCartList(List<Cart> dataList) {
    // var cartBox = Hive.box<Cart>('cartList');
    // cartBox.addAll(dataList.map((e) {
    //   Product product = e.product;
    //   String productStr = jsonEncode(product.toJson());
    //   return Cart(e.idCart, productStr, e.dateTimeOrder, e.orderQuantity);
    // }).toList());
  }

  static void deleteItemCart(List<Cart> dataList) {
    var cartBox = Hive.box<Cart>('cartList');
    for (Cart cart in dataList) {
      cartBox.delete(cart.cartID);
    }
  }

  static void deleteAllItemCart() {
    var cartBox = Hive.box<Cart>('cartList');
    List<Cart> cartModelList = cartBox.values.toList();
    for (Cart cartModel in cartModelList) {
      cartModel.delete();
    }
  }

  static void addKeyword(String input) {
    List<String> keyList = getKeywords();
    var keywordBox = Hive.box<String>('keywords');
    if (keyList.isEmpty) {
      keywordBox.add(input);
    } else {
      for (var key in keyList) {
        if (!key.contains(input)) {
          keywordBox.add(input);
        }
      }
    }
  }

  static List<String> getKeywords() {
    var keywordBox = Hive.box<String>('keywords');
    return keywordBox.values.map((e) => e.toString()).toList();
  }

  static bool isProductExists(String idProduct) {
    List<Cart> cartList = getCartList();
    return cartList.where((e) => e.productID == idProduct).isNotEmpty;
  }
}
