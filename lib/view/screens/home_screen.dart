import 'dart:convert';

import 'package:ecom/controller/cart_controller.dart';
import 'package:ecom/controller/database_controller.dart';
import 'package:ecom/controller/product_controller.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';


import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import '../../model/product_list.dart';
import '../widgets/product_card.dart';
import '../widgets/product_card_shimmar.dart';
import '../widgets/title_text.dart';
import 'cart_display_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TODO: Add _bannerAd
  // BannerAd? _bannerAd;
 

  final ProductController _productController = Get.put(ProductController());
  final DatabaseController _databaseController = Get.put(DatabaseController());
  final CartController _cartController = Get.put(CartController());

  void printLocalData() {
    _databaseController.productsDB.forEach((product) {
      print('Title: ${product.title}, Content: ${product.content}, UserId: ${product.userId}');
    });
  }
  Future<void> loadProducts() async {
    await _productController.getProducts();
    await _databaseController.getData().then((_) {
      // printLocalData();
    });
    setState(() {});
  }
  @override
  void initState() {
    super.initState();
    loadProducts();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TR Storage'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
             // Get.to(()=>CartDisplayPage(productList: _cartController.cartList));
             Get.to(()=>CartDisplayPage());
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: ListTile(
                title: Text('TR Store'),
                subtitle: Text('Developed By: mahbub06ru@gmail.com'),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('My Cart'),
              onTap: () {
                // Get.to(()=>CartDisplayPage(productList: _cartController.cartList));
                Get.to(()=>CartDisplayPage());
              },
            ),
          ],
        ),
      ),
      //api
      /*   body: Center(
        child: FutureBuilder(
          future: _productController.getProduct(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: ListView.builder(
                  itemCount: 5, // You can adjust the itemCount according to your design
                  itemBuilder: (context, index) {
                    return ProductCardShimmer(); // Use a separate Shimmer widget for each item
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                itemCount: _productController.productList.length,
                itemBuilder: (context, index) {
                  Product product = _productController.productList[index];
                  return ProductCard(
                    title: product.title ?? '',
                    content: product.content ?? '',
                    userId: product.id.toString(),
                    image: product.image ?? '',
                    thumbnail: product.thumbnail ?? ''
                  );
                },
              );
            }
          },
        ),
      ),*/
      //db
      body: Center(
        child: FutureBuilder(
          future: _databaseController.getData(),
          // Fetch data from the local database
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return ProductCardShimmer();
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                itemCount: _databaseController.productsDB.length,
                itemBuilder: (context, index) {
                  ProductDB product = _databaseController.productsDB[index];
                  return ProductCard(
                      id: product.id.toString(),
                      title: product.title ?? '',
                      content: product.content ?? '',
                      userId: product.userId.toString(),
                      image: product.image ?? '',
                      thumbnail: product.thumbnail ?? '');
                },
              );
            }
          },
        ),
      ),
    );
  }
}
