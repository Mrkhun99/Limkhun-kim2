import 'package:flutter/material.dart';

class LocationPickerScreen extends StatelessWidget {
  const LocationPickerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location Picker')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close Picker'),
        ),
      ),
    );
  }
}
