import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/uin_product/uin_product_bloc.dart';
import '../../widgets/organism/product_list.dart';

class UinPage extends StatelessWidget {
  const UinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  return ProductList(
                    title: 'UIN Raden Fatah Palembang',
                    onSeeAllTap: () {
                      // context.goNamed(
                      //   RouteConstants.allProduct,
                      //   pathParameters: PathParameters().toMap(),
                      // );
                    },
                    items: products,
                  );
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
