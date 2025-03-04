import 'package:week_3_blabla_project/model/ride/locations.dart';

abstract class LocationRepository {
  /// Retrieves all available locations.
  List<Location> getAllLocations();

  /// Finds a location by its name.
  Location? findLocationByName(String name);
}
