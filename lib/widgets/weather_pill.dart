
import 'package:flutter/material.dart';
import 'package:weatherapp/widgets/weather_image.dart';

class WeatherPillWidget extends StatelessWidget {
  const WeatherPillWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              color: Theme.of(context).cardColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WeatherImageWidget(imageHeight: 50,),
                Text('96',style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 25),)
              ],
            ),
          ),
          SizedBox(height:5),
          Text('Now',style: Theme.of(context).textTheme.subtitle1)
        ],
      ),
    );
  }
}
