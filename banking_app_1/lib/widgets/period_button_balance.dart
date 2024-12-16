import 'package:banking_app_1/widgets/PeriodButton.dart';
import 'package:flutter/material.dart';

class PeriodButtonsRow extends StatelessWidget {
  final String selectedPeriod;
  final Function(String) onPeriodSelected;

  const PeriodButtonsRow({
    required this.selectedPeriod,
    required this.onPeriodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PeriodButton(
          label: 'Settimana',
          period: 'weekly',
          onPressed: () => onPeriodSelected('weekly'),
          isSelected: selectedPeriod == 'weekly',
        ),
        const SizedBox(width: 10),
        PeriodButton(
          label: 'Mese',
          period: 'monthly',
          onPressed: () => onPeriodSelected('monthly'),
          isSelected: selectedPeriod == 'monthly',
        ),
        const SizedBox(width: 10),
        PeriodButton(
          label: 'Anno',
          period: 'annual',
          onPressed: () => onPeriodSelected('annual'),
          isSelected: selectedPeriod == 'annual',
        ),
      ],
    );
  }
}
