import 'package:dartz/dartz.dart';
import 'package:kos_mobile_v2_testing/data/datasources/auth_local_datasource.dart';

import '../../core/constants/variables.dart';
import '../models/responses/edit_profile_response_model.dart';
import 'package:http/http.dart' as http;

class AuthEditProfileDatasource {
  Future<Either<String, EditProfileResponseModel>> updateProfile(
      String name, String email, String phone, String password) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/edit-akun'),
      headers: {
        'Authorization': 'Bearer ${authData?.accessToken}',
        'Accept': 'application/json',
        // 'Content-Type': 'application/json',
      },
      body: {
        //body di isi boleh null atau tidak wajib di isi
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return Right(EditProfileResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }
}
