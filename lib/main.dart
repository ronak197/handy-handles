import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myportfolio/app_configurations.dart';
import 'package:myportfolio/app_rating.dart';
import 'package:provider/provider.dart';
import 'package:myportfolio/app_theme.dart';
import 'package:myportfolio/home_page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await AppConfigurations.getSharedPrefInstance;
  UserConfig.getAllHandles();
  UserConfig.getName();
  UserConfig.getBio();
  AppRating.getRatingInfo();

  runApp(
    ChangeNotifierProvider<ThemeModeNotifier>(
      create: (context) => ThemeModeNotifier(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/homePage',
      routes: {
        '/homePage' : (context) => HomePage()
      },
      theme: Provider.of<ThemeModeNotifier>(context).themeMode == 'dark' ? AppTheme.darkThemeData : AppTheme.lightThemeData,
    );
  }
}