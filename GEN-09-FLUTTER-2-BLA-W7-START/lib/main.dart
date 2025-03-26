import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Data/repository/mock/mock_locations_repository.dart';
import 'Data/repository/mock/mock_rides_repository.dart';
import 'Data/repository/mock/mock_ride_preferences_repository.dart';
import 'Domain/service/locations_service.dart';
import 'Domain/service/rides_service.dart';
import 'Domain/service/ride_prefs_service.dart';
import 'ui/screens/ride_pref/ride_pref_screen.dart';
import 'ui/theme/theme.dart';
import 'ui/provider/ride_pref_provider.dart'; 

void main() {
  // Initialize services
  final locationsRepo = MockLocationsRepository();
  final ridesRepo = MockRidesRepository();
  final prefsRepo = MockRidePreferencesRepository();
  
  LocationsService.initialize(locationsRepo);
  RidesService.initialize(ridesRepo);
  RidePrefService.initialize(prefsRepo);

  runApp(
    MultiProvider(
      providers: [
        // Add provider here while keeping services
        ChangeNotifierProvider(
          create: (context) => RidesPreferencesProvider(
            repository: prefsRepo,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const RidePrefScreen(),
    );
  }
}