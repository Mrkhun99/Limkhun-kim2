import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_3_blabla_project/provider/ride_pref_provider.dart';

import '../../../model/ride/ride_pref.dart';
import '../../theme/theme.dart';
import '../../../utils/animations_util.dart';
import '../rides/rides_screen.dart';
import 'widgets/ride_pref_form.dart';
import 'widgets/ride_pref_history_tile.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

class RidePrefScreen extends StatelessWidget {
  const RidePrefScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          const BlaBackground(),
          
          // Foreground Content
          Column(
            children: [
              SizedBox(height: BlaSpacings.m),
              Text(
                "Your pick of rides at low price",
                style: BlaTextStyles.heading.copyWith(color: Colors.white),
              ),
              SizedBox(height: 100),
              _buildFormContent(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormContent(BuildContext context) {
    final provider = context.watch<RidesPreferencesProvider>();
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          RidePrefForm(
            initialPreference: provider.currentPreference,
            onSubmit: (newPref) => _onRidePrefSelected(context, newPref),
          ),
          SizedBox(height: BlaSpacings.m),
          _buildHistoryList(context),
        ],
      ),
    );
  }

  Widget _buildHistoryList(BuildContext context) {
    final provider = context.watch<RidesPreferencesProvider>();
    final history = provider.preferencesHistory;

    return SizedBox(
      height: 200,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: history.length,
        itemBuilder: (ctx, index) => RidePrefHistoryTile(
          ridePref: history[index],
          onPressed: () => _onRidePrefSelected(context, history[index]),
        ),
      ),
    );
  }

  Future<void> _onRidePrefSelected(BuildContext context, RidePreference newPref) async {
    context.read<RidesPreferencesProvider>().setCurrentPreference(newPref);
    await Navigator.of(context).push(
      AnimationUtils.createBottomToTopRoute(const RidesScreen()),
    );
  }
}

class BlaBackground extends StatelessWidget {
  const BlaBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Image.asset(
        blablaHomeImagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}