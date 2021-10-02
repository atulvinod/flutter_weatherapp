import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weatherapp/shared/cubit/weather/weather_cubit.dart';
import 'package:weatherapp/shared/widgets/shared/forecast_list_item.dart';

class WeeklyForecast extends StatelessWidget {
  const WeeklyForecast({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoaded) {
          return Container(
            child: Column(
              children: [
                ForecastListItem(0,state.weeklyForecast[0]),
                ForecastListItem(1,state.weeklyForecast[1]),
                ForecastListItem(2,state.weeklyForecast[2]),
                ForecastListItem(3,state.weeklyForecast[3]),
                ForecastListItem(4,state.weeklyForecast[4]),
              ],
            ),
          );
        }
        return _loadingShimmer(context);
      },
    );
  }

  _loadingShimmer(BuildContext context) {
    return Container(child: Shimmer.fromColors(
        baseColor: Theme.of(context).primaryColorLight,
        highlightColor: Theme.of(context).primaryColorDark,
        child: Container(
          height: 300,
          decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Theme.of(context).cardColor,
        ),
        )
    ));
  }
}
