import 'dart:convert';
import 'dart:ffi';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecom/controller/database_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/product_detail.dart';
import '../model/product_list.dart';

class ProductController extends GetxController {
  final DatabaseController _databaseController = Get.put(DatabaseController());
  RxList<Product> productList = <Product>[].obs;
  Rx<ProductDetail?> productDetail = Rx<ProductDetail?>(null);
  var isLoading = false.obs;


  Future<void> getProducts() async {
    Connectivity().checkConnectivity().then((connection) async {
      if (connection == ConnectivityResult.mobile || connection == ConnectivityResult.wifi) {
        isLoading(true);
        final response =
        await http.get(Uri.parse('https://jsonplaceholder.org/posts'));

        if (response.statusCode == 200) {
          final List<Product> products = productListFromJson(response.body);
          productList.assignAll(products);
          isLoading(false);
          print('productList');
          // print(productList.length);
          //for db save

          try {
            _databaseController.productsDB.clear();
            if (_databaseController.productsDB.isEmpty) {
              List<Map<String, dynamic>> jsonResponseList =
              productList.value.map((product) => product.toJson()).toList();
              jsonResponseList.forEach((entry) {
                String id = entry["id"];
                String title = entry["title"];
                String content = entry["content"];
                String userId = entry["userId"];
                String image = entry["image"];
                String thumbnail = entry["thumbnail"];

                var product = Product(
                  id: id,
                  title: title,
                  content: content,
                  userId: userId,
                  image: image,
                  thumbnail: thumbnail,
                );
                // print(product.title);

                _databaseController.addData(
                  product.id,
                  product.title,
                  product.content,
                  product.userId,
                  product.image,
                  product.thumbnail,
                );

              });
            } else {
              // Handle if products list is not empty
            }
          } catch (e) {
            print(e);
          }
        } else {
          isLoading(false);
          print('Failed to load data: ${response.statusCode}');
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Please check your internet connection!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueAccent,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }

    });

  }

  Future<void> getProductDetail(String productId) async {

    Connectivity().checkConnectivity().then((connection) async {
      if (connection == ConnectivityResult.mobile || connection == ConnectivityResult.wifi){
        isLoading(true);
        final response = await http
            .get(Uri.parse('https://jsonplaceholder.org/posts/$productId'));

        if (response.statusCode == 200) {
          final ProductDetail product = productDetailFromJson(response.body);
          productDetail.value = product;
          isLoading(false);
          print('productDetail');
          print(productDetail.value);
        } else {
          isLoading(false);
          print('Failed to load data: ${response.statusCode}');
        }
      }else {
        Fluttertoast.showToast(
          msg: 'Please check your internet connection!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueAccent,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    });

  }


}
