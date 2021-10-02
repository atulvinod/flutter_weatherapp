import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/screens/choose_location/widgets/choose_location.dart';
import 'package:weatherapp/screens/settings/cubit/settings_cubit.dart';
import 'package:weatherapp/screens/settings/widgets/settings.dart';
import 'package:weatherapp/screens/tab_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String APIKEY = 'cdafe644081dad824933fbac2b6dc013';

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => SettingsCubit())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.light,
          fontFamily: 'WorkSans',
          primarySwatch: Colors.grey,
        ),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.red,
            fontFamily: 'WorkSans',
            primaryColorLight: const Color.fromARGB(255, 33, 36, 40),
            primaryColorDark: const Color.fromARGB(255, 20, 21, 23),
            cardColor: const Color.fromARGB(255, 52, 58, 64),
            textTheme: const TextTheme(
                headline6: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
                headline1: TextStyle(
                  fontSize: 90,
                  color: Colors.white,
                ),
                subtitle1: TextStyle(fontSize: 20, color: Colors.grey)),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: const Color.fromARGB(255, 33, 36, 40),
                selectedLabelStyle: const TextStyle(color: Colors.red),
                showSelectedLabels: false,
                showUnselectedLabels: false,
                selectedIconTheme: const IconThemeData(color: Colors.white),
                unselectedIconTheme: IconThemeData(color: Colors.grey[700]))),
        initialRoute: TabsScreen.routeName,
        routes: {
          TabsScreen.routeName: (context) => const TabsScreen(),
          ChooseLocationScreen.routeName: (context) => ChooseLocationScreen(),
          SettingsScreen.routeName: (context) => const SettingsScreen()
        },
      ),
    );
  }
}
