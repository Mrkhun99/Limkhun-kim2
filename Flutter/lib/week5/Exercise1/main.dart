import 'package:week_3_blabla_project/week5/Exercise1/model/rideprefservice.dart';
import 'package:week_3_blabla_project/week5/Exercise1/screen/ridepreflistener.dart';

// Define ConsoleLogger inside main.dart
class ConsoleLogger implements RidePreferencesListener {
  @override
  void onPreferenceChanged(String newPreference) {
    print(" Ride Preference Updated: $newPreference");
  }
}

void main() {
  RidePreferencesService service = RidePreferencesService();
  ConsoleLogger logger = ConsoleLogger();

  service.addListener(logger);

  service.updatePreference("Economy Ride");
  service.updatePreference("Luxury Ride");
  service.updatePreference("Shared Ride");
}
