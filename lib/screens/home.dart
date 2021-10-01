import 'package:flutter/material.dart';
import 'package:weatherapp/widgets/forecast_list_item.dart';
import 'package:weatherapp/widgets/header.dart';
import 'package:weatherapp/widgets/weather_pill.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverPersistentHeader(
        delegate: HeaderWidget(),
        pinned: true,
      ),
      SliverList(
          delegate: SliverChildListDelegate([
        Container(
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.symmetric(horizontal: 22, vertical: 5),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            color: Theme.of(context).cardColor,
          ),
          child: Column(
            children: [
              ForecastListItem(),
              ForecastListItem(),
              ForecastListItem(),
              ForecastListItem(),
              ForecastListItem(),
        
            ],
          ),
        )
      ]))
    ]);
  }
}