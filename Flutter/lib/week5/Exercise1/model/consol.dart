import 'package:week_3_blabla_project/week5/Exercise1/screen/ridepreflistener.dart';

class ConsoleLogger implements RidePreferencesListener {
  @override
  void onPreferenceChanged(String newPreference) {
    print(" Ride Preference Updated: $newPreference");
  }
}
