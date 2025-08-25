import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organic_grow/config/app_color.dart';
import 'package:organic_grow/core/controllers/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final SettingsController settingsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: AppColor.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // App Settings
            _buildSettingsCard(
              title: 'App Settings',
              children: [
                Obx(() => _buildSwitchSetting(
                  'Dark Mode',
                  'Enable dark theme',
                  Icons.dark_mode,
                  settingsController.isDarkMode.value,
                  (value) => settingsController.toggleDarkMode(value),
                )),
                Obx(() => _buildSwitchSetting(
                  'Notifications',
                  'Enable push notifications',
                  Icons.notifications,
                  settingsController.isNotificationEnabled.value,
                  (value) => settingsController.toggleNotification(value),
                )),
                Obx(() => _buildSwitchSetting(
                  'Location',
                  'Enable location services',
                  Icons.location_on,
                  settingsController.isLocationEnabled.value,
                  (value) => settingsController.toggleLocation(value),
                )),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Support
            _buildSettingsCard(
              title: 'Support',
              children: [
                _buildSettingsItem(
                  Icons.help,
                  'Help Center',
                  'Get help with the app',
                  () => Get.toNamed('/help'),
                ),
                _buildSettingsItem(
                  Icons.privacy_tip,
                  'Privacy Policy',
                  'Read our privacy policy',
                  () => Get.toNamed('/privacy'),
                ),
                _buildSettingsItem(
                  Icons.description,
                  'Terms of Service',
                  'Read our terms of service',
                  () => Get.toNamed('/terms'),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // About
            _buildSettingsCard(
              title: 'About',
              children: [
                _buildSettingsItem(
                  Icons.info,
                  'About App',
                  'Version 1.0.0',
                  () => Get.toNamed('/about'),
                ),
                _buildSettingsItem(
                  Icons.star,
                  'Rate App',
                  'Rate us on app store',
                  () => _rateApp(),
                ),
                _buildSettingsItem(
                  Icons.share,
                  'Share App',
                  'Share with friends',
                  () => _shareApp(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard({required String title, required List<Widget> children}) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColor.textColor,
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchSetting(String title, String subtitle, IconData icon, bool value, Function(bool) onChanged) {
    return ListTile(
      leading: Icon(icon, color: AppColor.primaryColor),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: TextStyle(color: AppColor.greyColor)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColor.primaryColor,
      ),
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColor.primaryColor),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: TextStyle(color: AppColor.greyColor)),
      trailing: Icon(Icons.chevron_right, color: AppColor.greyColor),
      onTap: onTap,
    );
  }

  void _rateApp() {
    // Implement rate app functionality
    Get.snackbar(
      'Rate App',
      'Redirecting to app store...',
      backgroundColor: AppColor.primaryColor,
      colorText: Colors.white,
    );
  }

  void _shareApp() {
    // Implement share app functionality
    Get.snackbar(
      'Share App',
      'Sharing app with friends...',
      backgroundColor: AppColor.primaryColor,
      colorText: Colors.white,
    );
  }
}