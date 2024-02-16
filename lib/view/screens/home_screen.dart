import 'package:ecom/controller/product_controller.dart';
import 'package:ecom/util/constants.dart';

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

  final ProductController _productController = Get.find();

  @override
  void initState() {
    super.initState();
    _productController.getDataFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
             Get.to(()=>CartDisplayPage());
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
             DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: ListTile(
                title: Text(Constants.appName,style: TextStyle(
                  fontWeight: FontWeight.bold,color: Colors.white
                ),),
                subtitle: Column(
                  children: [
                    Text('Developed By: mahbub06ru@gmail.com',style: TextStyle(
                        fontWeight: FontWeight.normal,color: Colors.white
                    ),),
                 /* Obx(() => Text(_productController.productListDB.length.toString(),style: TextStyle(
                      fontWeight: FontWeight.normal,color: Colors.white
                  ),),)*/
                  ],
                ),),

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
      body: FutureBuilder(
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
                if (index >= 0 && index < _productController.productListDB.length) {
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

    );

  }
}


