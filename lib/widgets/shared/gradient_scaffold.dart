import 'package:flutter/material.dart';

class GradientScaffoldBody extends StatelessWidget {
  final Widget child;
  const GradientScaffoldBody(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Theme.of(context).primaryColorDark,
          Theme.of(context).primaryColorLight,
        ],
      ),),
      child: SafeArea(child: child),
    );
  }
}
