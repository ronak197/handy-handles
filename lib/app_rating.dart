import 'package:myportfolio/app_configurations.dart';

class AppRating{

  static final String appId = ''; // App Id in play store listings
  static final int firstPromptAfter = 2; // Number of days after first prompt message to be displayed
  static final int showAgainAfter = 3; // Show the prompt after this much app launches, if the user sets remind me later

  static bool doNotShowAgain; // If true then never prompt to rate
  static int launchesLeft;  // Launches left until next prompt

  static void saveRatingInfo(int launchesLeft, bool donNotShowAgain){
    AppRating.launchesLeft = launchesLeft;
    AppRating.doNotShowAgain = donNotShowAgain;
    AppConfigurations.prefs.setInt('launchesLeft', launchesLeft);
    AppConfigurations.prefs.setBool('doNotShowAgain', donNotShowAgain);
  }

  static void getRatingInfo(){
    launchesLeft = AppConfigurations.prefs.getInt('launchesLeft') ?? showAgainAfter;
    doNotShowAgain = AppConfigurations.prefs.getBool('doNotShowAgain') ?? false;
  }

}