import 'package:banking_app_1/models/balance_model.dart';
import 'package:banking_app_1/widgets/iconList.dart';
import 'package:flutter/material.dart';

class BalanceInfoCard extends StatelessWidget {
  final Balance balance;

  const BalanceInfoCard({required this.balance});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informazioni per il periodo: ${balance.startPeriod} - ${balance.finalPeriod}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            IconList(balance: balance),
          ],
        ),
      ),
    );
  }
}
