import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:organic_grow/core/controllers/cart_controller.dart';
import 'package:organic_grow/core/controllers/dashBoard_controller.dart';
import 'package:organic_grow/core/controllers/connectivity_controller.dart';
import 'package:organic_grow/core/controllers/home_page_controller.dart';
import 'package:organic_grow/core/controllers/profile_controller.dart';
import 'package:organic_grow/core/controllers/settings_controller.dart';



class DashBoardScreen extends GetView<DashBoardController> {
  DashBoardScreen({super.key}) {
    Get.lazyPut<DashBoardController>(() => DashBoardController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<SettingsController>(() => SettingsController());
    Get.lazyPut<CartController>(() => CartController());
    
    Get.put(ConnectivityController()); // inject connectivity controller
  }

  @override
  Widget build(BuildContext context) {
    final connectivityController = Get.find<ConnectivityController>();

    return Scaffold(
      body: Obx(() {
        if (!connectivityController.isConnected) {
          // ❌ Show no internet UI
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wifi_off, size: 80, color: Colors.red),
                const SizedBox(height: 20),
                const Text(
                  "No Internet Connection",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await connectivityController.checkConnection(); // ✅ manual retry
                  },
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        }

        // ✅ Normal dashboard content
        return controller.screens[controller.selectedIndex.value];
      }),
      bottomNavigationBar: Obx(() {
        return CurvedNavigationBar(
          index: controller.selectedIndex.value,
          height: 60,
          color: Colors.purple,
          buttonBackgroundColor: Colors.purple,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 400),
          items: const [
            Icon(Icons.person, size: 30, color: Colors.white),
            Icon(Icons.category, size: 30, color: Colors.white),
            Icon(Icons.home, size: 30, color: Colors.white),
            Icon(Icons.card_travel, size: 30, color: Colors.white),
            Icon(Icons.settings, size: 30, color: Colors.white),
          ],
          onTap: (index) {
            controller.onTabChange(index);
            connectivityController.checkConnection(); // ✅ optional: recheck when switching tab
          },
        );
      }),
    );
  }
}
