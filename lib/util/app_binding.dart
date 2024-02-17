import '../controller/cart_db_controller.dart';
import '../controller/product_controller.dart';
import 'package:get/get.dart';

import '../controller/cart_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CartController());
    Get.put(CartDBController());
    Get.put(ProductController());

  }
}
