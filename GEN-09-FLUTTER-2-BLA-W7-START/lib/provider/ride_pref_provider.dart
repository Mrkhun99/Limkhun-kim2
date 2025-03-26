import 'package:flutter/material.dart';
import '../model/ride/ride_pref.dart';
import '../repository/ride_preferences_repository.dart';

class RidesPreferencesProvider extends ChangeNotifier {
  RidePreference? _currentPreference;
  final RidePreferencesRepository repository;
  List<RidePreference> _pastPreferences = [];
  bool _isLoading = false;
  bool _hasError = false;

  RidesPreferencesProvider({required this.repository}) {
    fetchPastPreferences();
  }

  RidePreference? get currentPreference => _currentPreference;
  List<RidePreference> get pastPreferences => _pastPreferences;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> fetchPastPreferences() async {
    try {
      _isLoading = true;
      _hasError = false;
      notifyListeners();

      _pastPreferences = await repository.getPastPreferences();
      
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      _hasError = true;
      notifyListeners();
      print("Error fetching preferences: $error");
    }
  }

  Future<void> setCurrentPreference(RidePreference pref) async {
    if (_currentPreference == pref) return;

    _currentPreference = pref;
    await repository.addPreference(pref);
    await fetchPastPreferences();
    notifyListeners();
  }
}