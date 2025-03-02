import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/locations.dart';
import '../../dummy_data/dummy_data.dart';

class LocationPickerScreen extends StatefulWidget {
  final Function(Location) onLocationSelected; // Ensure this parameter exists

  const LocationPickerScreen({Key? key, required this.onLocationSelected}) : super(key: key);

  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  List<Location> filteredLocations = fakeLocations; // Load dummy locations
  TextEditingController searchController = TextEditingController();

  void _filterLocations(String query) {
    setState(() {
      filteredLocations = fakeLocations
          .where((location) => location.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select a Location")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              onChanged: _filterLocations,
              decoration: InputDecoration(
                hintText: "Search location...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredLocations.length,
              itemBuilder: (context, index) {
                final location = filteredLocations[index];
                return ListTile(
                  title: Text(location.name),
                  onTap: () {
                    widget.onLocationSelected(location); // Ensure this callback works
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
