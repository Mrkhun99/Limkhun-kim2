import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/widgets/actions/blah_btn.dart';

class LocationPicker extends StatefulWidget {
  final Function(String) onLocationSelected;

  const LocationPicker({Key? key, required this.onLocationSelected}) : super(key: key);

  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  final List<String> locations = ["Paris", "London", "New York", "Berlin", "Tokyo"];
  String? selectedLocation;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pick a Location")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: "Search location",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => setState(() {}),
            ),
          ),

          Expanded(
            child: ListView(
              children: locations
                  .where((location) => location.toLowerCase().contains(searchController.text.toLowerCase()))
                  .map((location) => ListTile(
                        title: Text(location),
                        onTap: () {
                          setState(() => selectedLocation = location);
                        },
                        trailing: selectedLocation == location
                            ? const Icon(Icons.check, color: Colors.blue)
                            : null,
                      ))
                  .toList(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: BlaButton(
              label: "Confirm",
              onPressed: selectedLocation != null ? () => widget.onLocationSelected(selectedLocation!) : null,
            ),
          ),
        ],
      ),
    );
  }
}
