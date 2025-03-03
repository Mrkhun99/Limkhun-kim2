import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/screens/location_picker.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/utils/animations_util.dart';
import 'package:week_3_blabla_project/widgets/actions/blah_btn.dart';


class RidePrefForm extends StatefulWidget {
  final Function(String departure, String arrival, DateTime date, int seats) onSearch;

  const RidePrefForm({Key? key, required this.onSearch}) : super(key: key);

  @override
  _RidePrefFormState createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  String? departure;
  String? arrival;
  DateTime? departureDate = DateTime.now();
  int seats = 1;

  bool get isSearchEnabled => departure != null && arrival != null;

  void _pickLocation(bool isDeparture) async {
    final selectedLocation = await Navigator.push(
      context,
      AnimationsUtil.createBottomToTopRoute(
        LocationPicker(
          onLocationSelected: (location) {
            Navigator.pop(context, location);
          },
        ),
      ),
    );

    if (selectedLocation != null) {
      setState(() {
        if (isDeparture) {
          departure = selectedLocation;
        } else {
          arrival = selectedLocation;
        }
      });
    }
  }

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: departureDate!,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => departureDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Departure Picker
          InkWell(
            onTap: () => _pickLocation(true),
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: "Departure",
                suffixIcon: const Icon(Icons.location_on),
              ),
              child: Text(departure ?? "Select Departure", style: BlaTextStyles.body),
            ),
          ),

          const SizedBox(height: 8),

          // Arrival Picker
          InkWell(
            onTap: () => _pickLocation(false),
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: "Arrival",
                suffixIcon: const Icon(Icons.location_on),
              ),
              child: Text(arrival ?? "Select Arrival", style: BlaTextStyles.body),
            ),
          ),

          const SizedBox(height: 8),

          // Date Picker
          InkWell(
            onTap: _pickDate,
            child: InputDecorator(
              decoration: const InputDecoration(labelText: "Departure Date"),
              child: Text("${departureDate!.toLocal()}".split(' ')[0]),
            ),
          ),

          const SizedBox(height: 8),

          // Seat Picker
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Seats"),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: seats > 1 ? () => setState(() => seats--) : null,
                  ),
                  Text(seats.toString()),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => setState(() => seats++),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Search Button
          BlaButton(
            label: "Search",
            onPressed: isSearchEnabled
                ? () => widget.onSearch(departure!, arrival!, departureDate!, seats)
                : null,
          ),
        ],
      ),
    );
  }
}
