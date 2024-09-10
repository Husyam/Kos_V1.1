import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/home/bloc/unsri_product/unsri_product_bloc.dart';

import '../../widgets/organism/product_list.dart';

class UnsriPage extends StatelessWidget {
  const UnsriPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UNSRI'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          BlocBuilder<UnsriProductBloc, UnsriProductState>(
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
                    title: 'Unsri',
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
