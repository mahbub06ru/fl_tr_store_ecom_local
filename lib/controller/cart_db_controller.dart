import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../database/database_helper_cart.dart';
import '../model/product_cart.dart';
import '../model/product_cart_db.dart';
import '../model/product_list.dart';

class CartDBController extends GetxController{
  var cartDBList = List<ProductCartDB>.empty().obs;
  var totalQuantity = 0.obs;
  var totalPrice = 0.0.obs;

  void addToCartDB(String id, String title, String content, String image, String thumbnail, String userId, int quantity) async {
    print('cart');
    print(id + '/' + userId + quantity.toString());

    final existingProductIndex = cartDBList.indexWhere((p) => p.id == id);

    if (existingProductIndex == -1) {
      final newProduct = ProductCartDB(
        id: id,
        title: title,
        content: content,
        image: image,
        thumbnail: thumbnail,
        userId: userId,
        quantity: 1,
      );

      cartDBList.add(newProduct);

      totalQuantity.value += 1;
      totalPrice.value += double.parse(userId);

      final existingDatabaseProduct = await DatabaseHelperCart.instance.getProductById(id);
      if (existingDatabaseProduct == null) {
        await DatabaseHelperCart.instance.insert(ProductCartDB(
          id: id,
          title: title,
          content: content,
          image: image,
          thumbnail: thumbnail,
          userId: userId,
          quantity: 1,
        ));
      } else {
        await DatabaseHelperCart.instance.incrementQuantity(id);
      }

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
      final existingProduct = cartDBList[existingProductIndex];
      existingProduct.quantity += 1;
      await DatabaseHelperCart.instance.incrementQuantity(id);
    }

    update();
  }

  void removeFromCartDB(ProductCartDB product) async {
    cartDBList.removeWhere((p) => p.id == product.id);
    totalQuantity.value -= product.quantity;
    try {
      double price = double.parse(product.userId);
      double quantity = double.parse(product.quantity.toString());
      double productTotal = price * quantity;
      totalPrice.value -= productTotal;
    } catch (e) {
      print(e);
    }

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

  void incrementDB(ProductCartDB product) async {
    final existingProductIndex = cartDBList.indexWhere((p) => p.id == product.id);
    if (existingProductIndex != -1) {
      final existingProduct = cartDBList[existingProductIndex];
      if (existingProduct.quantity < 5) {
        existingProduct.quantity++;
        totalQuantity.value++;
        totalPrice.value += double.parse(existingProduct.userId);
        await DatabaseHelperCart.instance.incrementQuantity(product.id);
        update();
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

  void decrementDB(ProductCartDB product) async{
    final existingProductIndex = cartDBList.indexWhere((p) => p.id == product.id);
    if (existingProductIndex != -1) {
      final existingProduct = cartDBList[existingProductIndex];
      if (existingProduct.quantity > 1) {
        existingProduct.quantity--;
        totalQuantity.value--;
        totalPrice.value -= double.parse(existingProduct.userId);

        await DatabaseHelperCart.instance.decrementQuantity(product.id);// Update the UI
        update();
      }
    }
  }

  Future<void> fetchDataFromDatabase() async {
    List<Map<String, dynamic>> data = await DatabaseHelperCart.instance.queryAllRows();
    cartDBList.clear();

    totalQuantity.value = 0;

    for (var item in data) {
      ProductCartDB product = ProductCartDB.fromJson(item);
      cartDBList.add(product);
      totalQuantity.value += product.quantity;
      totalPrice.value += double.parse(product.userId) * product.quantity;

    }
    update();
  }



}