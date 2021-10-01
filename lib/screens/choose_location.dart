import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:weatherapp/providers/location_provider.dart';
import 'package:weatherapp/widgets/gradient_scaffold.dart';
import 'package:weatherapp/widgets/locations_list_item.dart';

class ChooseLocationScreen extends StatefulWidget {
  static const routeName = '/choose-name';

  ChooseLocationScreen({Key? key}) : super(key: key);

  @override
  State<ChooseLocationScreen> createState() => _ChooseLocationScreenState();
}

class _ChooseLocationScreenState extends State<ChooseLocationScreen> {
  final formKey = GlobalKey<FormState>();

  final textController = TextEditingController();

  final debouncer =
      Debouncer<String>(Duration(milliseconds: 500), initialValue: '');
  LocationProvider? locationProvider;
  @override
  void initState() {
    super.initState();

    locationProvider = Provider.of<LocationProvider>(context, listen: false);
    textController.addListener(() => debouncer.value = textController.text);
    debouncer.values
        .listen((search) => locationProvider?.findLocations(search));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocationProvider>(context, listen: true);
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
                        onFieldSubmitted: (value) {
                          provider.findLocations(value);
                        },
                      )),
                  Container(
                    child: IconButton(
                        onPressed: () {
                          provider.getSelfLocation();
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
                      ? const Center(
                          child: Text('Click on Icon to autodetect location'))
                      : ListView.builder(
                          itemCount: provider.location.length + 1,
                          itemBuilder: (context, index) => index <
                                  provider.location.length
                              ? LocationListItem(provider.location[index])
                              : FittedBox(
                                fit: BoxFit.scaleDown,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                      padding: EdgeInsets.all(0.1),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: IconButton(
                                          onPressed: () {
                                            
                                          },
                                          icon: Icon(Icons.close))),
                                )),
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
