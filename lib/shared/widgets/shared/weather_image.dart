import 'package:flutter/material.dart';
import 'package:weatherapp/models/constants.dart';

class WeatherImageWidget extends StatelessWidget {
  final double imageHeight;
  final String? iconCode;
  const WeatherImageWidget({ Key? key , this.imageHeight = 100, this.iconCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(iconToAssetMapping[iconCode] ?? 'assets/images/Sunny.png',height: imageHeight,),
    );
  }
}