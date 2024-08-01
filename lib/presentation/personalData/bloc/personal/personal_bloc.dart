// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasources/personal_remote_datasource.dart';
import '../../../../data/models/responses/personalData_response_model.dart';

part 'personal_bloc.freezed.dart';
part 'personal_event.dart';
part 'personal_state.dart';

class PersonalBloc extends Bloc<PersonalEvent, PersonalState> {
  final PersonalRemoteDatasource personalRemoteDatasource;

  PersonalBloc(
    this.personalRemoteDatasource,
  ) : super(const _Initial()) {
    //   on<_GetPersonalData>((event, emit) async {
    //     emit(const _Loading());
    //     //print('Loading state emitted');
    //     final response = await personalRemoteDatasource.getPersonalData();
    //     // response.fold(
    //     //   (l) {
    //     //     print('Error state emitted');
    //     //     emit(const _Error('Error'));
    //     //   },
    //     //   (r) {
    //     //     print('Loaded state emitted with data: ${r.data}');
    //     //     emit(_Loaded(r.data ?? []));
    //     //   },
    //     // );
    //     response.fold(
    //       (l) => emit(const _Error('Error')),
    //       (r) {
    //         if (r.data != null && r.data!.isNotEmpty) {
    //           emit(_Loaded(r.data!));
    //         } else {
    //           emit(const _Error('No data available'));
    //         }
    //       },
    //     );
    //   });
    // }
    on<_GetPersonalData>((event, emit) async {
      emit(const _Loading());
      print('Loading state emitted');
      final response = await personalRemoteDatasource.getPersonalData();
      response.fold(
        (l) {
          print('Error state emitted');
          emit(const _Error('Error'));
        },
        (r) {
          print('Loaded state emitted with data: ${r.data}');
          if (r.data != null && r.data!.isNotEmpty) {
            emit(_Loaded(r.data!));
          } else {
            emit(const _Error('No data available'));
          }
        },
      );
    });
  }
}
