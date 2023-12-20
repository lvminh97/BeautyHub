import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:selling_food_store/dependency_injection.dart';
import 'package:selling_food_store/models/credential.dart';
import 'package:selling_food_store/models/product_detail.dart';

// ignore: library_prefixes
import 'package:selling_food_store/models/user_info.dart' as user;
import 'package:selling_food_store/models/category.dart';
import 'package:selling_food_store/shared/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/brand.dart';
import '../../models/cart.dart';
import '../../models/detail_brand.dart';
import '../../models/order_item.dart';
import '../../models/product.dart';
import '../../models/order.dart';
import '../../models/review.dart';

class FirebaseService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  static final DatabaseReference _dbRef =
      _firebaseDatabase.refFromURL(Strings.databaseUrl);

  static final _stoRef = _firebaseStorage.refFromURL(Strings.storageRefUrl);

  static final prefs = getIt.get<SharedPreferences>();

  //Category
  static Future<List<Category>> fetchDataCategories() async {
    List<Category> typeProducts = [];
    final DataSnapshot snapshot = await _dbRef.child('Categories').get();
    for (DataSnapshot dataSnapshot in snapshot.children) {
      final result =
          jsonDecode(jsonEncode(dataSnapshot.value)) as Map<String, dynamic>;
      final dataType = Category.fromJson(result);
      typeProducts.add(dataType);
    }
    return typeProducts;
  }

  //Product
  static Future<List<Product>> fetchProducts() async {
    List<Product> products = [];
    DataSnapshot snapshot = await _dbRef.child('Products').get();
    for (DataSnapshot dataSnapshot in snapshot.children) {
      final result =
          jsonDecode(jsonEncode(dataSnapshot.value)) as Map<String, dynamic>;
      final dataValue = Product.fromJson(result);
      products.add(dataValue);
    }
    return products;
  }

  static void getProductByID(
    String id,
    Function(Product) onComplete,
    Function(String) onError,
  ) {
    _dbRef.child('Products').child(id).get().then((snapshot) {
      if (snapshot.exists) {
        final data =
            jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
        Product product = Product.fromJson(data);
        onComplete(product);
      }
    }).onError((error, stackTrace) => onError(error.toString()));
  }

  static Future<ProductDetail?> fetchDataProductDetail(
      String id, Function(String) onError) async {
    try {
      DataSnapshot snapshot =
          await _dbRef.child('DetailProducts').child(id).get();
      if (snapshot.exists) {
        final result =
            jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
        ProductDetail detail = ProductDetail.fromJson(result);
        return detail;
      }
    } catch (error) {
      log('Error: ${error.toString()}');
      return null;
    }
    return null;
  }

  static void writeReviewForProduct(String idProduct, Review review) {
    final idUser = prefs.getString(Strings.idUser);
    if (idUser != null) {
      _dbRef
          .child('Reviews')
          .child(idProduct)
          .child(review.id)
          .set(review.toJson());
    }
  }

  static Future<List<Review>> getReviewsForProduct(String idProduct) async {
    List<Review> reviews = [];
    DataSnapshot snapshot =
        await _dbRef.child('Reviews').child(idProduct).get();
    for (DataSnapshot dataSnapshot in snapshot.children) {
      final data =
          jsonDecode(jsonEncode(dataSnapshot.value)) as Map<String, dynamic>;
      Review review = Review.fromJson(data);
      reviews.add(review);
    }
    return reviews;
  }

  //Cart
  static void fetchProductListToCart(
    Function(List<Cart>) onComplete,
    Function(String) onError,
  ) {
    List<Cart> cartList = [];
    final String? id = prefs.getString(Strings.idUser);
    _dbRef.child('Carts').child(id ?? '').get().then((snapshot) {
      if (snapshot.exists) {
        for (DataSnapshot dataSnapshot in snapshot.children) {
          final result = jsonDecode(jsonEncode(dataSnapshot.value));
          Cart cart = Cart.fromJson(result);
          cartList.add(cart);
        }
        onComplete(cartList);
      } else {
        onComplete(cartList);
      }
    }).onError((error, stackTrace) => onError(error.toString()));
  }

  static Future<void> addProductToCart(
    Cart cart,
    Function() onComplete,
    Function(String) onError,
  ) async {
    final String? id = prefs.getString(Strings.idUser);
    if (id != null) {
      _dbRef
          .child('Carts')
          .child(id)
          .child(cart.cartID)
          .set(cart.toJson())
          .then((value) => onComplete())
          .onError((error, stackTrace) => onError(error.toString()));
    }
  }

  static void removeCartList({List<Cart>? cartList}) {
    final idUser = prefs.getString(Strings.idUser);
    if (idUser != null) {
      if (cartList != null) {
        for (var cart in cartList) {
          _dbRef.child('Carts').child(idUser).child(cart.cartID).remove();
        }
      } else {
        _dbRef.child('Carts').child(idUser).remove();
      }
    }
  }

  static void updateQuantityForCart(String idCart, int value) {
    final idUser = prefs.getString(Strings.idUser);
    if (idUser != null) {
      _dbRef.child('Carts').child(idUser).child(idCart).update({
        'quantity': value,
      });
    }
  }

  //Authentication
  static bool checkUserIsSignIn() {
    return _firebaseAuth.currentUser == null ||
            prefs.getString(Strings.idUser) == null
        ? false
        : true;
  }

  static Future<UserCredential?> signUpFirebaseWithEmail(
      String email, String password, Function(String) onError) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (error) {
      log('Code: ${error.code} - Message: ${error.message}');
      String errStr = 'errorStr'.tr();
      switch (error.code) {
        case 'email-already-in-use':
          errStr = 'emailAlreadyUse'.tr();
          break;
        case 'weak-password':
          errStr = 'notStrongPassword'.tr();
          break;
        case 'invalid-email':
          errStr = 'emailInvalid'.tr();
          break;
        default:
          errStr = '${'unknown'.tr()} - ${error.code}';
          break;
      }
      onError(errStr);
      return null;
    }
  }

  static Future<void> signInFirebaseWithEmail(String email, String password,
      Function(String) onComplete, Function(String?) onError) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((credential) {
        if (credential.user != null) {
          onComplete(credential.user!.uid);
        }
      });
    } on FirebaseAuthException catch (error) {
      log('Code: ${error.code} - Message: ${error.message}');
      String errStr = 'errorStr'.tr();
      switch (error.code) {
        case 'network-request-failed':
          errStr = 'notInternetConnect'.tr();
          break;
        case 'wrong-password':
          errStr = 'wrongPassword'.tr();
          break;
        case 'user-not-found':
          errStr = 'userNotFoundErrorText'.tr();
          break;
        case 'invalid-email':
          errStr = 'emailInvalid'.tr();
          break;
        default:
          errStr = '${'unknown'.tr()} - ${error.code}';
          break;
      }
      onError(errStr);
    }
  }

  static Future<void> forgotPasswordAccount(
    String email,
    Function() onComplete,
    Function(String) onError,
  ) async {
    try {
      await _firebaseAuth
          .sendPasswordResetEmail(email: email)
          .then((value) => onComplete());
    } on FirebaseAuthException catch (error) {
      log('Code: ${error.code} - Message: ${error.message}');
      String errStr = 'errorStr'.tr();
      switch (error.code) {
        case 'invalid-email':
          errStr = 'emailInvalid'.tr();
          break;
        case 'user-not-found':
          errStr = 'userNotFound'.tr();
          break;
        default:
          errStr = '${'unknown'.tr()} - ${error.code}';
          break;
      }
      onError(errStr);
    }
  }

  static Future<void> signUpFirebaseWithPhone(
    String phone,
    Function() onComplete,
    Function(String) onError,
  ) async {
    try {
      await _firebaseAuth
          .signInWithPhoneNumber(phone)
          .then((value) => onComplete());
    } on FirebaseAuthException catch (error) {
      log('Code: ${error.code} - Message: ${error.message}');
      String errStr = 'errorStr'.tr();
      switch (error.code) {
        case 'email-already-in-use':
          errStr = 'emailAlreadyUse'.tr();
          break;
        case 'weak-password':
          errStr = 'notStrongPassword'.tr();
          break;
        case 'invalid-email':
          errStr = 'emailInvalid'.tr();
          break;
        default:
          errStr = '${'unknown'.tr()} - ${error.code}';
          break;
      }
      onError(errStr);
    }
  }

  static Future<void> signOutAccount(
      Function() onComplete, Function(String) onError) async {
    _firebaseAuth
        .signOut()
        .then((value) => onComplete())
        .onError((error, stackTrace) => onError(error.toString()));
  }

  static void insertCredentialToDb(
    Credential credential,
    Function() onComplete,
    Function(String) onError,
  ) {
    _dbRef
        .child('Credentials')
        .child(credential.idUser)
        .set(credential.toJson())
        .then((value) => onComplete())
        .onError((error, stackTrace) => onError(error.toString()));
  }

  static void deleteUserAccount(
    String password,
    Function() onComplete,
    Function(String) onError,
  ) {
    final email = prefs.getString(Strings.email);
    if (email != null) {
      _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (value.user != null) {
          value.user!
              .delete()
              .then((value) => onComplete())
              .onError((error, stackTrace) => onError(error.toString()));
        }
      }).onError((error, stackTrace) => onError(error.toString()));
    }
  }

  static Future<void> changePassword(
    String oldPasword,
    String password,
    Function() onComplete,
    Function(String) onError,
  ) async {
    User? currentUser = _firebaseAuth.currentUser;
    final email = prefs.getString(Strings.email);
    if (email != null) {
      await currentUser!
          .reauthenticateWithCredential(
              EmailAuthProvider.credential(email: email, password: oldPasword))
          .then((value) async {
        if (value.user != null) {
          await _firebaseAuth.currentUser!
              .updatePassword(password)
              .then((value) {
            _dbRef
                .child('Credentials')
                .child(currentUser.uid)
                .update({"password": password})
                .then((value) => onComplete())
                .onError((error, stackTrace) => onError(error.toString()));
          });
        }
      }).onError<FirebaseAuthException>((error, stackTrace) {
        String errorStr = 'unknown'.tr();
        switch (error.code) {
          case 'invalid-email':
            errorStr = 'emailInvalid'.tr();
            break;
          case 'user-not-found':
            errorStr = 'userNotFound'.tr();
            break;
          case 'wrong-password':
            errorStr = 'wrong_password'.tr();
            break;
          default:
            errorStr = 'unknown'.tr();
        }
        onError(errorStr);
      });
    }
  }

  //User
  static void insertUserInfoToDb(
    user.UserInfo userInfo,
    Function() onComplete,
    Function(String) onError,
  ) {
    _dbRef
        .child('Users')
        .child(userInfo.idAccount)
        .set(userInfo.toJson())
        .then((value) => onComplete())
        .onError((error, stackTrace) => onError(error.toString()));
  }

  static Future<user.UserInfo?> getUserInfo(Function(String) onError) async {
    final idUser = prefs.getString(Strings.idUser);
    if (idUser != null) {
      final DataSnapshot snapshot = await _dbRef
          .child('Users')
          .child(idUser)
          .get()
          .onError((error, stackTrace) => onError(error.toString()));
      final data =
          jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
      user.UserInfo userInfo = user.UserInfo.fromJson(data);
      return userInfo;
    } else {
      onError('unknow'.tr());
      return null;
    }
  }

  static Future<void> updateUserInfo(
      String name, String address, DateTime dateTime) async {
    final idUser = prefs.getString(Strings.idUser);
    if (idUser != null) {
      _dbRef.child('Users').child(idUser).update({
        "fullName": name,
        "address": address,
        "birthDay": dateTime.toString(),
      });
    }
  }

  static void updateAvatarProfileToStorage(
    File file,
    Function() onComplete,
    Function(String) onError,
  ) {
    final idUser = prefs.getString(Strings.idUser);
    if (idUser != null) {
      _stoRef
          .child('Avatars')
          .child(idUser)
          .putFile(file)
          .then((taskSnapshot) async {
        String imageUrl = await taskSnapshot.ref.getDownloadURL();
        if (imageUrl.isNotEmpty) {
          updateAvatarProfileUserInfo(imageUrl);
          onComplete();
        }
      }).onError((error, stackTrace) => onError(error.toString()));
    }
  }

  static void updateAvatarProfileUserInfo(String avatar) {
    final idUser = prefs.getString(Strings.idUser);
    if (idUser != null) {
      _dbRef.child('Users').child(idUser).update({
        "avatar": avatar,
      });
    }
  }

  static void getUserInfoByID(
    String id,
    Function(user.UserInfo) onComplete,
    Function(String) onError,
  ) {
    _dbRef.child('Users').child(id).get().then((snapshot) {
      if (snapshot.exists) {
        final data =
            jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
        user.UserInfo userInfo = user.UserInfo.fromJson(data);
        onComplete(userInfo);
      }
    }).onError((error, stackTrace) => onError(error.toString()));
  }

  //Brand
  static void fetchDetailBrand(
      String id, Function(DetailBrand?) onComplete, Function(String) onError) {
    _dbRef.child('DetailBrands').child(id).get().then((snapshot) {
      if (snapshot.exists) {
        final dataValue =
            jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
        DetailBrand detailBrand = DetailBrand.fromJson(dataValue);
        onComplete(detailBrand);
      } else {
        onComplete(null);
      }
    }).onError((error, stackTrace) => onError(error.toString()));
  }

  static Future<Brand?> fetchBrandByID(
      String id, Function(String) onError) async {
    DataSnapshot snapshot = await _dbRef.child('Brands').child(id).get();
    if (snapshot.exists) {
      final dataValue =
          jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
      Brand detailBrand = Brand.fromJson(dataValue);
      return detailBrand;
    }
    return null;
  }

  //Order
  static void createOrder(
    Order order,
    Function() onComplete,
    Function(String) onError,
  ) {
    _dbRef
        .child('Orders')
        .child(order.orderId)
        .set(order.convertToJson())
        .then((value) => onComplete())
        .onError((error, stackTrace) => onError(error.toString()));
  }

  static void getOrderList(
    Function(List<Order>) onComplete,
    Function(String) onError,
  ) {
    List<Order> orderList = [];
    final idUser = prefs.getString(Strings.idUser);
    if (idUser != null) {
      _dbRef.child('userOrders').child(idUser).get().then((snapshot) {
        for (DataSnapshot dataSnapshot in snapshot.children) {
          final data = dataSnapshot.value as String;
          log('Id order: $data');
          _dbRef.child('Orders').child(data).get().then((snapshot) {
            if (snapshot.exists) {
              final dataValue = jsonDecode(jsonEncode(snapshot.value))
                  as Map<String, dynamic>;
              final requestOrder = Order.fromJson(dataValue);
              orderList.add(requestOrder);
              onComplete(orderList);
            } else {
              onComplete([]);
            }
          }).onError((error, stackTrace) => onError(error.toString()));
        }
      });
    }
  }

  static void writeOrderByUser(String id) {
    final idUser = prefs.getString(Strings.idUser);
    if (idUser != null) {
      _dbRef.child('userOrders').child(idUser).child(id).set(id);
    }
  }

  static void writeOrderByStore(String id, List<OrderItem> orderItem) {
    for (var item in orderItem) {
      _dbRef.child('storeOrders').child(item.brandId).child(id).set(id);
    }
  }

  static void updateReasonForCancelOrder(
    String idOrder,
    String reason,
    Function() onComplete,
    Function(String) onError,
  ) {
    _dbRef.child('Orders').child(idOrder).update({
      'status': 'CANCEL',
      'reasonCancelOrder': reason,
    }).then((value) {
      onComplete();
    }).onError((error, stackTrace) => onError(error.toString()));
  }

  static void getUserCredential(
    Function(Credential) onComplete,
    Function(String) onError,
  ) {
    // final idUser = prefs.getString(Strings.idUser);
    // if (idUser != null) {
    //   _dbRef.child('Credentials').child(idUser).get().then((snapshot) {
    //     final data =
    //         jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
    //     Credential credential = Credential.fromJson(data);
    //     onComplete(credential);
    //   }).onError((error, stackTrace) => onError(error.toString()));
    // }
  }
}
