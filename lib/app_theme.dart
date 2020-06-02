import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myportfolio/app_configurations.dart';


class ThemeModeNotifier extends ChangeNotifier {

  String themeMode = 'light';
  bool autoMode = true;

  ThemeModeNotifier(){
    this.themeMode = getThemeModeData();
  }

  void setThemeModeData(String mode){
    if(mode == 'auto'){
      this.autoMode = true;
      this.themeMode = getThemeFromTime();
    } else {
      this.autoMode = false;
      this.themeMode = mode;
    }
    AppConfigurations.prefs.setString('themeMode', mode);
    notifyListeners();
  }

  String getThemeModeData(){
    String mode = AppConfigurations.prefs.getString('themeMode') ?? 'auto';
    if(mode == 'auto'){
      this.autoMode = true;
      return getThemeFromTime();
    }
    this.autoMode = false;
    return mode;
  }

  String getThemeFromTime(){
    int hour = DateTime.now().hour;
    return hour >= 18 || hour <= 6 ? 'dark' : 'light';
  }
}

class AppTheme{

  static ThemeData lightThemeData = ThemeData(
    canvasColor: Color(0xfff0f0f3), // picture background color
    focusColor: Color(0xfff0f0f3), // top left button gradient
    primaryColor: Color(0xffe9eaee),  // bottom right button gradient
    primaryColorDark: Color(0xffa3B1C6), // first box shadow
    primaryColorLight: Colors.white, // second box shadow
    buttonColor: Color(0xfff0f0f3), // button color
    backgroundColor: Color(0xffebecf0), // background color
    bottomAppBarColor: Color(0xffE8E9ED), // bottom app bar color
    cursorColor: Color(0xff5D6270),
    textTheme: TextTheme(
        headline1: TextStyle(
            fontFamily: 'Poppins',
            color: Color(0xff5D6270),
            fontWeight: FontWeight.w600,
            letterSpacing: 3.0,
            fontSize: 18.0,
        ),
        headline2: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 25.0,
            fontWeight: FontWeight.w600,
            color: Color(0xff5D6270)
        ),
        headline3: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15.0,
            color: Color(0xff5D6270)
        ),
        headline4: TextStyle(
            fontFamily: 'Poppins',
            color: Color(0xff777e8f),
            fontWeight: FontWeight.w600,
            fontSize: 16.0
        ),
        headline5: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            letterSpacing: 1.0,
            fontSize: 16.0
        )
    ),
  );

  static ThemeData darkThemeData = ThemeData(
    canvasColor: Color(0xff25282e), // picture background Color
    focusColor: Color(0xff1e2125), // top left button gradient
    primaryColor: Color(0xff2b2e34),  // bottom right button gradient
    primaryColorDark: Color(0xff15191C), // first box shadow
    primaryColorLight: Color(0xff31353D), // second box shadow
    buttonColor: Color(0xff25282e), // button color
    backgroundColor: Color(0xff25282e), // background color,
    bottomAppBarColor: Color(0xff31353D), // bottom app bar color
    cursorColor: Color(0xff9aa1ad),
    textTheme: TextTheme( // text colors
        headline1: TextStyle(
            fontFamily: 'Poppins',
            color: Color(0xff9aa1ad),
            fontWeight: FontWeight.w600,
            letterSpacing: 3.0,
            fontSize: 18.0
        ),
        headline2: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 25.0,
            fontWeight: FontWeight.w600,
            color: Color(0xff9aa1ad)
        ),
        headline3: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15.0,
            color: Color(0xff9aa1ad)
        ),
        headline4: TextStyle(
            fontFamily: 'Poppins',
            color: Color(0xff9aa1ad),
            fontWeight: FontWeight.w600,
            fontSize: 16.0
        ),
        headline5: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            letterSpacing: 1.0,
            fontSize: 16.0,
            color: Color(0xff9aa1ad)
        )
    ),
  );
}