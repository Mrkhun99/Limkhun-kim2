import 'package:week_3_blabla_project/model/ridefilter.dart';

import '../../dummy_data/dummy_data.dart';
import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../service/rides_service.dart';
import '../ride_repository.dart';

class MockRideRepository implements RidesRepository {
  final List<RidePreference> _ridePreferences = [
    RidePreference(
      departure: fakeLocations[40], // Battambang
      arrival: fakeLocations[39], // Siem Reap
      departureDate: DateTime.now().add(Duration(hours: 5, minutes: 30)),
      requestedSeats: 2,
    ),
    RidePreference(
      departure: fakeLocations[40], // Battambang
      arrival: fakeLocations[39], // Siem Reap
      departureDate: DateTime.now().add(Duration(hours: 8)),
      requestedSeats: 0,
    ),
    RidePreference(
      departure: fakeLocations[40], // Battambang
      arrival: fakeLocations[39], // Siem Reap
      departureDate: DateTime.now().add(Duration(hours: 5)),
      requestedSeats: 1,
    ),
    RidePreference(
      departure: fakeLocations[40], // Battambang
      arrival: fakeLocations[39], // Siem Reap
      departureDate: DateTime.now().add(Duration(hours: 8)),
      requestedSeats: 2,
    ),
    RidePreference(
      departure: fakeLocations[40], // Battambang
      arrival: fakeLocations[39], // Siem Reap
      departureDate: DateTime.now().add(Duration(hours: 5)),
      requestedSeats: 1,
    ),
  ];

  final List<RidesFilter> _ridesFilter = [
    RidesFilter(
      petAccepted: false,
    ),
        RidesFilter(
      petAccepted: false,
    ),
        RidesFilter(
      petAccepted: false,
    ),
        RidesFilter(
      petAccepted: true,
    ),
        RidesFilter(
      petAccepted: false,
    ),
    
  ];

  @override
  List<Ride> getRides(RidePreference preference, RidesFilter? filter) {
    final ridesService = RidesService();
    return ridesService.getRidesFor(preference);
  }
}