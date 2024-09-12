import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/home/widgets/organism/categories_list.dart';

import '../../bloc/uin_product/uin_product_bloc.dart';
import '../../widgets/organism/product_list.dart';

class UinPage extends StatelessWidget {
  const UinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('UIN'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          BlocBuilder<UinProductBloc, UinProductState>(
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
                  return CategoriesList(title: 'uin', items: products);
                },
              );
              // return ProductList(
              //   title: 'UIN Raden Fatah Palembang',
              //   onSeeAllTap: () {},
              //   items: bestSellers,
              // );
            },
          ),
        ],
      ),
    );
  }
}
