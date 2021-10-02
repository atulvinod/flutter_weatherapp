import 'package:flutter/material.dart';
import 'package:weatherapp/models/enums.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/shared/widgets/shared/weather_image.dart';
import 'package:weatherapp/utls/date_time.dart';

class WeatherPillWidget extends StatelessWidget {
  final int index;
  final WeatherModel weather;
  const WeatherPillWidget(
    this.index,
    this.weather, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
              margin: EdgeInsets.only(left: index == 0 ? 0 : 20),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                color: Theme.of(context).cardColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  WeatherImageWidget(
                    imageHeight: 50,
                    iconCode: weather.iconCode,
                  ),
                  Text(
                    weather.temperature!.toStringAsFixed(0),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontSize: 25),
                  )
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text(
                '${index == 0 ? 'Now' : DateTimeUtils.convertUnixToHr(weather.currentTime!)}',
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.subtitle1)
          ],
        ),
    );
    
  }
}
