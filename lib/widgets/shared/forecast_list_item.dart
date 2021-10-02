
import 'package:flutter/material.dart';

class ForecastListItem extends StatelessWidget {
  const ForecastListItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
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
          Text(
            'Today',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Container(
            child: Row(
              children: [
                Image.asset(
                  'assets/images/Sunny.png',
                  height: 40,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    'L 65',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    'H 65',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
