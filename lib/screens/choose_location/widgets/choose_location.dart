import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weatherapp/screens/choose_location/cubit/choose_location_cubit.dart';
import 'package:weatherapp/screens/settings/cubit/settings_cubit.dart';
import 'package:weatherapp/shared/widgets/locations_list_item.dart';
import 'package:weatherapp/shared/widgets/shared/gradient_scaffold.dart';

class ChooseLocationScreen extends StatefulWidget {
  static const routeName = '/choose-name';

  const ChooseLocationScreen({Key? key}) : super(key: key);

  @override
  State<ChooseLocationScreen> createState() => _ChooseLocationScreenState();
}

class _ChooseLocationScreenState extends State<ChooseLocationScreen>
    with TickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();

  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocProvider(
        create: (context) => ChooseLocationCubit(),
        child: GradientScaffoldBody(
          Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.all(20),
                child: BlocBuilder<ChooseLocationCubit, ChooseLocationState>(
                  builder: (context, state) {
                    return Form(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 132,
                            child: TextFormField(
                              controller: textController,
                              textInputAction: TextInputAction.search,
                              decoration: const InputDecoration(
                                  hintText: 'Type to search location'),
                              onFieldSubmitted: (value) {
                                BlocProvider.of<ChooseLocationCubit>(context)
                                    .findLocations(value);
                              },
                              onChanged: (value) {
                                if (value.isEmpty) setState(() {});
                              },
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                BlocProvider.of<ChooseLocationCubit>(context)
                                    .findCurrentLocation();
                              },
                              icon: const Icon(Icons.share_location)),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<ChooseLocationCubit, ChooseLocationState>(
                  builder: (context, state) => Expanded(
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 250),
                          child: _buildBody(context, state),
                        ),
                      ))
            ],
          ),
        ),
      ),
    );
  }

  _buildBody(BuildContext context, ChooseLocationState state) {
    if (state is LocationsInitial ||
        state is LocationNotFound ||
        (state is LocationsLoaded && state.locations.isEmpty)) {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: (state is LocationsInitial)
            ? RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.subtitle2,
                  children: [
                    const TextSpan(text: 'Click '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Container(
                        padding: const EdgeInsets.all(0.1),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorDark,
                            borderRadius: BorderRadius.circular(100)),
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.share_location,
                              size: 20,
                            )),
                      ),
                    ),
                    const TextSpan(
                      text: " to detect location",
                    ),
                  ],
                ),
              )
            : (state is LocationPermissionDenied)
                ? Text('Please turn on Locations and grant access',
                    style: Theme.of(context).textTheme.headline5)
                : Text('Location not found!, please try again',
                    style: Theme.of(context).textTheme.headline5),
      );
    } else if (state is LocationsLoaded) {
      return Column(
        children: [
          Expanded(
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Theme.of(context).cardColor,
              ),
              child: ListView.builder(
                itemCount: state.locations.length,
                itemBuilder: (_, index) => LocationListItem(
                  state.locations[index],
                  onClick: () => BlocProvider.of<SettingsCubit>(context)
                      .setUserLocation(state.locations[index].lat!,
                          state.locations[index].lon!)
                      .then((value) => Navigator.of(context).pop()),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              textController.text = '';
              BlocProvider.of<ChooseLocationCubit>(context)
                  .emit(LocationsInitial());
            },
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Theme.of(context).primaryColorLight,
              ),
              child: Text(
                'Clear search',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: Colors.red),
              ),
            ),
          )
        ],
      );
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).primaryColorLight,
        highlightColor: Theme.of(context).primaryColorDark,
        child: const Center(
          child: Text(
            'Loading',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
