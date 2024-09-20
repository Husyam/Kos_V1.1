import 'package:flutter/material.dart';
import 'package:kos_mobile_v2_testing/core/core.dart';
import 'package:kos_mobile_v2_testing/data/models/responses/product_response_mode.dart';
import 'package:kos_mobile_v2_testing/presentation/home/pages/product_detail_page.dart';

import '../../../data/datasources/auth_local_datasource.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late Future<List<Product>> _favoriteFuture;

  @override
  void initState() {
    super.initState();
    _favoriteFuture = _loadFavorites();
  }

  Future<List<Product>> _loadFavorites() async {
    AuthLocalDatasource localDatasource = AuthLocalDatasource();
    return await localDatasource.getFavorites();
  }

  void _refreshFavorites() {
    setState(() {
      _favoriteFuture = _loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Products'),
      ),
      body: FutureBuilder<List<Product>>(
        future: _favoriteFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading favorites'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No favorites found'));
          } else {
            List<Product> favorites = snapshot.data!;
            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                Product product = favorites[index];
                return ListTile(
                  leading: Image.network(product.image!),
                  title: Text(product.name!),
                  subtitle: Text(product.price!.currencyFormatRp),
                  onTap: () async {
                    // Navigate to product detail page and wait for the result
                    bool? result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(data: product),
                      ),
                    );

                    // If result is not null, refresh favorites
                    if (result != null) {
                      _refreshFavorites();
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
