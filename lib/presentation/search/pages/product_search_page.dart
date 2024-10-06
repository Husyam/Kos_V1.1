// SearchBar widget
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../core/constants/variables.dart';
import '../../../data/models/responses/product_response_mode.dart';
import '../../home/pages/product_detail_page.dart';
import '../../home/widgets/theme.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _searchResults = [];
  String _filter = 'Semua';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        labelText: 'Cari',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _showFilterDialog,
                    child: Row(
                      children: const [
                        Icon(Icons.filter_list),
                        SizedBox(width: 5),
                        // Text('Filter'),
                      ],
                    ),
                  ),
                ],
              )),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor, // Ubah warna background button
                ),
                onPressed: () {
                  _searchProducts(_searchController.text);
                },
                child: const Icon(
                  Icons.search_rounded,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 5),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Ubah warna background button
                ),
                onPressed: () {
                  _searchController.clear();
                  setState(() {
                    _searchResults = [];
                  });
                },
                child:
                    const Text('Clear', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(width: 5),
            ],
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

      List<Product> filteredProducts = [];

      if (_filter == 'Semua') {
        filteredProducts = products.where(
          (product) {
            final nameMatches =
                product.name?.toLowerCase().contains(query.toLowerCase()) ??
                    false;
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
          },
        ).toList();
      } else if (_filter == 'Harga') {
        filteredProducts = products.where(
          (product) {
            return product.price.toString().contains(query);
          },
        ).toList();
      } else if (_filter == 'Kategori') {
        filteredProducts = products.where(
          (product) {
            return product.categoryGender
                    ?.toLowerCase()
                    .contains(query.toLowerCase()) ??
                false;
          },
        ).toList();
      } else if (_filter == 'Alamat') {
        filteredProducts = products.where(
          (product) {
            return product.address
                    ?.toLowerCase()
                    .contains(query.toLowerCase()) ??
                false;
          },
        ).toList();
      }

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

  void _showPriceRangeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Pilih Range Harga'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  _searchProductsByPriceRange(0, 1000000);
                  Navigator.of(context).pop();
                },
                child: Text('Rp 0 - Rp 1.000.000'),
              ),
              ElevatedButton(
                onPressed: () {
                  _searchProductsByPriceRange(1000001, 5000000);
                  Navigator.of(context).pop();
                },
                child: Text('Rp 1.000.001 - Rp 5.000.000'),
              ),
              ElevatedButton(
                onPressed: () {
                  _searchProductsByPriceRange(5000001, 10000000);
                  Navigator.of(context).pop();
                },
                child: Text('Rp 5.000.001 - Rp 10.000.000'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _showFilterDialog();
                },
                child: Text('Kembali'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _searchProductsByPriceRange(int minPrice, int maxPrice) async {
    final response =
        await http.get(Uri.parse('${Variables.baseUrl}/api/products'));
    if (response.statusCode == 200) {
      final productResponse = ProductResponseModel.fromJson(response.body);
      final products = productResponse.data?.data ?? [];

      List<Product> filteredProducts = products.where(
        (product) {
          return product.price! >= minPrice && product.price! <= maxPrice;
        },
      ).toList();

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

  void _searchProductsByCategory(String idCategory) async {
    final response =
        await http.get(Uri.parse('${Variables.baseUrl}/api/products'));
    if (response.statusCode == 200) {
      final productResponse = ProductResponseModel.fromJson(response.body);
      final products = productResponse.data?.data ?? [];

      List<Product> filteredProducts = products.where(
        (product) {
          return product.idCategory == int.parse(idCategory);
        },
      ).toList();

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

  void _showCategoryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pilih area terdekat dengan kampus'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  _searchProductsByCategory('1');
                  Navigator.of(context).pop();
                },
                child: Text('BIDAR'),
              ),
              ElevatedButton(
                onPressed: () {
                  _searchProductsByCategory('2');
                  Navigator.of(context).pop();
                },
                child: Text('UIGM'),
              ),
              ElevatedButton(
                onPressed: () {
                  _searchProductsByCategory('3');
                  Navigator.of(context).pop();
                },
                child: Text('UIN'),
              ),
              ElevatedButton(
                onPressed: () {
                  _searchProductsByCategory('4');
                  Navigator.of(context).pop();
                },
                child: Text('UNSRI'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _showFilterDialog();
                },
                child: Text('Kembali'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCategoryGenderDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Pilih jenis kos yang dicari'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  _searchProducts('Laki-laki');
                  Navigator.of(context).pop();
                },
                child: Text('Laki-laki'),
              ),
              ElevatedButton(
                onPressed: () {
                  _searchProducts('Perempuan');
                  Navigator.of(context).pop();
                },
                child: Text('Perempuan'),
              ),
              ElevatedButton(
                onPressed: () {
                  _searchProducts('Campur');
                  Navigator.of(context).pop();
                },
                child: const Text('Campur (Laki-laki & Perempuan)'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _showFilterDialog();
                },
                child: Text('Kembali'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddressDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Pilih Alamat'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  _searchProducts('Jakabaring');
                  Navigator.of(context).pop();
                },
                child: Text('Jakabaring'),
              ),
              ElevatedButton(
                onPressed: () {
                  _searchProducts('Bogor');
                  Navigator.of(context).pop();
                },
                child: Text('Bogor'),
              ),
              ElevatedButton(
                onPressed: () {
                  _searchProducts('Depok');
                  Navigator.of(context).pop();
                },
                child: Text('Depok'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _showFilterDialog();
                },
                child: Text('Kembali'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Pilih Filter'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _filter = 'Semua';
                  });
                  _searchProducts(_searchController.text);
                  Navigator.of(context).pop();
                },
                child: const Text('Semua'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _filter = 'Harga';
                  });
                  Navigator.of(context).pop();
                  _showPriceRangeDialog();
                },
                child: const Text('Harga'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _filter = 'Kategori';
                  });
                  Navigator.of(context).pop();
                  _showCategoryGenderDialog();
                },
                child: const Text('Kategori Jenis Kos'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _filter = 'Kategori';
                  });
                  Navigator.of(context).pop();
                  _showCategoryDialog();
                },
                child: const Text('Pilih area terdekat dengan kampus'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _filter = 'Alamat';
                  });
                  Navigator.of(context).pop();
                  _showAddressDialog();
                },
                child: const Text('Alamat'),
              ),
            ],
          ),
        );
      },
    );
  }
}
