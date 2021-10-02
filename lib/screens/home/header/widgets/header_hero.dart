import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/screens/choose_location/widgets/choose_location.dart';
import 'package:weatherapp/services/weather_service.dart';
import 'package:weatherapp/shared/cubit/cubit/weather_cubit.dart';
import 'package:weatherapp/shared/widgets/shared/weather_image.dart';
import 'package:weatherapp/utls/date_time.dart';

class HeaderHeroWidget extends StatelessWidget {
  final weatherService = WeatherService();

  HeaderHeroWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        height: 210,
        width: double.infinity,
        margin: const EdgeInsets.all(22),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Theme.of(context).cardColor,
        ),
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state){
            if (state is WeatherLoaded) {
              return 
              _getMainBody(context, state.currentWeather);
            }
            return _getLoadingShimmer(context);
          },
        ),
      );
  
  }

  _getLoadingShimmer(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Theme.of(context).primaryColorLight,
        highlightColor: Theme.of(context).primaryColorDark,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                ),
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
                    icon: const Icon(Icons.gps_fixed),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const WeatherImageWidget(
                  iconCode: "01d",
                  imageHeight: 80,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Theme.of(context).cardColor,
                    ),
                    margin: const EdgeInsets.only(left: 10),
                    height: 25,
                  ),
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Theme.of(context).cardColor,
              ),
              margin: const EdgeInsets.only(left: 10),
              height: 10,
              width: 150,
            ),
          ],
        ));
  }

  Column _getMainBody(BuildContext context, WeatherModel weather) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FittedBox(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(weather.location?.name ?? '-', style: Theme.of(context).textTheme.headline6),
              Container(
                margin: EdgeInsets.only(left: 10),
                padding: const EdgeInsets.all(0.1),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.circular(100)),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(ChooseLocationScreen.routeName);
                  },
                  icon: const Icon(Icons.gps_fixed),
                ),
              ),
            ],
          ),
        ),
        FittedBox(
          child: Row(
            children: [
              WeatherImageWidget(
                iconCode: weather.iconCode,
                imageHeight: 80,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text((weather.temperature?.toStringAsFixed(2) ?? '-')  + '\u00B0' + 'C',
                    style: Theme.of(context).textTheme.headline1),
              )
            ],
          ),
        ),
        FittedBox(
          child: Row(
            children: [
              Text(
                'Feels like ${weather.feelsLike?.toStringAsFixed(2) ?? '0' } | ',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text('Sunset at ${DateTimeUtils.convertUnixToLocal(weather.sunset!)}',
                  style: Theme.of(context).textTheme.subtitle1)
            ],
          ),
        ),
      ],
    );
  }
}
