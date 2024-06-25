// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:kos_mobile_v2_testing/presentation/home/pages/homepage.dart';
import 'package:kos_mobile_v2_testing/presentation/orders/pages/cart_page.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/constants/colors.dart';

class DashboardPage extends StatefulWidget {
  final int currentTab;
  const DashboardPage({
    Key? key,
    required this.currentTab,
  }) : super(key: key);

  @override
  _DashboarPageState createState() => _DashboarPageState();
}

class _DashboarPageState extends State<DashboardPage> {
  late int _selectedIndex;
  final List<Widget> _pages = [
    const HomePage(),
    // const SearchPage(),
    const Center(
      child: Text('This Page Maps'),
    ),
    const Center(
      child: Text('This Page Favorite'),
    ),

    const CartPage(),

    const Center(
      child: Text('This Page cart'),
    ),
    const Center(
      child: Text('This Page Account'),
    ),
  ];

  void _onItemTapped(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  @override
  void initState() {
    _selectedIndex = widget.currentTab;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Assets.icons.home.svg(
              colorFilter: const ColorFilter.mode(
                AppColors.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: Assets.icons.home.svg(),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.maps.svg(
              colorFilter: const ColorFilter.mode(
                AppColors.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: Assets.icons.maps.svg(),
            label: 'MAPS',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.like.svg(
              colorFilter: const ColorFilter.mode(
                AppColors.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: Assets.icons.like.svg(),
            label: 'LIKE',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.cart.svg(
              colorFilter: const ColorFilter.mode(
                AppColors.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: Assets.icons.cart.svg(),
            label: 'CART',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.person.svg(
              colorFilter: const ColorFilter.mode(
                AppColors.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: Assets.icons.person.svg(),
            label: 'ACCOUNT',
          ),
        ],
      ),
    );
  }
}
