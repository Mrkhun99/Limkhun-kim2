import 'package:week_3_blabla_project/week5/Exercise1/screen/ridepreflistener.dart';

class RidePreferencesService {
  String _preference = "Default Preference";
  final List<RidePreferencesListener> _listeners = [];

  String get preference => _preference;

  void updatePreference(String newPreference) {
    _preference = newPreference;
    _notifyListeners();
  }

  void addListener(RidePreferencesListener listener) {
    _listeners.add(listener);
  }

  void removeListener(RidePreferencesListener listener) {
    _listeners.remove(listener);
  }

  void _notifyListeners() {
    for (var listener in _listeners) {
      listener.onPreferenceChanged(_preference);
    }
  }
}
