import 'package:flutter/material.dart';
import 'package:weatherapp/shared/widgets/header.dart';
import 'package:weatherapp/shared/widgets/shared/forecast_list_item.dart';

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