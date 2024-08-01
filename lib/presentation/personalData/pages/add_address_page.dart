import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kos_mobile_v2_testing/presentation/personalData/bloc/addpersonaldata/addpersonaldata_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/personalData/bloc/personal/personal_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/personalData/widgets/custom_dropdown.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/components/spaces.dart';
import '../../../core/router/app_router.dart';
import '../../../data/models/requests/personal_request_model.dart';

class AddAddressPage extends StatelessWidget {
  const AddAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final fullNameController = TextEditingController();
    final genderController = TextEditingController();
    final professionController = TextEditingController();
    final phoneNumberController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Data Diri'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const SpaceHeight(24.0),
          CustomTextField(
            controller: fullNameController,
            label: 'Nama Lengkap',
          ),
          const SpaceHeight(24.0),
          // CustomTextField(
          //   controller: genderController,
          //   label: 'Jenis Kelamin',
          // ),
          CustomDropdown<String>(
            value: '-',
            items: const ['-', 'Laki-laki', 'Perempuan'],
            label: 'Jenis Kelamin',
            // onChanged: (value) {
            //   print('Nilai yang dipilih: $value');
            // },
            onChanged: (value) {
              if (value != null) {
                genderController.text = value;
              }
            },
          ),
          const SpaceHeight(24.0),
          CustomTextField(
            controller: professionController,
            label: 'Profesi',
          ),
          const SpaceHeight(24.0),
          CustomTextField(
            controller: phoneNumberController,
            label: 'No Handphone',
          ),
          const SpaceHeight(24.0),
          BlocConsumer<AddpersonaldataBloc, AddpersonaldataState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                loaded: () {
                  context.goNamed(
                    RouteConstants.address,
                    pathParameters: PathParameters(
                      rootTab: RootTab.cart,
                    ).toMap(),
                  );
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return Button.filled(
                    onPressed: () {
                      if (fullNameController.text.isEmpty ||
                          genderController.text.isEmpty ||
                          professionController.text.isEmpty ||
                          phoneNumberController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Harap isi semua field')),
                        );
                        return;
                      }
                      context.read<AddpersonaldataBloc>().add(
                            AddpersonaldataEvent.addPersonalData(
                              personalRequestModel: PersonalRequestModel(
                                name: fullNameController.text,
                                gender: genderController.text,
                                profession: professionController.text,
                                contact: phoneNumberController.text,
                                isDefault: 0,
                              ),
                            ),
                          );
                    },
                    label: 'Tambah Data',
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                // error: (message) => Center(
                //   child: Text(message),
                // ),
              );
            },
          ),
        ],
      ),
    );
  }
}
