import 'package:get/get.dart';
import 'package:organic_grow/core/models/user_model.dart';

class ProfileController extends GetxController {
  var user = User(
    id: '1',
    name: 'John Doe',
    email: 'john.doe@example.com',
    phone: '+1234567890',
    address: '123 Green Street, Organic City',
    image: 'assets/user_profile.jpg',
  ).obs;

  void updateUser(User newUser) {
    user.value = newUser;
  }

  void updateProfile(String name, String email, String phone, String address) {
    user.update((val) {
      val!.name = name;
      val.email = email;
      val.phone = phone;
      val.address = address;
    });
  }
}