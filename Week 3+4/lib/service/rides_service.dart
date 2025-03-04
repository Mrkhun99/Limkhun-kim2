import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/model/ridefilter.dart';
import 'package:week_3_blabla_project/repository/ride_repository.dart';

import '../dummy_data/dummy_data.dart';
import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {
  // Singleton instance
  static final RidesService _instance = RidesService._internal();

  // Private constructor
  RidesRepository? _repository;
    RidesService._internal();


  // Factory constructor to return the singleton instance
  factory RidesService() {
    return _instance;
  }

  // Instance variables instead of static variables
  List<Ride> availableRides = fakeRides;

  ///
  ///  Return the relevant rides, given the passenger preferences
  ///
   void initialize(RidesRepository repository) {
    _repository = repository;
  }

  List<Ride> getRides(RidePreference preference, RidesFilter? filter) {
    if (_repository == null) {
      throw Exception("RidesService not initialized with a repository.");
    }
    return _repository!.getRides(preference, filter);
  }
  
  

}
