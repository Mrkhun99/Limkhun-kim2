import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/locations.dart';
import '../../service/rides_service.dart';
import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';

class RidesScreen extends StatefulWidget {
  @override
  _RidesScreenState createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  late List<Ride> rides;

  @override
  void initState() {
    super.initState();
    final preference = RidePreference(
      departure: Location(name: "Battambang", country: Country.Cambodia),
      arrival: Location(name: "Siem Reap", country: Country.Cambodia),
      departureDate: DateTime.now(),
      requestedSeats: 1,
    );
    rides = RidesService().getRides(preference, null); // ✅ Fix: Pass correct arguments
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Available Rides")),
      body: ListView.builder(
        itemCount: rides.length,
        itemBuilder: (context, index) {
          final ride = rides[index];
          return Card(
            child: ListTile(
              title: Text("${ride.departureLocation.name} → ${ride.arrivalLocation.name}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Departure: ${ride.departureDate}"),
                  Text("Arrival: ${ride.arrivalDate}"),
                  Text("Duration: ${ride.duration.inHours} hrs"),
                  Text("Driver: ${ride.driver}"),
                  Text("Accept Pets: ${ride.acceptPets ? 'Yes' : 'No'}"),
                  Text("Seats Available: ${ride.availableSeats}"),
                  Text("Price: \$${ride.pricePerSeat.toStringAsFixed(2)}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
