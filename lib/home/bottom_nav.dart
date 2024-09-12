
import 'package:demologin/ani/FlagAnimation.dart';
import 'package:demologin/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selectedPosition = 0;
  final controller = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(Icons.add),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomTab(),
    );
  }

  _buildBottomTab() {
    return Scaffold(
        bottomNavigationBar: Obx(
          () => NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            backgroundColor: Colors.white24,
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            destinations: const [
              NavigationDestination(
                  icon: Icon(CupertinoIcons.home), label: "Home"),
              NavigationDestination(
                  icon: Icon(CupertinoIcons.shopping_cart), label: "Store"),
              NavigationDestination(
                  icon: Icon(CupertinoIcons.heart,color: Colors.red,), label: "Wishlist"),
              NavigationDestination(
                  icon: Icon(CupertinoIcons.profile_circled), label: "Profile"),
            ],
          ),
        ),
        body: Obx(() => controller.screen[controller.selectedIndex.value]));
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screen = [
    const HomeScreen(),
    FlagAnimation(),
    Container(color: Colors.orange),
    Container(color: Colors.blueAccent)
  ];
}
