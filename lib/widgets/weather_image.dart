import 'package:flutter/material.dart';

class WeatherImageWidget extends StatelessWidget {
  final double imageHeight;
  const WeatherImageWidget({ Key? key , this.imageHeight = 100}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset('assets/images/Sunny.png',height: imageHeight,),
    );
  }
}