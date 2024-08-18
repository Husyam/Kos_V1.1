import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:kos_mobile_v2_testing/core/constants/variables.dart';
import 'package:kos_mobile_v2_testing/data/models/requests/personal_request_model.dart';
import 'package:kos_mobile_v2_testing/data/models/responses/personalData_response_model.dart';

import 'auth_local_datasource.dart';

// class PersonalRemoteDatasource {
//   Future<Either<String, PersonalResponseModel>> getPersonalData() async {
//     try {
//       final authData = await AuthLocalDatasource().getAuthData();
//       final response = await http.get(
//         Uri.parse('${Variables.baseUrl}/api/personal-data'),
//         headers: {
//           'Authorization': 'Bearer ${authData!.accesToken}',
//           'Accept': 'application/json',
//         },
//       );

//       // Tambahkan logging di sini
//       print('Response status: ${response.statusCode}');
//       print('Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         return Right(PersonalResponseModel.fromJson(response.body));
//       } else {
//         return const Left('Error');
//       }
//     } catch (e) {
//       return const Left('Error');
//     }
//   }
// }

class PersonalRemoteDatasource {
  Future<Either<String, PersonalResponseModel>> getPersonalData() async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      if (authData == null || authData.accessToken == null) {
        return const Left('Unauthenticated');
      }
      final response = await http.get(
        Uri.parse('${Variables.baseUrl}/api/personal-data'),
        headers: {
          'Authorization': 'Bearer ${authData.accessToken}',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return Right(PersonalResponseModel.fromJson(response.body));
      } else {
        return Left('Error: ${response.body}');
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }

  Future<Either<String, String>> addPersonalData(
      PersonalRequestModel data) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final response = await http.post(
        Uri.parse('${Variables.baseUrl}/api/personal-data'),
        headers: {
          'Authorization': 'Bearer ${authData!.accessToken}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: data.toJson(),
      );

      if (response.statusCode == 201) {
        return const Right('Success');
      } else {
        print('Error: ${response.body}'); // Log response body
        return Left('Error: ${response.body}');
      }
    } catch (e) {
      print('Exception: $e'); // Log exception
      return const Left('Error');
    }
  }
}
