import 'package:intl/intl.dart';

class AppUtils {
  static String formatPrice(double value) {
    NumberFormat numberFormat = NumberFormat('#,###');
    return numberFormat.format(value);
  }
}