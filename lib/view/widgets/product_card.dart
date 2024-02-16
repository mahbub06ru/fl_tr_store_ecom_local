import 'package:ecom/controller/cart_controller.dart';
import 'package:ecom/view/screens/product_details_screen.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/product_controller.dart';

class ProductCard extends StatelessWidget {
  final String id;
  final String title;
  final String content;
  final String userId;
  final String image;
  final String thumbnail;

  ProductCard({
    required this.id,
    required this.title,
    required this.content,
    required this.userId,
    required this.image,
    required this.thumbnail,
  });

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());
    final CartController cartController = Get.put(CartController());
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Image.network(image,
              height: 150, width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product Name: $title',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                ExpandableText(
                  'Description: $content',
                  expandText: 'show more',
                  collapseText: 'show less',
                  maxLines: 2,
                  linkColor: Colors.blue,
                ),
                Text(
                  'Price: $userId',
                  style: const TextStyle(fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.network(thumbnail,
                        height: 50, width: 50, fit: BoxFit.cover),
                    InkWell(
                        onTap: () {
                          cartController.addToCart(id,title,content,image,thumbnail,userId,1);
                          print('Add to Cart');
                        },
                        child: const Icon(Icons.add_shopping_cart_outlined)),
                    ElevatedButton(
                        onPressed: () {
                          productController.getProductDetail(id);
                          Get.to(() => ProductDetailsPage(
                              productId: id.toString()));
                        },
                        child: const Text('Details'))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
