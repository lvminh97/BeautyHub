import 'dart:convert';
import 'dart:io';

import 'package:beauty_hub_admin/models/product.dart';
import 'package:beauty_hub_admin/shared/constants/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/order.dart';
import '../../models/product_detail.dart';

class FirebaseService {
  static final _auth = FirebaseAuth.instance;
  static final _database = FirebaseDatabase.instance;
  static final _storage = FirebaseStorage.instance;

  static final _dbRef = _database.refFromURL(AppConstants.dbUrl);
  static final _storeRef = _storage.refFromURL(AppConstants.stoRef);

  //Auth
  static Future<UserCredential?> loginWithEmailPassword(
    String email,
    String password,
    Function(String) onError,
  ) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'invalid-email':
          onError('Email không hợp lệ');
          break;
        case 'invalid-credential':
          onError('Tài khoản không tồn tại');
          break;
        case 'wrong-password':
          onError('Mật khẩu không đúng');
          break;
        default:
          onError('Đã có lỗi xảy ra. Vui lòng đăng nhập lại');
          break;
      }
      return null;
    }
  }

  static void signOut(Function() onSuccess, Function(String) onFailure) {
    _auth.signOut().then((value) {
      onSuccess();
    }).onError((error, stackTrace) => onFailure(error.toString()));
  }

  //Product Manage
  static Future<List<Product>> fetchProducts() async {
    List<Product> products = [];
    final prefs = Get.find<SharedPreferences>();
    String idUser = prefs.getString(AppConstants.idUser) ?? '';
    DataSnapshot snapshot = await _dbRef.child('Products').get();
    for (DataSnapshot dataSnapshot in snapshot.children) {
      final data =
          jsonDecode(jsonEncode(dataSnapshot.value)) as Map<String, dynamic>;
      Product product = Product.fromJson(data);
      if (product.brand.idBrand == idUser) {
        products.add(product);
      }
    }
    return products;
  }

  static void deleteProduct(String idProduct) async {
    _dbRef.child('Products').child(idProduct).remove();
    EasyLoading.showToast('Xóa sản phẩm thành công');
  }

  static void uploadImageProduct(
    String id,
    File imageFile,
    Function(String) onSuccess,
    Function(String) onFailure,
  ) {
    _storeRef
        .child('products')
        .child(id)
        .putFile(imageFile)
        .then((taskSnapshot) async {
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      if (imageUrl.isNotEmpty) {
        onSuccess(imageUrl);
      }
    }).onError((error, stackTrace) => onFailure(error.toString()));
  }

  static void writeProductToDb(Product product) {
    _dbRef
        .child('Products')
        .child(product.idProduct)
        .set(product.convertToJson());
  }

  static void writeDetailProductToDb(ProductDetail detail) {
    _dbRef
        .child('DetailProducts')
        .child(detail.idProduct)
        .set(detail.convertToJson());
  }

  //Order Manage
  static Future<List<Order>> fetchOrders() async {
    List<Order> orders = [];
    DataSnapshot snapshot = await _dbRef.child('Orders').get();
    for (DataSnapshot dataSnapshot in snapshot.children) {
      final data =
          jsonDecode(jsonEncode(dataSnapshot.value)) as Map<String, dynamic>;
      Order order = Order.fromJson(data);
      orders.add(order);
    }
    return orders;
  }

  static void getProductById(String id) {

  }
}
