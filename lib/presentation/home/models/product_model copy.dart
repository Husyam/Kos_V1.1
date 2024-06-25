import '../../../core/extensions/int_ext.dart';
import 'store_model.dart';

class ProductModel {
  final List<String> images;
  final String name;
  final String jenis;
  final int price;
  final int stock;
  final String location;
  final String description;
  final StoreModel store;

  ProductModel({
    required this.images,
    required this.name,
    required this.jenis,
    required this.price,
    required this.stock,
    required this.location,
    required this.description,
    required this.store,
  });

  String get priceFormat => price.currencyFormatRp;
  // String get stockFormat => stock.stokFormat;
}
