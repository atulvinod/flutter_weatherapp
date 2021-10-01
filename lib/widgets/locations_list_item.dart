import 'package:flutter/material.dart';
import 'package:weatherapp/models/location_model.dart';

class LocationListItem extends StatelessWidget {
  final LocationModel location;
  const LocationListItem(this.location, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: (){},
        child: Container(
          alignment: AlignmentDirectional.centerStart,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: const Border(
              bottom: BorderSide(
                width: 0.2,
                color: Colors.grey,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    location.name!,
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.white),
                  ),
                  PopupMenuButton(
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (_) => [
                      const PopupMenuItem(
                        child: Text('Set as current location'),
                        value: 'current',
                      ),
                      const PopupMenuItem(
                        child: Text('Add to locations'),
                        value: 'add',
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text('Country : ${location.country} | '),
                  Text('State : ${location.state ?? '-'}')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
