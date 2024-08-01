import 'package:kos_mobile_v2_testing/data/models/responses/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/responses/product_response_mode.dart';

class AuthLocalDatasource {
  static const _keyUserId = 'userId';
  static const _keyFavorites = 'favorites';

  Future<void> saveAuthData(AuthResponseModel authResponseModel) async {
    // Save auth data to local storage
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('auth_data', authResponseModel.toJson());

    // print('Auth data saved: ${authResponseModel.toJson()}');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_data', authResponseModel.toJson());
    print('Auth data saved: ${authResponseModel.toJson()}');
  }

  Future<void> removeAuthData() async {
    // Remove auth data from local storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_data');
  }

  Future<AuthResponseModel?> getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final authData = prefs.getString('auth_data');
    print('Auth data retrieved: $authData');

    if (authData != null) {
      return AuthResponseModel.fromJson(authData);
    } else {
      return null;
    }
  }

  Future<bool> isAuth() async {
    // Check if auth data exists in local storage
    final prefs = await SharedPreferences.getInstance();
    final authData = prefs.getString('auth_data');
    if (authData != null) {
      return true;
    } else {
      return false;
    }
  }

  // Future<void> saveToken(String token) async {
  //   // Save token to local storage
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('token', token);
  // }

  Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyUserId, userId);
  }

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    print('Retrieved userId: $userId'); // Tambahkan log ini.
    return userId;
  }

  Future<void> saveFavorite(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_keyFavorites) ?? [];

    // Add the product JSON string to the list
    favorites.add(product.toJson());

    // Save the updated list to SharedPreferences
    await prefs.setStringList(_keyFavorites, favorites);
  }

  Future<void> removeFavorite(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_keyFavorites) ?? [];

    // Remove the product JSON string from the list
    favorites.removeWhere((item) => Product.fromJson(item).id == product.id);

    // Save the updated list to SharedPreferences
    await prefs.setStringList(_keyFavorites, favorites);
  }

  Future<List<Product>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_keyFavorites) ?? [];

    // Convert each JSON string in the list back to a Product object
    return favorites.map((item) => Product.fromJson(item)).toList();
  }
}
