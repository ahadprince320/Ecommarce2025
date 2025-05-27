import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import 'Provider/cart_provider.dart';
import 'Screens/Card/CardScreen.dart';
import 'Screens/ProfileScreen.dart';
import 'Screens/SearchScreen.dart';
import 'Screens/home_screen.dart';

class bottombar extends StatefulWidget {
  static const routeName = '/bottombar';
  const bottombar({super.key});

  @override
  State<bottombar> createState() => _bottombarState();
}

class _bottombarState extends State<bottombar> {
  late List<Widget> screens;
  int currentScreen = 0;
  late PageController controller;
  @override
  void initState() {
    super.initState();
    screens = [HomeScreen(), SearchScreen(), CartScreen(), ProfileScreen()];
    controller = PageController(initialPage: currentScreen);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentScreen,
        elevation: 10,
        height: kBottomNavigationBarHeight,
        onDestinationSelected: (index) {
          setState(() {
            currentScreen = index;
          });
          controller.jumpToPage(currentScreen);
        },
        destinations: [
          const NavigationDestination(
            selectedIcon: Icon(IconlyBold.home),
            icon: Icon(IconlyLight.home),
            label: "Home",
          ),
          const NavigationDestination(
            selectedIcon: Icon(IconlyBold.search),
            icon: Icon(IconlyLight.search),
            label: "Search",
          ),
          NavigationDestination(
            selectedIcon: const Icon(IconlyBold.bag2),
            icon: Badge(
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              label: Text(cartProvider.getCartitems.length.toString()),
              child: const Icon(IconlyLight.bag2),
            ),
            label: "Cart",
          ),
          const NavigationDestination(
            selectedIcon: Icon(IconlyBold.profile),
            icon: Icon(IconlyLight.profile),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
