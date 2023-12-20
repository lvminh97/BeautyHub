import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService extends GetxService {
  static Future<SharedPreferences> init() {
    return SharedPreferences.getInstance();
  }
}