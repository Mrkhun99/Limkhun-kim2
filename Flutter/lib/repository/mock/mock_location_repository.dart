import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/repository/location_repository.dart';

class InMemoryLocationRepository implements LocationRepository {
  // Predefined list of Cambodian cities
  final List<Location> _locations = const [
    Location(name: "Phnom Penh", country: Country.Cambodia),
    Location(name: "Siem Reap", country: Country.Cambodia),
    Location(name: "Battambang", country: Country.Cambodia),
    Location(name: "Sihanoukville", country: Country.Cambodia),
    Location(name: "Kampot", country: Country.Cambodia),
  ];


  @override
  List<Location> getAllLocations() {
    return List.unmodifiable(_locations);
  }

  @override
  Location? findLocationByName(String name) {
    return _locations.firstWhere(
      (location) => location.name.toLowerCase() == name.toLowerCase(),
    );
  }
}