import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kos_mobile_v2_testing/data/models/requests/personal_request_model.dart';

import '../../../../data/datasources/personal_remote_datasource.dart';

part 'addpersonaldata_event.dart';
part 'addpersonaldata_state.dart';
part 'addpersonaldata_bloc.freezed.dart';

class AddpersonaldataBloc
    extends Bloc<AddpersonaldataEvent, AddpersonaldataState> {
  final PersonalRemoteDatasource personalRemoteDatasource;
  AddpersonaldataBloc(
    this.personalRemoteDatasource,
  ) : super(const _Initial()) {
    on<_AddPersonalData>((event, emit) async {
      emit(const _Loading());
      final response = await personalRemoteDatasource
          .addPersonalData(event.personalRequestModel);
      response.fold(
        (l) => emit(const _Error('Error')),
        (r) => emit(const _Loaded()),
      );
    });
  }
}
