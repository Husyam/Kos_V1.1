import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/home/bloc/uigm_product/uigm_product_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/home/widgets/organism/categories_list.dart';

import '../../bloc/bidar_product/bidar_product_bloc.dart';
import '../../widgets/organism/product_list.dart';

class UigmPage extends StatelessWidget {
  const UigmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('UIGM'),
        centerTitle: true,
        backgroundColor: Colors.white,
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
                  return CategoriesList(title: 'uigm', items: products);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
