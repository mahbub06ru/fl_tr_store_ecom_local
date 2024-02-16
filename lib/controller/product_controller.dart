import 'dart:convert';
import 'dart:ffi';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../database/database_helper.dart';
import '../model/product_detail.dart';
import '../model/product_list.dart';

class ProductController extends GetxController {
  RxList<Product> productListAPI = <Product>[].obs;
  RxList<ProductDB> productListDB = <ProductDB>[].obs;
  Rx<ProductDetail?> productDetail = Rx<ProductDetail?>(null);
  var isLoading = false.obs;


  Future<void> getProductsFromAPI() async {
    Connectivity().checkConnectivity().then((connection) async {
      if (connection == ConnectivityResult.mobile || connection == ConnectivityResult.wifi) {
        isLoading(true);
        final response =
        await http.get(Uri.parse('https://jsonplaceholder.org/posts'));

        if (response.statusCode == 200) {
          final List<Product> products = productListFromJson(response.body);
          productListAPI.assignAll(products);
          isLoading(false);
          print('productList');

          try {
            productListDB.value.clear();

            if (productListDB.value.isEmpty) {
              List<Map<String, dynamic>> jsonResponseList = productListAPI.value.map((product) => product.toJson()).toList();

              jsonResponseList.forEach((entry) {
                String id = entry["id"];
                String title = entry["title"];
                String content = entry["content"];
                String userId = entry["userId"];
                String image = entry["image"];
                String thumbnail = entry["thumbnail"];

                bool isProductExists = productListDB.value.any((existingProduct) => existingProduct.id == id);

                if (!isProductExists) {
                  var product = ProductDB(
                    id: id,
                    title: title,
                    content: content,
                    userId: userId,
                    image: image,
                    thumbnail: thumbnail,
                  );

                  productListDB.value.add(product);
                  DatabaseHelper.instance.insert(product); // Insert into database
                }
              });
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

  Future<void> getDataFromDatabase() async {
    productListDB.value.clear();
    List<Map<String, dynamic>> value = await DatabaseHelper.instance.queryAllRows();
    value.forEach((element) {
      productListDB.value.add(ProductDB(
        id: element['id'],
        title: element['title'],
        content: element['content'],
        userId: element['userId'],
        image: element['image'],
        thumbnail: element['thumbnail'],
      ));
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
