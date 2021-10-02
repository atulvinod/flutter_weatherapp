import 'package:flutter/material.dart';
import 'package:weatherapp/shared/widgets/shared/gradient_scaffold.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = '/settings';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientScaffoldBody(
        Container(
          child: Text('Settings'),
        ),
      ),
    );
  }
}
