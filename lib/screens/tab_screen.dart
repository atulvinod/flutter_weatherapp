import 'package:flutter/material.dart';
import 'package:weatherapp/screens/home.dart';
import 'package:weatherapp/screens/settings.dart';
import 'package:weatherapp/widgets/shared/gradient_scaffold.dart';

class TabsScreen extends StatefulWidget {
  static const String routeName = '/tabs-screen';
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Widget>> _pages = [
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
  Widget build(BuildContext context) {
    return Scaffold(
        body: GradientScaffoldBody(_pages[_selectedPageIndex]['page']!),
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
}
