import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kos_mobile_v2_testing/core/router/app_router.dart';
import 'package:kos_mobile_v2_testing/data/datasources/auth_edit_profile_datasource.dart';
import 'package:kos_mobile_v2_testing/data/datasources/auth_remote_datasource.dart';
import 'package:kos_mobile_v2_testing/data/datasources/category_remote_datasource.dart';
import 'package:kos_mobile_v2_testing/data/datasources/firebase_messaging_remote_datasouce.dart';
import 'package:kos_mobile_v2_testing/data/datasources/personal_remote_datasource.dart';
import 'package:kos_mobile_v2_testing/data/datasources/product_remote_datasource.dart';
import 'package:kos_mobile_v2_testing/presentation/account/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/account/bloc/get_profile/get_profile_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/auth/bloc/login/login_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/auth/bloc/register/register_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/home/bloc/all_product/all_product_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/home/bloc/bidar_product/bidar_product_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/home/bloc/uin_product/uin_product_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/orders/bloc/history_order/history_order_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/orders/bloc/order/order_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/orders/bloc/order_detail/order_detail_bloc.dart';
import 'package:kos_mobile_v2_testing/presentation/orders/bloc/status_order/status_order_bloc.dart';

import 'data/datasources/order_remote_datasource.dart';
import 'presentation/home/bloc/category/category_bloc.dart';
import 'presentation/personalData/bloc/addpersonaldata/addpersonaldata_bloc.dart';
import 'presentation/personalData/bloc/personal/personal_bloc.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessagingRemoteDatasource().initialize();
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
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => PersonalBloc(PersonalRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => AddpersonaldataBloc(PersonalRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => OrderBloc(OrderRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => StatusOrderBloc(OrderRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => HistoryOrderBloc(OrderRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => OrderDetailBloc(OrderRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetProfileBloc(AuthRemoteDatasource()),
        ),
        //edit_profile_bloc
        BlocProvider(
          create: (context) => EditProfileBloc(AuthEditProfileDatasource()),
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
