import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kos_mobile_v2_testing/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/home/widgets/theme.dart';
import 'package:kos_mobile_v2_testing/presentation/personalData/bloc/personal/personal_bloc.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../core/core.dart';
import '../../../core/router/app_router.dart';
import '../widgets/address_tile.dart';

class DataDiri extends StatefulWidget {
  const DataDiri({super.key});

  @override
  State<DataDiri> createState() => _AddressPageState();
}

class _AddressPageState extends State<DataDiri> {
  @override
  void initState() {
    super.initState();
    // context.read<PersonalBloc>().add(
    //       const PersonalEvent.getPersonalData(),
    //     );
    // context.read<PersonalBloc>().add(
    //       const PersonalEvent.getPersonalData(),
    //     );
    context.read<PersonalBloc>().add(
          const PersonalEvent.getPersonalData(),
        );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<PersonalBloc>().add(
          const PersonalEvent.getPersonalData(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Data Pemesan'),
        backgroundColor: bgColor,
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       // context.goNamed(
        //       //   RouteConstants.cart,
        //       //   pathParameters: PathParameters(
        //       //     rootTab: RootTab.order,
        //       //   ).toMap(),
        //       // );
        //     },
        //     icon: Assets.icons.cart.svg(height: 24.0),
        //   ),
        // ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const Text(
            'Pilih salah satu data pemesan yang akan digunakan',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const SpaceHeight(20.0),
          BlocBuilder<PersonalBloc, PersonalState>(
            builder: (context, state) {
              print('Current state: $state');
              return state.maybeWhen(
                orElse: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                loaded: (personalData) {
                  print('Loaded personal data: $personalData');
                  return BlocBuilder<CheckoutBloc, CheckoutState>(
                    builder: (context, state) {
                      final personalDataId = state.maybeWhen(
                        orElse: () => 0,
                        loaded: (checkout, addPersonalDataId, __, ___) {
                          return addPersonalDataId;
                        },
                      );
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: personalData.length,
                        itemBuilder: (context, index) => AddressTile(
                          isSelected: personalDataId ==
                              personalData[index].idPersonalData,
                          data: personalData[index],
                          onTap: () {
                            context.read<CheckoutBloc>().add(
                                  CheckoutEvent.addPersonalDataId(
                                      personalData[index].idPersonalData!),
                                );
                          },
                          onEditTap: () {
                            context.goNamed(
                              RouteConstants.editBiodata,
                              pathParameters:
                                  PathParameters(rootTab: RootTab.cart).toMap(),
                              extra: personalData[index],
                            );
                          },
                        ),
                        separatorBuilder: (context, index) =>
                            const SpaceHeight(16.0),
                      );
                    },
                  );
                },
              );
            },
          ),
          const SpaceHeight(40.0),
          Button.outlined(
            onPressed: () {
              context.goNamed(
                RouteConstants.addBiodataPage,
                pathParameters: PathParameters(
                  rootTab: RootTab.cart,
                ).toMap(),
              );
            },
            label: 'Tambah Data Pemesan',
          ),
          const SpaceHeight(50.0),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Subtotal (Estimasi)',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                BlocBuilder<CheckoutBloc, CheckoutState>(
                  builder: (context, state) {
                    final subTotal = state.maybeWhen(
                      orElse: () => 0,
                      loaded: (checkout, _, __, ___) {
                        return checkout.fold<int>(
                          0,
                          (previousValue, element) =>
                              previousValue +
                              (element.quantity * element.product.price!),
                        );
                      },
                    );
                    return Text(
                      subTotal.currencyFormatRp,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SpaceHeight(12.0),
            Button.filled(
              onPressed: () {
                context.goNamed(
                  RouteConstants.orderDetail,
                  pathParameters: PathParameters(
                    rootTab: RootTab.cart,
                  ).toMap(),
                );
              },
              label: 'Lanjutkan',
            ),
          ],
        ),
      ),
    );
  }
}
