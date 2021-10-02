
import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/screens/choose_location/widgets/choose_location.dart';
import 'package:weatherapp/services/weather_service.dart';
import 'package:weatherapp/widgets/shared/weather_image.dart';

class HeaderHeroWidget extends StatelessWidget {

  final weatherService = WeatherService();

  HeaderHeroWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      height: 210,
      width: double.infinity,
      margin: const EdgeInsets.all(22),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Theme.of(context).cardColor,
      ),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('-',
                      style: Theme.of(context).textTheme.headline6),
                  Container(
                    padding: EdgeInsets.all(0.1),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorDark,
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(ChooseLocationScreen.routeName);
                      },
                      icon: Icon(Icons.gps_fixed),
                    ),
                  ),
                ],
              ),
              FittedBox(
                child: Row(
                  children: [
                    WeatherImageWidget(
                      iconCode: "01d",
                      imageHeight: 80,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text('Delhi'+'\u00B0'+'C',
                          style: Theme.of(context).textTheme.headline1),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    'Feels like 96| ',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text('Sunset at 8:25 pm',
                      style: Theme.of(context).textTheme.subtitle1)
                ],
              ),
            ],
          ),
        
    );
  }
}
