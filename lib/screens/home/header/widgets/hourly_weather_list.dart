import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weatherapp/shared/cubit/weather/weather_cubit.dart';
import 'package:weatherapp/shared/widgets/weather_pill.dart';

class HourlyWeatherList extends StatelessWidget {
  const HourlyWeatherList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoaded) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (contxt, index) =>
                WeatherPillWidget(index, state.hourlyForcast[index]),
            itemCount: state.hourlyForcast.length,
          );
        }
        return _loadingShimmer(context);
      },
    );
  }

  _loadingShimmer(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Shimmer.fromColors(
              baseColor: Theme.of(context).primaryColorLight,
              highlightColor: Theme.of(context).primaryColorDark,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Theme.of(context).cardColor,
                ),
              ),
            ),
          ),
          SizedBox(width: 10,),
          Flexible(
            flex: 1,
            child: Shimmer.fromColors(
              baseColor: Theme.of(context).primaryColorLight,
              highlightColor: Theme.of(context).primaryColorDark,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Theme.of(context).cardColor,
                ),
              ),
            ),
          ),
           SizedBox(width: 10,),
          Flexible(
            flex: 1,
            child: Shimmer.fromColors(
              baseColor: Theme.of(context).primaryColorLight,
              highlightColor: Theme.of(context).primaryColorDark,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Theme.of(context).cardColor,
                ),
              ),
            ),
          ),
           SizedBox(width: 10,),
          Flexible(
            flex: 1,
            child: Shimmer.fromColors(
              baseColor: Theme.of(context).primaryColorLight,
              highlightColor: Theme.of(context).primaryColorDark,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Theme.of(context).cardColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
