import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/home/bloc/unsri_product/unsri_product_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/home/widgets/organism/categories_list.dart';


class UnsriPage extends StatelessWidget {
  const UnsriPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('UNSRI'),
        centerTitle: true,
        backgroundColor: Colors.white,
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
                  return CategoriesList(title: 'unsri', items: products);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
