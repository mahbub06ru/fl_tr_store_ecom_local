import 'package:ecom/controller/cart_controller.dart';
import 'package:ecom/controller/product_controller.dart';
import 'package:ecom/model/product_cart.dart';
import 'package:ecom/view/screens/payment_system.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shimmer/shimmer.dart';

import '../../model/product_cart.dart';
import 'cart_display_screen.dart';



class ProductDetailsPage extends StatefulWidget {

  final String productId;

  const ProductDetailsPage({super.key, required this.productId});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final CartController cartController = Get.put(CartController());
  final ProductController _productController = Get.put(ProductController());
 

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:Obx(()=>Text(_productController.productDetail.value!.title!??'')) ,
      ),
      body: Obx(()=> _productController.isLoading.value? Shimmer.fromColors(
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
                    SizedBox(width: 20,),
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
                  Text('Add to Cart'),
                  SizedBox(width: 20,),
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
                      child: Icon(Icons.add_shopping_cart)
                  )
                ],
              ),
              ElevatedButton(onPressed: (){
                // Get.to(()=>CartDisplayPage(productList: cartController.cartList));
                Get.to(()=>CartDisplayPage());

              }, child: const Text('Go to Cart'))
            ],
          )
        ],

      )),

    );
  }
}
