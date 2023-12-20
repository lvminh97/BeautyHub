import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paypal_api/paypal_api.dart';
import 'package:selling_food_store/models/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

final getIt = GetIt.instance;

class DependencyInjection {
  static Future<void> setUp() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CartAdapter());
    await Hive.openBox<Cart>('cartList');
    await Hive.openBox<String>('keywords');
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    final prefs = await SharedPreferences.getInstance();
    getIt.registerSingleton<SharedPreferences>(prefs);
    final dioPaypalClient = await DioClient.setUp();
    ApiClient apiClient = ApiClient(dioPaypalClient);
    PaypalRepository repository = PaypalRepositoryImpl(apiClient);
    getIt.registerSingleton<PaypalRepository>(repository);
  }
}
