import 'package:week_3_blabla_project/repository/ride_repository.dart';
import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../model/ridefilter.dart';
import '../../model/ride/locations.dart';

class MockRideRepository implements RidesRepository {
  final List<Ride> _rides = [
    Ride(
      departureLocation: Location(name: "Battambang", country: Country.Cambodia),
      departureDate: DateTime.now().add(Duration(hours: 5, minutes: 30)),
      arrivalLocation: Location(name: "Siem Reap", country: Country.Cambodia),
      arrivalDate: DateTime.now().add(Duration(hours: 8)),
      driver: "Kannika",
      duration: Duration(hours: 2),
      acceptPets: false,
      availableSeats: 2,
      pricePerSeat: 10.0,
    ),
    Ride(
      departureLocation: Location(name: "Battambang", country: Country.Cambodia),
      departureDate: DateTime.now().add(Duration(hours: 8)),
      arrivalLocation: Location(name: "Siem Reap", country: Country.Cambodia),
      arrivalDate: DateTime.now().add(Duration(hours: 10)),
      driver: "Chaylim",
      duration: Duration(hours: 2),
      acceptPets: false,
      availableSeats: 0,
      pricePerSeat: 8.0,
    ),
    Ride(
      departureLocation: Location(name: "Battambang", country: Country.Cambodia),
      departureDate: DateTime.now().add(Duration(hours: 5)),
      arrivalLocation: Location(name: "Siem Reap", country: Country.Cambodia),
      arrivalDate: DateTime.now().add(Duration(hours: 7)),
      driver: "Mengtech",
      duration: Duration(hours: 3),
      acceptPets: false,
      availableSeats: 1,
      pricePerSeat: 12.0,
    ),
  ];

  @override
  List<Ride> getRides(RidePreference preference, RidesFilter? filter) {
    List<Ride> filteredRides = _rides.where((ride) {
      return ride.departureLocation.name == preference.departure.name &&
             ride.arrivalLocation.name == preference.arrival.name;
    }).toList();

    if (filter != null && filter.petAccepted) {
      filteredRides = filteredRides.where((ride) => ride.acceptPets).toList();
    }

    return filteredRides;
  }
}
