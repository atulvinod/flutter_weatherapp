import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/providers/location_provider.dart';
import 'package:weatherapp/widgets/gradient_scaffold.dart';
import 'package:weatherapp/widgets/locations_list_item.dart';

class ChooseLocationScreen extends StatelessWidget {
  static const routeName = '/choose-name';
  final formKey = GlobalKey<FormState>();
  final textController = TextEditingController();
  ChooseLocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        shadowColor: Colors.transparent,
      ),
      body: GradientScaffoldBody(Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.all(20),
              child: Form(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width - 132,
                      child: TextFormField(
                        controller: textController,
                        decoration: const InputDecoration(
                            hintText: 'Type to search location'),
                      )),
                  Container(
                    child: IconButton(
                        onPressed: () {
                          locationProvider.findLocations(textController.text);
                        },
                        icon: Icon(Icons.share_location)),
                  )
                ],
              )),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: Container(
                  clipBehavior: Clip.antiAlias,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 5),
              child: Consumer<LocationProvider>(
                builder: (_, provider, ch) => provider.location.length == 0
                    ? Center(
                        child: Text('Click on Icon to autodetect location'))
                    : ListView.builder(
                        itemCount: provider.location.length,
                        itemBuilder: (context, index) =>
                        LocationListItem(provider.location[index])),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                borderRadius: BorderRadius.circular(20),
              ),
            ))
          ],
        ),
      )),
    );
  }
}
