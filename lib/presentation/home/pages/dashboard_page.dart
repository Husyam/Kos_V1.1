import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kos_mobile_v2_testing/presentation/home/pages/favorite_page.dart';
import 'package:kos_mobile_v2_testing/presentation/home/pages/homepage.dart';
import 'package:kos_mobile_v2_testing/presentation/home/pages/maps_page.dart';
import 'package:kos_mobile_v2_testing/presentation/orders/pages/cart_page.dart';
import 'package:kos_mobile_v2_testing/presentation/search/pages/product_search_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/constants/colors.dart';
import '../../../core/router/app_router.dart';
import '../../../data/datasources/auth_local_datasource.dart';
import '../../../data/datasources/product_remote_datasource.dart';
import '../../../data/models/responses/product_response_mode.dart';
import '../../account/pages/profile_screen.dart';
import '../../auth/bloc/login/login_bloc.dart';
import '../widgets/theme.dart';

class DashboardPage extends StatefulWidget {
  final int currentTab;

  const DashboardPage({
    Key? key,
    required this.currentTab,
  }) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  ProductResponseModel? _productResponseModel;
  bool _isLoading = true;

  @override
  void initState() {
    _selectedIndex = widget.currentTab;
    super.initState();
    _fetchProductData();
  }

  Future<void> _fetchProductData() async {
    final remoteDataSource = ProductRemoteDatasource();
    final response = await remoteDataSource.getAllProducts();

    response.fold(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
        setState(() {
          _isLoading = false;
        });
      },
      (productResponseModel) {
        setState(() {
          _productResponseModel = productResponseModel;
          _isLoading = false;
        });
      },
    );
  }

  void _onItemTapped(int index) async {
    if (index == 5) {
      final userId = await AuthLocalDatasource().getUserId();
      if (userId != null) {
        const LoginState.loading();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(userId: userId),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login Terlebih Dahulu'),
          ),
        );
        context.goNamed(
          RouteConstants.login,
        );
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: LoadingAnimationWidget.discreteCircle(
            color: const Color.fromARGB(255, 75, 138, 190),
            size: 45,
            secondRingColor: Colors.black,
            thirdRingColor: Colors.purple,
          ),
        ),
      );
    }

    final List<Widget> _pages = [
      const HomePage(),
      MapsPage(productResponseModel: _productResponseModel!),
      const FavoritePage(),
      const CartPage(),
      const SearchPage(),
    ];

    return Scaffold(
      backgroundColor: bgColor,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: bgColor,
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Assets.icons.home.svg(
              colorFilter:
                  const ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
            ),
            activeIcon: Assets.icons.home.svg(),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.maps.svg(
              colorFilter:
                  const ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
            ),
            activeIcon: Assets.icons.maps.svg(),
            label: 'MAPS',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.like.svg(
              colorFilter:
                  const ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
            ),
            activeIcon: Assets.icons.like.svg(),
            label: 'LIKE',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.cart.svg(
              colorFilter:
                  const ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
            ),
            activeIcon: Assets.icons.cart.svg(),
            label: 'CART',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.search.svg(
              colorFilter:
                  const ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
            ),
            activeIcon: Assets.icons.search.svg(),
            label: 'SEARCH',
          ),
          // Profile
          BottomNavigationBarItem(
            icon: Assets.icons.person.svg(
              colorFilter:
                  const ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
            ),
            activeIcon: Assets.icons.person.svg(),
            label: 'PROFILE',
          ),
        ],
      ),
    );
  }
}
