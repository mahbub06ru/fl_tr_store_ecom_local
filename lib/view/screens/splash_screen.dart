import 'dart:async';
import 'package:ecom/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

 

  @override
  void initState() {

    Timer(
        const Duration(seconds: 3),
            () {
              Get.to(()=>const HomePage());
            });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('TR Storage',style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold
            ),),
            const SizedBox(height: 50,),
            Image.asset('assets/images/logo.jpg',width: 150,),
          ],
        ),
      ),

    );
  }
}
