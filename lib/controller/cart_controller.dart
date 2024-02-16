import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../database/database_helper_cart.dart';
import '../model/product_cart.dart';
import '../model/product_list.dart';

class CartController extends GetxController{
  var cartList = List<ProductCart>.empty().obs;
  var totalQuantity = 0.obs;
  var totalPrice = 0.0.obs;

  void addToCart(String id, String title, String content, String image, String thumbnail, String userId, int quantity) async {
    print('cart');
    print(id+'/'+ userId+ quantity.toString());
    final existingProductIndex = cartList.indexWhere((p) => p.id == id);

    if (existingProductIndex == -1) {
      final newProduct = ProductCart(
        id: id,
        title: title,
        content: content,
        image: image,
        thumbnail: thumbnail,
        userId: userId,
        quantity: 1,
      );

      if (existingProductIndex == -1) {
        cartList.add(newProduct);
      } else {
        cartList[existingProductIndex] = newProduct;
      }

      totalQuantity.value += 1;
      totalPrice.value += double.parse(userId);

      await DatabaseHelperCart.instance.insert(ProductCart(
        id: id,
        title: title,
        content: content,
        image: image,
        thumbnail: thumbnail,
        userId: userId,
        quantity: 1
      ));

      Fluttertoast.showToast(
        msg: 'Added to Cart',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      final existingProduct = cartList[existingProductIndex];
      existingProduct.quantity += 1;
    }

    update();
  }

  void removeFromCart(ProductCart product) async {
    cartList.removeWhere((p) => p.id == product.id);
    totalQuantity.value -= product.quantity;
    totalPrice.value -= (double.parse(product.userId) * product.quantity);

    int id = int.parse(product.id.toString());
    await DatabaseHelperCart.instance.delete(id);

    update();
    Fluttertoast.showToast(
        msg: 'Removed from Cart',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void increment(ProductCart product) async {
    final existingProductIndex = cartList.indexWhere((p) => p.id == product.id);
    if (existingProductIndex != -1) {
      final existingProduct = cartList[existingProductIndex];
      if (existingProduct.quantity < 5) {
        existingProduct.quantity++;
        totalQuantity.value++;
        totalPrice.value += double.parse(existingProduct.userId);
        update(); // Update the UI

        // Update the database as well
        await DatabaseHelperCart.instance.incrementQuantity(product.id);

      } else {
        Fluttertoast.showToast(
            msg: 'Not more than 5 items!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blueAccent,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } // Update the UI
  }

  void decrement(ProductCart product) async{
    final existingProductIndex = cartList.indexWhere((p) => p.id == product.id);
    if (existingProductIndex != -1) {
      final existingProduct = cartList[existingProductIndex];
      if (existingProduct.quantity > 1) {
        existingProduct.quantity--;
        totalQuantity.value--;
        totalPrice.value -= double.parse(existingProduct.userId);
        update();
        // Update the database as well
        await DatabaseHelperCart.instance.decrementQuantity(product.id);// Update the UI
      }
    }
  }

  void fetchDataFromDatabase() async {
    List<Map<String, dynamic>> data = await DatabaseHelperCart.instance.queryAllRows();
    cartList.clear();

    for (var item in data) {
      ProductCart product = ProductCart.fromJson(item);
      cartList.add(product);
      totalQuantity.value += product.quantity;
      totalPrice.value += product.userId * product.quantity;
    }

    update();
  }


}