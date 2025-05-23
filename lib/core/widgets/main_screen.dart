import 'package:flutter/material.dart';
import 'package:cozykart/features/home/presentation/pages/home_screen.dart';
import 'package:cozykart/features/profile/presentation/views/profile_view.dart';
import 'package:cozykart/features/shop/presentation/views/shop_view.dart';
import 'package:cozykart/features/wishlist/presentation/views/wishlist_view.dart';
import 'package:cozykart/features/cart/presentation/views/cart_view.dart';
import 'package:cozykart/core/widgets/custom_drawer.dart';
import 'package:cozykart/generated/l10n.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static const String routeName = '/MainScreen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  void navigateToTab(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final List<Widget> tabs = const [
    HomeScreen(),
    ShopView(),
    WishlistView(),
    CartView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    final titles = [
      local.home,
      local.shop,
      local.wishlist,
      local.cart,
      local.profile,
    ];

    return Scaffold(
      appBar: AppBar(title: Text(titles[currentIndex])),
      drawer: CustomDrawer(onTabSelected: navigateToTab),
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => navigateToTab(index),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            label: local.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.store_outlined),
            label: local.shop,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite_border_outlined),
            label: local.wishlist,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_cart_outlined),
            label: local.cart,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            label: local.profile,
          ),
        ],
      ),
    );
  }
}
