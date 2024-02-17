import 'package:ecom/view/screens/cart_display_screen.dart';
import 'package:ecom/view/screens/home_screen.dart';
import 'package:ecom/view/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'util/app_binding.dart';
import 'view/screens/cart_db_display_screen.dart';
import 'view/screens/product_details_screen.dart';

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TR Storage',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/SplashScreen',
      initialBinding: AppBinding(),
      getPages: AppPages.getKey,
    );
  }
}

class AppPages {
  static final getKey = [
    GetPage(
      name: '/SplashScreen',
      page: () => const SplashScreen(),
    ),

    GetPage(
      name: '/HomePage',
      page: () => const HomePage(),
    ),

    GetPage(
      name: '/ProductDetailsPage',
      page: () => const ProductDetailsPage(productId: '')

    ),
    GetPage(
        name: '/CartDisplayPage',
        page: () => const CartDisplayPage()

    ),
    GetPage(
        name: '/CartDBDisplayPage',
        page: () => const CartDBDisplayPage()

    )

  ];
}
