import 'package:intl/intl.dart';

class Utils {
  static formatPrice(double price) => 'Rp ${price.toStringAsFixed(1)}';
  static formatDate(DateTime date) => DateFormat.yMd().format(date);
}
