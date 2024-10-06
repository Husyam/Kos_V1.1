import 'package:dartz/dartz.dart';
import 'package:kos_mobile_v2_testing/core/constants/variables.dart';
import 'package:kos_mobile_v2_testing/data/datasources/auth_local_datasource.dart';
import 'package:kos_mobile_v2_testing/data/models/responses/auth_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
      String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${Variables.baseUrl}/api/login'),
        body: {
          'email': email,
          'password': password,
          // 'message': 'Login success',
        },
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final authResponseModel = AuthResponseModel.fromJson(response.body);
        final userId = authResponseModel.user?.idUser;
        if (userId != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setInt('userId', userId);
          print('UserId saved: $userId');
        }
        print('Login success, token: ${authResponseModel.accessToken}');
        // return Right(authResponseModel);
        return Right(AuthResponseModel.fromJson(response.body));
      } else {
        return Left(response.body);
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }

  //register
  Future<Either<String, AuthResponseModel>> register(
      String email, String name, String phone, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${Variables.baseUrl}/api/register'),
        body: {
          'email': email,
          'name': name,
          'phone': phone,
          'password': password,
        },
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final authResponseModel = AuthResponseModel.fromJson(response.body);
        final userId = authResponseModel.user?.idUser;
        if (userId != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setInt('userId', userId);
          print('UserId saved: $userId');
        }
        print('Register success, token: ${authResponseModel.accessToken}');
        return Right(authResponseModel);
      } else {
        return Left(response.body);
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    print('Retrieved userId: $userId');
    return userId;
  }

  Future<AuthResponseModel?> getAuthData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final authData = prefs.getString('authData');
    if (authData != null) {
      return AuthResponseModel.fromJson(authData);
    }
    return null;
  }

  Future<void> removeAuthData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('authData');
  }

  //logout
  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
        Uri.parse('${Variables.baseUrl}/api/logout'),
        headers: {'Authorization': 'Bearer ${authData?.accessToken}'});

    if (response.statusCode == 200) {
      AuthLocalDatasource().removeAuthData();
      return Right(response.body);
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, AuthResponseModel>> getProfile(int userId) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/login/$userId'),
      headers: {
        'Authorization': 'Bearer ${authData?.accessToken}',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  //update fcm
  Future<Either<String, String>> updateFcmToken(String fcmToken) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/update-fcm'),
      headers: {
        'Authorization': 'Bearer ${authData?.accessToken}',
        'Accept': 'application/json',
        // 'Content-Type': 'application/json',
      },
      body: {
        'fcm_id': fcmToken,
      },
    );
    if (response.statusCode == 200) {
      return Right(response.body);
    } else {
      return Left(response.body);
    }
  }
}
