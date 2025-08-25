import 'package:get/get.dart';
import 'package:organic_grow/core/models/cart_item_model.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;
  var totalAmount = 0.0.obs;

  void addToCart(CartItem item) {
    final existingItemIndex = cartItems.indexWhere((element) => element.id == item.id);
    
    if (existingItemIndex >= 0) {
      cartItems[existingItemIndex].quantity++;
    } else {
      cartItems.add(item);
    }
    
    calculateTotal();
  }

  void removeFromCart(String itemId) {
    cartItems.removeWhere((item) => item.id == itemId);
    calculateTotal();
  }

  void increaseQuantity(String itemId) {
    final item = cartItems.firstWhere((element) => element.id == itemId);
    item.quantity++;
    calculateTotal();
  }

  void decreaseQuantity(String itemId) {
    final item = cartItems.firstWhere((element) => element.id == itemId);
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      removeFromCart(itemId);
    }
    calculateTotal();
  }

  void calculateTotal() {
    totalAmount.value = cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  void clearCart() {
    cartItems.clear();
    totalAmount.value = 0.0;
  }
}