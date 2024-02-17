import 'package:ecom/controller/cart_controller.dart';
import 'package:ecom/controller/product_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shimmer/shimmer.dart';

import '../../controller/cart_db_controller.dart';
import '../../model/product_cart.dart';
import '../../util/constants.dart';
import 'cart_db_display_screen.dart';
import 'cart_display_screen.dart';
import 'package:badges/badges.dart' as badges;


class ProductDetailsPage extends StatefulWidget {

  final String productId;
  final String title;
  final String content;
  final String image;
  final String thumbnail;
  final String userId;

  const ProductDetailsPage({super.key, required this.productId, required this.title, required this.content, required this.image,  required this.thumbnail,required this.userId});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final CartController cartController = Get.find();
  final ProductController _productController = Get.find();
  final CartDBController _cartDBController = Get.find();
 

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final productDetail = _productController.productDetail.value;
          return Text(productDetail?.title ?? 'Product Detail',maxLines:2, style: TextStyle(
            fontSize: 14,
          ),);
        }),
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
                Obx(() => Text(cartController.cartList.length.toString(),style: const TextStyle(color: Colors.white),)),
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
      //api
  /*    body: Obx(()=> _productController.isLoading.value? Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.white, // Use a background color for the shimmer effect
                    ),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 16,
                        color: Colors.white, // Use a background color for the shimmer effect
                      ),
                    ),
                    const SizedBox(height: 16,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 18,
                        color: Colors.white, // Use a background color for the shimmer effect
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Container(
                      width: 80,
                      height: 30,
                      color: Colors.white, // Use a background color for the shimmer effect
                    ),
                    const SizedBox(width: 20,),
                    Container(
                      width: 30,
                      height: 30,
                      color: Colors.white, // Use a background color for the shimmer effect
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {

                  },
                  child: const Text('Go to Cart'),
                ),
              ],
            ),
          ],
        ),
      ): Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: SingleChildScrollView(
            child: Column(
              children: [
                Image.network(_productController.productDetail.value!.image!,width: double.infinity,height: 200,fit: BoxFit.cover,),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_productController.productDetail.value!.content!,style: const TextStyle(
                      fontSize: 14
                  ),),
                ),
                const SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Price: '+_productController.productDetail.value!.userId.toString(),style: const TextStyle(
                      fontSize: 18
                  ),),
                ),
              ],
            ),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  const Text(Constants.addToCart),
                  const SizedBox(width: 20,),
                  InkWell(
                      onTap: (){
                        cartController.addToCart(
                            _productController.productDetail.value!.id.toString(),
                            _productController.productDetail.value!.title.toString(),
                            _productController.productDetail.value!.content.toString(),
                            _productController.productDetail.value!.image.toString(),
                            _productController.productDetail.value!.thumbnail.toString(),
                            _productController.productDetail.value!.userId.toString(),1
                        );
                      },
                      child: const Icon(Icons.add_shopping_cart)
                  )
                ],
              ),
              ElevatedButton(onPressed: (){
                // Get.to(()=>CartDisplayPage(productList: cartController.cartList));
                Get.to(()=>const CartDisplayPage());

              }, child: const Text('Go to Cart'))
            ],
          )
        ],

      )),*/
      body: widget.productId == null? Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.white, // Use a background color for the shimmer effect
                    ),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 16,
                        color: Colors.white, // Use a background color for the shimmer effect
                      ),
                    ),
                    const SizedBox(height: 16,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 18,
                        color: Colors.white, // Use a background color for the shimmer effect
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Container(
                      width: 80,
                      height: 30,
                      color: Colors.white, // Use a background color for the shimmer effect
                    ),
                    const SizedBox(width: 20,),
                    Container(
                      width: 30,
                      height: 30,
                      color: Colors.white, // Use a background color for the shimmer effect
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {

                  },
                  child: const Text('Go to Cart'),
                ),
              ],
            ),
          ],
        ),
      ): Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: SingleChildScrollView(
            child: Column(
              children: [
                Image.network(widget.image,width: double.infinity,height: 200,fit: BoxFit.cover,),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.content,style: const TextStyle(
                      fontSize: 14
                  ),),
                ),
                const SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Price: '+widget.userId.toString(),style: const TextStyle(
                      fontSize: 18
                  ),),
                ),
              ],
            ),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  const Text(Constants.addToCart),
                  const SizedBox(width: 20,),
                  InkWell(
                      onTap: (){
                        cartController.addToCart(
                            widget.productId.toString(),
                            widget.title.toString(),
                            widget.content.toString(),
                            widget.image.toString(),
                            widget.thumbnail.toString(),
                            widget.userId.toString(),1
                        );
                      },
                      child: const Icon(Icons.add_shopping_cart)
                  )
                ],
              ),

            ],
          )
        ],

      ),

    );
  }
}
