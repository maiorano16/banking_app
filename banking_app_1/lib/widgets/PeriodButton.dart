import 'package:flutter/material.dart';

class PeriodButton extends StatelessWidget {
  final String label;
  final String period;
  final VoidCallback onPressed;
  final bool isSelected; // Aggiunto parametro

  const PeriodButton({
    required this.label,
    required this.period,
    required this.onPressed,
    required this.isSelected, // Richiesto
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? Colors.blueAccent // Colore per il bottone selezionato
            : Colors.grey,       // Colore per i bottoni non selezionati
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: isSelected ? Colors.blue : Colors.transparent, // Bordo
          ),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black, // Testo visibile
        ),
      ),
    );
  }
}
