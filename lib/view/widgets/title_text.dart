import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String title;
  const TitleText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child:   Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(title,style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold
        ),),
      ),
    );
  }
}

