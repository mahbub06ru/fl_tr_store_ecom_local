import 'dart:io';

import 'package:ecom/controller/cart_controller.dart';
import 'package:ecom/controller/product_controller.dart';
import 'package:ecom/util/constants.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import '../../controller/cart_db_controller.dart';
import '../../database/database_helper.dart';
import '../../model/product_list.dart';
import '../widgets/product_card.dart';
import '../widgets/product_card_shimmar.dart';
import '../widgets/title_text.dart';
import 'cart_db_display_screen.dart';
import 'cart_display_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductController _productController = Get.find();
  final CartController _cartController = Get.find();
  final CartDBController _cartDBController = Get.find();

  Future<bool> showExitPopup(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Do you want to exit?"),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            DatabaseHelper.instance.clearTable();
                            exit(0);
                          },
                          child: const Text("Yes"),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          //  print('no selected');
                          Navigator.of(context).pop();
                        },
                        child: const Text("No",
                            style: TextStyle(color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();

    /*_productController.getDataFromDatabase().then((value) {
      print('productListDBInit');
      print(_productController.productListDB.length);
    });*/
    _cartDBController.fetchDataFromDatabase().then((value) {
      print('cartListInit');
      print(_cartDBController.cartDBList.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.appName),
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => const CartDBDisplayPage());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 15),
              child: badges.Badge(
                badgeContent:
                Obx(() => Text(_cartDBController.cartDBList.length.toString(),style: const TextStyle(color: Colors.white),)),
                child: const Column(
                  children: [
                    Icon(
                      Icons.storage_sharp,
                      color: Colors.black,
                    ),
                    // Text('Storage')
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(() => const CartDisplayPage());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 15),
              child: badges.Badge(
                badgeContent:
                Obx(() => Text(_cartController.cartList.length.toString(),style: const TextStyle(color: Colors.white),)),
                child: const Column(
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                    ),
                    // Text('Storage')
                  ],
                ),
              ),
            ),
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
              child: Center(
                child: ListTile(
                  title: Text(
                    Constants.appName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  subtitle: Text(
                    'Developed By: mahbub06ru@gmail.com',
                    style: TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.white),
                  ),
                ),
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
                Get.to(() => const CartDisplayPage());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('My Local Cart'),
              onTap: () {
                Get.to(() => const CartDBDisplayPage());
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
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) {
            return;
          }
          showExitPopup(context);
        },
        child: FutureBuilder(
          future: _productController.getDataFromDatabase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return ProductCardShimmer();
                    },
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return ListView.builder(
                itemCount: _productController.productListDB.length,
                itemBuilder: (context, index) {
                  if (index >= 0 &&
                      index < _productController.productListDB.length) {
                    ProductDB product = _productController.productListDB[index];
                    return ProductCard(
                      id: product.id.toString(),
                      title: product.title ?? '',
                      content: product.content ?? '',
                      userId: product.userId.toString(),
                      image: product.image ?? '',
                      thumbnail: product.thumbnail ?? '',
                    );
                  } else {
                    return Container();
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
