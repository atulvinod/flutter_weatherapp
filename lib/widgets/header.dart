import 'package:flutter/material.dart';
import 'package:weatherapp/screens/choose_location.dart';
import 'package:weatherapp/widgets/weather_image.dart';
import 'package:weatherapp/widgets/weather_pill.dart';

class HeaderWidget extends SliverPersistentHeaderDelegate {
  const HeaderWidget({Key? key});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    print(shrinkOffset);
    return _getMaxExtent(context, shrinkOffset);
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 400;

  @override
  // TODO: implement minExtent
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
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            height: 210,
            width: double.infinity,
            margin: EdgeInsets.all(22),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Theme.of(context).cardColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Alberquerque',
                        style: Theme.of(context).textTheme.headline6),
                    Container(
                        padding: EdgeInsets.all(0.1),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorDark,
                            borderRadius: BorderRadius.circular(100)),
                        child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(ChooseLocationScreen.routeName);
                            }, icon: Icon(Icons.gps_fixed)))
                  ],
                ),
                Row(
                  children: [
                    WeatherImageWidget(imageHeight: 80,),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text('96',
                          style: Theme.of(context).textTheme.headline1),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Feels like 96 | ',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text('Sunset at 8:25 pm',
                        style: Theme.of(context).textTheme.subtitle1)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
