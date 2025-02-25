import 'package:flutter/material.dart';
import 'widgets/ride_pref_form.dart';

class RidePrefScreen extends StatelessWidget {
  const RidePrefScreen({Key? key}) : super(key: key);

  void _handleSearch(String departure, String arrival, DateTime date, int seats) {
    print("Searching for rides from $departure to $arrival on $date for $seats seats");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ride Preferences")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RidePrefForm(onSubmit: _handleSearch),
      ),
    );
  }
}
