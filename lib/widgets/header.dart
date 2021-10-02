import 'package:flutter/material.dart';
import 'package:weatherapp/widgets/header_hero.dart';
import 'package:weatherapp/widgets/weather_pill.dart';

class HeaderWidget extends SliverPersistentHeaderDelegate {
  const HeaderWidget({Key? key});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _getMaxExtent(context, shrinkOffset);
  }

  @override
  double get maxExtent => 400;

  @override
  double get minExtent => 332;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  _getMaxExtent(BuildContext context, double offset) {
    var opacity = ((232 - offset) / 232) < 0 ? 0 : ((232 - offset) / 232);
    return Container(
      height: maxExtent - offset,
      child: Stack(
        children: [
          Positioned(
            height: 150,
            top: 242 - offset,
            left: 0,
            right: 0,
            child: Container(
              height: 150,
              margin: EdgeInsets.symmetric(horizontal: 22, vertical: 5),
              child: Opacity(
                opacity: opacity.toDouble(),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    WeatherPillWidget(),
                    WeatherPillWidget(),
                    WeatherPillWidget(),
                    WeatherPillWidget(),
                    WeatherPillWidget(),
                    WeatherPillWidget(),
                    WeatherPillWidget(),
                    WeatherPillWidget(),
                  ],
                ),
              ),
            ),
          ),
          HeaderHeroWidget(),
        ],
      ),
    );
  }
}
