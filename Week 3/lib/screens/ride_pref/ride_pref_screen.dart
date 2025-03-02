import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/screens/ride_pref/widgets/ride_pref_form.dart';

class RidePrefFormTest extends StatelessWidget {
  const RidePrefFormTest({super.key});

  void _onSearch(String departure, String arrival, DateTime date, int seats) {
    print("Searching rides from $departure to $arrival on $date for $seats seat(s)");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ride Preferences Form Test")),
      body: RidePrefForm(onSearch: _onSearch),
    );
  }
}
