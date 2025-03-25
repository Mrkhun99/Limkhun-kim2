import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_3_blabla_project/provider/ride_pref_provider.dart';
import '../../../model/ride/ride_filter.dart';
import '../../../model/ride/ride_pref.dart';
import '../../../service/rides_service.dart';
import '../../theme/theme.dart';
import '../../../utils/animations_util.dart';
import 'widgets/ride_pref_bar.dart';
import 'widgets/ride_pref_modal.dart';
import 'widgets/rides_tile.dart';

class RidesScreen extends StatelessWidget {
  const RidesScreen({super.key});

  void onPreferencePressed(BuildContext context) async {
    final provider = context.read<RidesPreferencesProvider>();
    final newPreference = await Navigator.of(context).push<RidePreference>(
      AnimationUtils.createTopToBottomRoute(
        RidePrefModal(initialPreference: provider.currentPreference!),
      ),
    );

    if (newPreference != null) {
      provider.setCurrentPreference(newPreference);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RidesPreferencesProvider>();
    final currentPreference = provider.currentPreference!;
    final currentFilter = RideFilter();
    final matchingRides = RidesService.instance.getRidesFor(currentPreference, currentFilter);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
        child: Column(
          children: [
            RidePrefBar(
              ridePreference: currentPreference,
              onBackPressed: () => Navigator.of(context).pop(),
              onPreferencePressed: () => onPreferencePressed(context),
              onFilterPressed: () {},
            ),
            Expanded(
              child: ListView.builder(
                itemCount: matchingRides.length,
                itemBuilder: (ctx, index) => RideTile(ride: matchingRides[index], onPressed: () {}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}