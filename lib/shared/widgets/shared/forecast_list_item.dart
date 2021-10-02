import 'package:flutter/material.dart';
import 'package:weatherapp/models/enums.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/shared/widgets/shared/weather_image.dart';
import 'package:weatherapp/utls/date_time.dart';

class ForecastListItem extends StatelessWidget {
  final int index;
  final WeatherModel weather;
  const ForecastListItem(
    this.index,
    this.weather, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.2,
            color: Colors.grey,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                index == 0
                    ? 'Today'
                    : index == 1
                        ? 'Tomorrow'
                        : DateTimeUtils.convertUnixToWeekDay(
                            weather.currentTime!),
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: WeatherImageWidget(
              iconCode: weather.iconCode,
              imageHeight: 40,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'L ${weather.tempMin!.truncate().toString()+UnitSign[weather.units!.index]!}',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'H ${weather.tempMax!.truncate().toString()+UnitSign[weather.units!.index]!}',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
