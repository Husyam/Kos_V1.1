// SearchBar widget
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../core/constants/variables.dart';
import '../../../data/models/responses/product_response_mode.dart';
import '../../home/pages/product_detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Cari',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _searchProducts(_searchController.text);
            },
            child: const Text('Cari'),
          ),
          const SizedBox(height: 20),
          _searchResults.isEmpty
              ? const Text('Tidak ada hasil ditemukan')
              : Expanded(
                  child: ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_searchResults[index].name ?? ''),
                        leading: Image.network(
                          _searchResults[index].image ?? '',
                          width: 50,
                          height: 50,
                        ),
                        subtitle: Text(
                          'Rp ${_searchResults[index].price} - ${_searchResults[index].address} - ${_searchResults[index].categoryGender}',
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailPage(
                                data: _searchResults[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  void _searchProducts(String query) async {
    final response =
        await http.get(Uri.parse('${Variables.baseUrl}/api/products'));
    if (response.statusCode == 200) {
      final productResponse = ProductResponseModel.fromJson(response.body);
      final products = productResponse.data?.data ?? [];

      final filteredProducts = products.where((product) {
        final nameMatches =
            product.name?.toLowerCase().contains(query.toLowerCase()) ?? false;
        final priceMatches = product.price.toString().contains(query);
        final addressMatches =
            product.address?.toLowerCase().contains(query.toLowerCase()) ??
                false;
        final categoryGenderMatches = product.categoryGender
                ?.toLowerCase()
                .contains(query.toLowerCase()) ??
            false;

        return nameMatches ||
            priceMatches ||
            addressMatches ||
            categoryGenderMatches;
      }).toList();

      print('Filtered products: $filteredProducts');
      setState(() {
        _searchResults = filteredProducts;
      });
    } else {
      setState(() {
        _searchResults = [];
      });
      print('Failed to load products');
    }
  }
}

// class Variables {
//   static const String baseUrl = 'http://192.168.18.51:8000';
// }


//http://192.168.18.51:8000

// Future<ProductResponseModel> searchProducts(String query) async {
//     // Call API to search products
//     final response = await http.get(
//       Uri.parse('${Variables.baseUrl}/api/products'),
//     );
//     return ProductResponseModel.fromJson(response.body);
//   }