import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kos_mobile_v2_testing/presentation/home/bloc/all_product/all_product_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/home/bloc/bidar_product/bidar_product_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/home/bloc/uin_product/uin_product_bloc.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/search_input.dart';
import '../../../core/components/spaces.dart';
import '../../../core/router/app_router.dart';

import '../widgets/banner_slider.dart';
import '../widgets/organism/menu_categories.dart';
import '../widgets/organism/product_list.dart';
import '../widgets/theme.dart';
import '../widgets/title_content.dart';

import 'package:badges/badges.dart' as badges;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController searchController;

  final List<String> banners1 = [
    Assets.images.banner1.path,
    Assets.images.banner2.path,
  ];

  @override
  void initState() {
    searchController = TextEditingController();
    // BlocProvider.of<AllProductBloc>(context).add(
    //   const AllProductEvent.getAllProducts(),
    // );
    context.read<AllProductBloc>().add(
          const AllProductEvent.getAllProducts(),
        );
    context.read<BidarProductBloc>().add(
          const BidarProductEvent.getBidarProducts(),
        );
    context.read<UinProductBloc>().add(
          const UinProductEvent.getUinProducts(),
        );

    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFFAFAFA),
      appBar: AppBar(
        title: const Text('KosPal'),
        backgroundColor: bgColor,
        actions: [
          BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              return state.maybeWhen(
                loaded: (checkout, _, __, ___) {
                  final totalQuantity = checkout.fold<int>(
                    0,
                    (previousValue, element) =>
                        previousValue + element.quantity,
                  );
                  return totalQuantity > 0
                      ? badges.Badge(
                          badgeContent: Text(
                            totalQuantity.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {
                              context.goNamed(
                                RouteConstants.cart,
                                pathParameters: PathParameters().toMap(),
                              );
                            },
                            icon: Assets.icons.cart.svg(height: 24.0),
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            context.goNamed(
                              RouteConstants.cart,
                              pathParameters: PathParameters().toMap(),
                            );
                          },
                          icon: Assets.icons.cart.svg(height: 24.0),
                        );
                },
                orElse: () {
                  return IconButton(
                    onPressed: () {
                      context.goNamed(
                        RouteConstants.cart,
                        pathParameters: PathParameters().toMap(),
                      );
                    },
                    icon: Assets.icons.cart.svg(height: 24.0),
                  );
                },
              );

              // return badges.Badge(
              //   badgeContent: const Text(
              //     '1',
              //     style: TextStyle(
              //       color: Colors.white,
              //     ),
              //   ),
              //   child: IconButton(
              //     onPressed: () {
              //       context.goNamed(
              //         RouteConstants.cart,
              //         pathParameters: PathParameters().toMap(),
              //       );
              //     },
              //     icon: Assets.icons.cart.svg(height: 24.0),
              //   ),
              // );
            },
          ),
          IconButton(
            onPressed: () {},
            icon: Assets.icons.notification.svg(height: 24.0),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SearchInput(
            controller: searchController,
            onTap: () {
              context.pushReplacementNamed(
                RouteConstants.root,
                pathParameters: PathParameters(
                  rootTab: RootTab.search,
                ).toMap(),
              );
            },
          ),
          const SpaceHeight(16.0),
          BannerSlider(items: banners1),
          const SpaceHeight(12.0),
          TitleContent(
            title: 'Area Populer',
            onSeeAllTap: () {},
          ),
          const MenuCategories(),
          const SpaceHeight(28.0),
          //const SpaceHeight(50.0),
          BlocBuilder<AllProductBloc, AllProductState>(
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
                    title: 'Kamar Kos',
                    onSeeAllTap: () {
                      // context.goNamed(
                      //   RouteConstants.allProduct,
                      //   pathParameters: PathParameters().toMap(),
                      // );
                    },
                    items:
                        products.length > 4 ? products.sublist(0, 5) : products,
                  );
                },
              );
            },
          ),
          const SpaceHeight(18.0),
          // BlocBuilder<BidarProductBloc, BidarProductState>(
          //   builder: (context, state) {
          //     return state.maybeWhen(
          //       loading: () => const Center(
          //         child: CircularProgressIndicator(),
          //       ),
          //       error: (message) => Center(
          //         child: Text(message),
          //       ),
          //       orElse: () => const SizedBox(),
          //       loaded: (products) {
          //         return ProductList(
          //           title: 'Bidar',
          //           onSeeAllTap: () {
          //             // context.goNamed(
          //             //   RouteConstants.allProduct,
          //             //   pathParameters: PathParameters().toMap(),
          //             // );
          //           },
          //           items: products,
          //         );
          //       },
          //     );
          //   },
          // ),
          BlocBuilder<BidarProductBloc, BidarProductState>(
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
                    title: 'Bidar',
                    onSeeAllTap: () {
                      // Handle onSeeAllTap action here
                    },
                    items: products,
                  );
                },
              );
            },
          ),
          const SpaceHeight(18.0),
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
