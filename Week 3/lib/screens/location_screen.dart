import 'package:flutter/material.dart';

class LocationPickerScreen extends StatelessWidget {
  final Function(Location) onLocationSelected; // ✅ Ensure this is defined

  const LocationPickerScreen({Key? key, required this.onLocationSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _selectLocation(Location location) {
      onLocationSelected(location); // ✅ Call the callback function
      Navigator.pop(context); // ✅ Return to previous screen
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Pick a Location")),
      body: ListView(
        children: [
          ListTile(
            title: const Text("New York"),
            onTap: () => _selectLocation(Location(name: "New York")),
          ),
          ListTile(
            title: const Text("Los Angeles"),
            onTap: () => _selectLocation(Location(name: "Los Angeles")),
          ),
        ],
      ),
    );
  }
}

// ✅ Dummy Location Model
class Location {
  final String name;
  Location({required this.name});
}
