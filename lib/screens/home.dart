import 'package:flutter/material.dart';
import 'package:weatherapp/screens/home/weekly_forecast/weekly_forecast.dart';
import 'package:weatherapp/shared/widgets/header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      const SliverPersistentHeader(
        delegate: HeaderWidget(),
        pinned: true,
      ),
      SliverList(
          delegate: SliverChildListDelegate([
        Container(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 5),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            color: Theme.of(context).cardColor,
          ),
          child: const WeeklyForecast(),
        )
      ]))
    ]);
  }
}
