import 'package:flutter/material.dart';
import '../model/ride/ride_pref.dart';
import '../repository/ride_preferences_repository.dart';

class RidesPreferencesProvider extends ChangeNotifier {
  RidePreference? _currentPreference;
  List<RidePreference> _pastPreferences = [];
  final RidePreferencesRepository repository;

  RidesPreferencesProvider({required this.repository}) {
    _fetchPastPreferences();
  }

  RidePreference? get currentPreference => _currentPreference;

  List<RidePreference> get preferencesHistory => _pastPreferences.reversed.toList();

  Future<void> _fetchPastPreferences() async {
    _pastPreferences = await repository.getPastPreferences();
    notifyListeners();
  }

  void setCurrentPreference(RidePreference pref) {
    if (pref != _currentPreference) {
      _currentPreference = pref;
      _addPreference(pref);
      notifyListeners();
    }
  }

  void _addPreference(RidePreference preference) {
    // Remove any existing identical preferences
    _pastPreferences.removeWhere((p) => p == preference);
    _pastPreferences.add(preference);
    repository.addPreference(preference);
  }
}