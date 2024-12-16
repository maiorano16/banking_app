import 'package:banking_app_1/utility/data_service.dart';
import 'package:banking_app_1/widgets/period_button_balance.dart';
import 'package:flutter/material.dart';
import 'package:banking_app_1/models/balance_model.dart';
import 'package:banking_app_1/widgets/circular_progres_bar_balance.dart';
import '../utility/percentage_calculator.dart';
import '../widgets/balance_info_card.dart';


class BalancePage extends StatefulWidget {
  @override
  _BalancePageState createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  String selectedPeriod = 'weekly';
  late List<double> percentages;
  late double totalAmount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Balance'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            FutureBuilder<List<Balance>>(
              future: loadBalanceData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                      child: Text('Errore nel caricamento dei dati'));
                } else if (snapshot.hasData) {
                  final balances = snapshot.data!;
                  final filteredBalances = balances
                      .where((balance) => balance.period == selectedPeriod)
                      .toList();
                  if (filteredBalances.isEmpty) {
                    return const Center(child: Text('Nessun dato disponibile'));
                  }

                  final selectedBalance = filteredBalances.first;
                  percentages = calculatePercentages(selectedBalance);
                  totalAmount = selectedBalance.totalMoneyInBank +
                      selectedBalance.totalSavings +
                      selectedBalance.cost;

                  return Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularGradientProgress(
                            sweepAngles: percentages,
                            gradientColors: const [
                              [Colors.blueAccent, Colors.pinkAccent],
                              [Colors.green, Colors.lightGreen],
                              [Colors.orange, Colors.yellow],
                              [Colors.red, Colors.teal],
                            ],
                            backgroundColors: [
                              Colors.blue.withOpacity(0.2),
                              Colors.green.withOpacity(0.2),
                              Colors.yellow.withOpacity(0.2),
                              Colors.red.withOpacity(0.2),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      PeriodButtonsRow(
                        selectedPeriod: selectedPeriod,
                        onPeriodSelected: (period) {
                          setState(() {
                            selectedPeriod = period;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      BalanceInfoCard(balance: selectedBalance),
                    ],
                  );
                } else {
                  return const Center(child: Text('Nessun dato disponibile'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
