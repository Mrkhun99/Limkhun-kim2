import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/screens/location_picker.dart';
import 'package:week_3_blabla_project/widgets/actions/blah_btn.dart';

class LocationPickerTest extends StatelessWidget {
  const LocationPickerTest({super.key});

  void _onLocationSelected(String location) {
    print("Selected Location: $location");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Location Picker Test")),
      body: Center(
        child: BlaButton(
          label: "Pick a Location",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LocationPicker(onLocationSelected: _onLocationSelected)),
            );
          },
        ),
      ),
    );
  }
}
