import 'package:ecom/model/product_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';


import '../database/database_helper.dart';

class DatabaseController extends GetxController {
  var productsDB = <ProductDB>[].obs;

  @override
  void onInit() {
    super.onInit();
  }
  Future<void> getData() async {
    List<Map<String, dynamic>> value = await DatabaseHelper.instance.queryAllRows();
    productsDB.clear();
    value.forEach((element) {
      productsDB.add(ProductDB(
        id: element['id'],
        title: element['title'],
        content: element['content'],
        userId: element['userId'],
        image: element['image'],
        thumbnail: element['thumbnail'],
      ));
    });
  }



  void deleteTask(int id) async {
    await DatabaseHelper.instance.delete(id);

    // beatData.removeWhere((element) => element.id == id);
  }

  void clearTable() async {
    try {
      await DatabaseHelper.instance.clearTable();
    } catch (e) {
      print("Error clearing table: $e");
    }
  }

  void addData(
      id,
    title,
    content,
    userId,
    image,
    thumbnail,
  ) async {
    await DatabaseHelper.instance
        .insert(ProductDB(
            id: id,
            title: title,
            content: content,
            userId: userId,
            image: image,
            thumbnail: thumbnail))
        .catchError((onError) {
      // print(onError);
      printError();
    });

   /*  Fluttertoast.showToast(
        msg: 'Product Saved to Local Storage',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white,
        fontSize: 16.0);*/
  }
}
