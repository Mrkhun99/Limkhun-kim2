import '../dummy_data/dummy_data.dart';
import '../model/ride_pref/ride_pref.dart';

////
///   This service handles:
///   - History of last ride preferences (to allow users to re-use past preferences)
///   - Current selected ride preferences.
///
class RidePrefService {
  /// List of past entered ride preferences (LIFO - most recent first)
  static List<RidePref> ridePrefsHistory = fakeRidePrefs; // Using fake data

  static RidePref? currentRidePref;

  static bool get hasCurrentRidePref => currentRidePref != null;
}
