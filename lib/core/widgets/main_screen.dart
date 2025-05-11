import 'package:flutter/material.dart';
import 'package:furni_iti/features/home/presentation/pages/home_screen.dart';
import 'package:furni_iti/features/profile/presentation/views/profile_view.dart';
import 'package:furni_iti/features/shop/presentation/views/shop_view.dart';
import 'package:furni_iti/features/wishlist/presentation/views/wishlist_view.dart';
import 'package:furni_iti/features/cart/presentation/views/cart_view.dart';
import 'package:furni_iti/core/widgets/custom_drawer.dart';

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

  final List<Widget> tabs = [
    const HomeScreen(),
    const ShopView(),
    const WishlistView(),
    CartView(),
    const ProfileView(),
  ];

  final List<String> titles = ['Home', 'Shop', 'Wishlist', 'Cart', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titles[currentIndex])),
      drawer: CustomDrawer(onTabSelected: navigateToTab),
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => navigateToTab(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store_outlined),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
