import '../controller/database_controller.dart';
import '../controller/product_controller.dart';
import 'package:get/get.dart';

import '../controller/cart_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CartController());
    Get.put(DatabaseController());
    Get.put(ProductController());

  }
}