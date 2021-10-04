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
      'page': const HomeScreen(),
    },
    {'page': const SettingsScreen()}
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
            return GradientScaffoldBody(state is SettingsLoading ? _buildLoadingScreen(context) : _buildMainScreen(_context, _pages[_selectedPageIndex]['page']!));
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPageIndex,
          onTap: _selectPage,
          items: [BottomNavigationBarItem(icon: Icon(Icons.wb_sunny), label: 'Home'), BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')],
        ));
  }

  _buildLoadingScreen(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  _buildMainScreen(BuildContext _context, Widget selectedPage) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherInitial) {
          BlocProvider.of<WeatherCubit>(context).getWeatherData();
        } else if (state is WeatherLoadError) {
          return _errorPage(context);
        }
        return selectedPage;
      },
    );
  }

  Container _errorPage(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        image: const DecorationImage(image: AssetImage('assets/images/RainThunder.png')),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'An unexpected error occured while getting weather',
            maxLines: 10,
            overflow: TextOverflow.fade,
            softWrap: true,
            style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.red),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton.icon(
              onPressed: () {
                BlocProvider.of<WeatherCubit>(context).getWeatherData();
              },
              icon: Icon(Icons.refresh),
              label: Text(
                'Retry',
              ))
        ],
      ),
    );
  }
}
