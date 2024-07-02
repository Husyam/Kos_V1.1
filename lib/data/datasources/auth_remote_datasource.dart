import 'package:dartz/dartz.dart';
import 'package:kos_mobile_v2_testing/core/constants/variables.dart';
import 'package:kos_mobile_v2_testing/data/datasources/auth_local_datasource.dart';
import 'package:kos_mobile_v2_testing/data/models/responses/auth_response_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
      String email, String password) async {
    // Call login API
    // If success, return Right(token)
    // If error, return Left(errorMessage)
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/login'),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  //logout
  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/logout'),
      headers: {
        'Authorization': 'Bearer ${authData?.accesToken}',
      },
    );
    if (response.statusCode == 200) {
      AuthLocalDatasource().remoAuthData();
      return const Right('Logout Success');
    } else {
      return const Left('Logout Failed');
    }
  }
}
