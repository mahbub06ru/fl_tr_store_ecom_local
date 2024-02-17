import 'package:ecom/controller/cart_db_controller.dart';
import 'package:ecom/controller/product_controller.dart';
import 'package:ecom/controller/cart_controller.dart';
import 'package:ecom/database/database_helper_cart.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/product_cart.dart';
import '../../model/product_list.dart';

class CartDBDisplayPage extends StatefulWidget {
  const CartDBDisplayPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CartDBDisplayPage> createState() => _CartDBDisplayPageState();
}

class _CartDBDisplayPageState extends State<CartDBDisplayPage> {
  final CartDBController cartDBController = Get.find();

  @override
  void initState() {
    super.initState();
   /* cartDBController.fetchDataFromDatabase().then((value) {
      print('cartListInit');
      print(cartDBController.cartDBList.length);
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        actions: [
        /*  InkWell(
            onTap: () {
              DatabaseHelperCart.instance.clearTable();
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 15),
              child: Icon(
                Icons.delete,
                color: Colors.black,
              ),
            ),
          ),*/

        ],
      ),
      body: Obx(
            () => cartDBController.cartDBList.isEmpty
            ? const Center(
          child: Text("Your Cart is Empty"),
        )
            : Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },
                    itemCount: cartDBController.cartDBList.length,
                    itemBuilder: (context, index) {
                      if (index < cartDBController.cartDBList.length) {
                        final item = cartDBController.cartDBList[index];
                        var singleProductPrice;
                        print('cal');
                        try {
                          double price = double.parse(item.userId.toString());
                          double quan = double.parse(item.quantity.toString());
                          double tk = price * quan;
                          print(item.userId);
                          print(item.quantity);
                          print(tk);
                          singleProductPrice = tk.toStringAsFixed(2); // Convert double to string with fixed decimal places
                        } catch (e) {
                          print(e);
                        }
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black12)),
                                      child: Image.network(
                                        item.image!,
                                        height: 65,
                                        width: 65,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 150,
                                            child: Text(
                                              item.title!,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight.w600),
                                            ),
                                          ),
                                          const SizedBox(width: 40),
                                          IconButton(
                                              onPressed: () {
                                                cartDBController.removeFromCartDB(item);
                                              },
                                              icon: const Icon(
                                                  Icons.delete))
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Text(
                                            "\TK ${singleProductPrice}",
                                            style: const TextStyle(
                                              color: Colors.brown,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),

                                          const SizedBox(width: 48),
                                          IconButton(
                                              onPressed: () {
                                                cartDBController.incrementDB(item);
                                              },
                                              icon: const Icon(
                                                  Icons.add)),
                                          Container(
                                            padding:
                                            const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(2),
                                                color: const Color
                                                    .fromARGB(255, 219,
                                                    227, 228)),
                                            child: Text(
                                              item.quantity.toString(),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight.w600),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                cartDBController.decrementDB(item);
                                              },
                                              icon: const Icon(
                                                  Icons.remove))
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox();
                    }),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                    color: Colors.black12.withOpacity(.1),
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total items (${cartDBController.totalQuantity.value})",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "Total Prices: ${cartDBController.totalPrice.value}",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
