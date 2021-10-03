import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/models/enums.dart';
import 'package:weatherapp/models/settings_model.dart';
import 'package:weatherapp/screens/settings/cubit/settings_cubit.dart';
import 'package:weatherapp/shared/widgets/shared/gradient_scaffold.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = '/settings';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsFormBloc(BlocProvider.of<SettingsCubit>(context)),
      child: Builder(builder: (context) {
        var formBloc = context.read<SettingsFormBloc>();
        return Scaffold(
          body: FormBlocListener<SettingsFormBloc, String, String>(
            onSuccess: (context, state) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Settings Updated Successfully')));
            },
            child: GradientScaffoldBody(Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Theme.of(context).cardColor,
                ),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    _formRow(
                      context,
                      Row(
                        children: [
                          Text(
                            'Units',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Spacer(),
                          Flexible(
                            child: DropdownFieldBlocBuilder(
                                showEmptyItem: false,
                                selectFieldBloc: formBloc.units,
                                itemBuilder: (context, value) =>
                                    UnitsMapping[(value as Units).index]!),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))),
          ),
        );
      }),
    );
  }

  _formRow(BuildContext context, Widget child) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Theme.of(context).primaryColorDark,
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: child,
    );
  }
}

class SettingsFormBloc extends FormBloc<String, String> {
  final units = SelectFieldBloc<Units, Units>();
  final SettingsCubit settings;
  late SettingsModel settingsModel;
  SettingsFormBloc(this.settings) {
    settingsModel = (settings.state as SettingsLoaded).settings;
    units
      ..updateItems(Units.values.toList())
      ..updateInitialValue(settingsModel.unit);
    units.onValueChanges(onData: (prevState, currState) async* {
      if (prevState.value == null) return;
      submit();
    });
    addFieldBlocs(fieldBlocs: [units]);
  }

  @override
  void onSubmitting() {
    var unitsValue = units.value;
    settingsModel = settingsModel.copyWith(unit: unitsValue);
    settings.setUserSettings(settingsModel);
    emitSuccess(successResponse: 'Settings Updated');
  }
}
