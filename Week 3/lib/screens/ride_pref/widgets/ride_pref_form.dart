import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/widgets/actions/blah_btn.dart';
import '../../../theme/theme.dart'; // Ensure this file contains BlaColors, BlaSpacings
import '../../../utils/date_utils.dart' as MyDateUtils; // Alias for custom DateUtils

class RidePrefForm extends StatefulWidget {
  final String? departureLocation;
  final String? arrivalLocation;
  final DateTime departureDate;
  final int requestedSeats;
  final void Function(String, String, DateTime, int) onSubmit;

  RidePrefForm({
    Key? key,
    this.departureLocation,
    this.arrivalLocation,
    DateTime? departureDate,
    this.requestedSeats = 1,
    required this.onSubmit,
  })  : departureDate = departureDate ?? DateTime.now(),
        super(key: key);

  @override
  _RidePrefFormState createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  late TextEditingController _departureController;
  late TextEditingController _arrivalController;
  late DateTime _selectedDate;
  late int _selectedSeats;

  // Use MyDateUtils for your custom DateUtils class
  final MyDateUtils.DateUtils dateUtils = MyDateUtils.DateUtils();

  @override
  void initState() {
    super.initState();
    _departureController = TextEditingController(text: widget.departureLocation ?? '');
    _arrivalController = TextEditingController(text: widget.arrivalLocation ?? '');
    _selectedDate = widget.departureDate;
    _selectedSeats = widget.requestedSeats;
  }

  /// 🔄 Swap departure and arrival locations
  void _switchLocations() {
    setState(() {
      String temp = _departureController.text;
      _departureController.text = _arrivalController.text;
      _arrivalController.text = temp;
    });
  }

  void _pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  bool _isFormValid() {
    return _departureController.text.isNotEmpty && _arrivalController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Departure Field
        TextField(
          controller: _departureController,
          decoration: InputDecoration(
            labelText: "Departure",
            prefixIcon: Icon(Icons.location_on, color: BlaColors.primary),
          ),
        ),
        SizedBox(height: BlaSpacings.medium ?? 16.0),

        // 🔄 Switch Locations Button
        Center(
          child: IconButton(
            icon: Icon(Icons.swap_vert, size: 30, color: BlaColors.primary),
            onPressed: _switchLocations,
          ),
        ),
        SizedBox(height: BlaSpacings.medium ?? 16.0),

        // Arrival Field
        TextField(
          controller: _arrivalController,
          decoration: InputDecoration(
            labelText: "Arrival",
            prefixIcon: Icon(Icons.flag, color: BlaColors.secondary ?? Colors.grey),
          ),
        ),
        SizedBox(height: BlaSpacings.medium ?? 16.0),

        // Date Picker
        GestureDetector(
          onTap: () => _pickDate(context),
          child: Row(
            children: [
              Icon(Icons.calendar_today, color: BlaColors.primary),
              SizedBox(width: 10),
              Text(
                "Departure: ${dateUtils.formatDateTime(_selectedDate)}", // Use the alias
                style: BlaTextStyles.body,
              ),
            ],
          ),
        ),
        SizedBox(height: BlaSpacings.medium ?? 16.0),

        // Seat Picker (Spinner)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Seats:", style: BlaTextStyles.body),
            DropdownButton<int>(
              value: _selectedSeats,
              items: List.generate(5, (index) => index + 1)
                  .map((num) => DropdownMenuItem(
                        value: num,
                        child: Text(num.toString()),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedSeats = value ?? 1;
                });
              },
            ),
          ],
        ),
        SizedBox(height: BlaSpacings.medium ?? 16.0),

        // Search Button
        BlaButton(
          label: "Search",
          onPressed: _isFormValid()
              ? () => widget.onSubmit(
                    _departureController.text,
                    _arrivalController.text,
                    _selectedDate,
                    _selectedSeats,
                  )
              : null, text: '',
        ),
      ],
    );
  }
}
