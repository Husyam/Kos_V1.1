import '../../../data/models/responses/product_response_mode.dart';

List<Product> searchProducts({
  required List<Product> products,
  int? minPrice,
  int? maxPrice,
  String? location,
}) {
  return products.where((product) {
    final isWithinPriceRange =
        (minPrice == null || product.price! >= minPrice) &&
            (maxPrice == null || product.price! <= maxPrice);
    final matchesLocation = location == null ||
        product.address!.toLowerCase().contains(location.toLowerCase());

    return isWithinPriceRange && matchesLocation;
  }).toList();
}
