import '../../Domain/model/ride/ride_pref.dart';

abstract class RidePreferencesRepository {
  Future<void> addPreference(RidePreference preference);
  Future<List<RidePreference>> getPastPreferences();
}