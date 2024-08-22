import 'package:flutter/material.dart';
import 'package:moonlit/models/product_model.dart';
import 'package:provider/provider.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _cart = [];

  List<Product> get cart => _cart;

  void clearCart() {
    cart.clear();
    notifyListeners();
  }

  // Toggle cart state
  void toggleCart(Product product) {
    if (_cart.contains(product)) {
      // If the product is already in the cart, increment quantity
      int index = _cart.indexOf(product);
      _cart[index].quantity++;
    } else {
      // If the product is not in the cart, add it with quantity 1
      product.quantity = 1; // Ensure the product has a quantity when added
      _cart.add(product);
    }
    notifyListeners();
  }

  // Increment quantity
  void incrementQtn(int index) {
    if (index >= 0 && index < _cart.length) {
      _cart[index].quantity++;
      notifyListeners();
    }
  }

  // Decrement quantity
  void decrementQtn(int index) {
    if (index >= 0 && index < _cart.length) {
      if (_cart[index].quantity > 1) {
        _cart[index].quantity--;
      } else {
        // Optionally, you can remove the item if quantity is 1 and decrement is called
        _cart.removeAt(index);
      }
      notifyListeners();
    }
  }

  // Calculate total price
  double totalPrice() {
    double total = 0.0;
    for (Product product in _cart) {
      total += product.price * product.quantity;
    }
    return total;
  }

  // Get CartProvider instance
  static CartProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<CartProvider>(
      context,
      listen: listen,
    );
  }
}
