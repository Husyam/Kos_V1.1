import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kos_mobile_v2_testing/core/router/app_router.dart';
import 'package:kos_mobile_v2_testing/data/datasources/category_remote_datasource.dart';
import 'package:kos_mobile_v2_testing/data/datasources/product_remote_datasource.dart';
import 'package:kos_mobile_v2_testing/presentation/home/bloc/all_product/all_product_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/home/bloc/bidar_product/bidar_product_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/home/bloc/uin_product/uin_product_bloc.dart';

import 'presentation/home/bloc/category/category_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    final router = appRouter.router;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoryBloc(CategoryRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => AllProductBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => BidarProductBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => UinProductBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
          useMaterial3: true,
        ),
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
      ),
    );
  }
}
