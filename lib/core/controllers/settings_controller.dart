import 'package:get/get.dart';

class SettingsController extends GetxController {
  var isDarkMode = false.obs;
  var isNotificationEnabled = true.obs;
  var isLocationEnabled = true.obs;

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
    // You can add theme switching logic here
  }

  void toggleNotification(bool value) {
    isNotificationEnabled.value = value;
  }

  void toggleLocation(bool value) {
    isLocationEnabled.value = value;
  }
}