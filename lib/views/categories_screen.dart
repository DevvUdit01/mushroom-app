import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organic_grow/config/app_color.dart';
import 'package:organic_grow/core/controllers/home_page_controller.dart';
import 'package:organic_grow/core/models/category_model.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: AppColor.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (homeController.isLoading.value) {
          return _buildLoadingState();
        }
        
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemCount: homeController.categories.length,
          itemBuilder: (context, index) {
            final category = homeController.categories[index];
            return _buildCategoryCard(category);
          },
        );
      }),
    );
  }

  Widget _buildLoadingState() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColor.lightGreyColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 100,
                  height: 16,
                  color: AppColor.lightGreyColor,
                ),
                const SizedBox(height: 8),
                Container(
                  width: 80,
                  height: 14,
                  color: AppColor.lightGreyColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryCard(Category category) {
    final icon = _getIconFromString(category.icon);
    
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () => _navigateToCategoryProducts(category),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: AppColor.primaryColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                category.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                '${_getRandomProductCount()} products',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.greyColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _getRandomProductCount() {
    return 20 + (DateTime.now().millisecondsSinceEpoch % 30);
  }

  void _navigateToCategoryProducts(Category category) {
    Get.toNamed('/category-products', arguments: {'category': category});
  }

  // Helper function to convert string to IconData
  IconData _getIconFromString(String iconName) {
    switch (iconName) {
      case 'local_florist':
        return Icons.local_florist;
      case 'emoji_food_beverage':
        return Icons.emoji_food_beverage;
      case 'local_drink':
        return Icons.local_drink;
      case 'kitchen':
        return Icons.kitchen;
      case 'spa':
        return Icons.spa;
      default:
        return Icons.category;
    }
  }
}