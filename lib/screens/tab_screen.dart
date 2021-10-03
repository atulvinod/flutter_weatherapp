import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/screens/home.dart';
import 'package:weatherapp/screens/settings/cubit/settings_cubit.dart';
import 'package:weatherapp/screens/settings/widgets/settings.dart';
import 'package:weatherapp/shared/cubit/weather/weather_cubit.dart';
import 'package:weatherapp/shared/widgets/shared/gradient_scaffold.dart';

class TabsScreen extends StatefulWidget {
  static const String routeName = '/tabs-screen';
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Widget>> _pages = [
    {
      'page': HomeScreen(),
    },
    {'page': SettingsScreen()}
  ];
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext _context) {
    return Scaffold(
        body: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return GradientScaffoldBody(state is SettingsLoading
                ? _buildLoadingScreen(context)
                : _buildMainScreen(
                    _context, _pages[_selectedPageIndex]['page']!));
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPageIndex,
          onTap: _selectPage,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.wb_sunny), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings')
          ],
        ));
  }

  _buildLoadingScreen(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  _buildMainScreen(BuildContext context, Widget selectedPage) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherInitial) {
          BlocProvider.of<WeatherCubit>(context).getWeatherData();
        }
        return selectedPage;
      },
    );
  }
}
