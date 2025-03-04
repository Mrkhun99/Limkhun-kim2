import 'package:week_3_blabla_project/model/ride/locations.dart';

import '../../utils/date_time_util.dart';
import '../user/user.dart';

enum RideStatus {
  created,
  published,
  ongoing,
  finished;
}

///
/// This model describes a  Ride.
///
class Ride {
 

   final Location departureLocation;
  final DateTime departureDate;  
  final Location arrivalLocation;
  final DateTime arrivalDate; 
  final String driver;
  final Duration duration;
  final bool acceptPets;
  final int availableSeats;
  final double pricePerSeat;

  RideStatus status = RideStatus.created;

  final List<User> passengers = [];

  Ride({
       required this.departureLocation,
    required this.departureDate,
    required this.arrivalLocation,
    required this.arrivalDate,
    required this.driver,
    required this.duration,
    required this.acceptPets,
    required this.availableSeats,
    required this.pricePerSeat,
  });

  void addPassenger(User passenger) {
    passengers.add(passenger);
  }

  int get remainingSeats => availableSeats - passengers.length;

  @override
  String toString() {
    return '$departureLocation → $arrivalLocation | $departureDate | '
           'Duration: ${duration.inHours} hrs | Driver: $driver | Pets: $acceptPets | '
           'Seats: $availableSeats | Price: \$${pricePerSeat.toStringAsFixed(2)}';
  }
}
