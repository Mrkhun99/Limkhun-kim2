import '../model/ride/ride_pref.dart';

abstract class RidePreferencesRepository {
  Future<List<RidePreference>> getPastPreferences(); // Changed to Future
  Future<void> addPreference(RidePreference preference); // Changed to Future
}