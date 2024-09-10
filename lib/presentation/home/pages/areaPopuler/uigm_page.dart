import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/home/bloc/uigm_product/uigm_product_bloc.dart';

import '../../bloc/bidar_product/bidar_product_bloc.dart';
import '../../widgets/organism/product_list.dart';

class UigmPage extends StatelessWidget {
  const UigmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UIGM'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          BlocBuilder<UigmProductBloc, UigmProductState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (message) => Center(
                  child: Text(message),
                ),
                orElse: () => const SizedBox(),
                loaded: (products) {
                  return ProductList(
                    title: 'UIGM',
                    onSeeAllTap: () {
                      // Handle onSeeAllTap action here
                    },
                    items: products,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
