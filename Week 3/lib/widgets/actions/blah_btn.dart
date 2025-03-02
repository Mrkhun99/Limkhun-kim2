import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/theme/theme.dart';

enum BlaButtonType { primary, secondary }

class BlaButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final BlaButtonType type;
  final IconData? icon;

  const BlaButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.type = BlaButtonType.primary,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPrimary = type == BlaButtonType.primary;
    
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? BlaColors.primary : BlaColors.secondary,
        foregroundColor: Colors.red,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Icon(icon, size: 20, color: Colors.white),
          if (icon != null) const SizedBox(width: 8),
          Text(label, style: BlaTextStyles.button),
        ],
      ),
    );
  }
}
