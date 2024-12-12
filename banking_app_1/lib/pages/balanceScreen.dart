import 'package:banking_app_1/widgets/PeriodButton.dart';
import 'package:banking_app_1/widgets/circular_progres_bar_balance.dart';
import 'package:banking_app_1/widgets/flippableCard.dart';
import 'package:banking_app_1/widgets/iconList.dart';
import 'package:flutter/material.dart';
import 'package:banking_app_1/models/balance_model.dart';

import '../utility/percentage_calculator.dart';

class BalancePage extends StatefulWidget {
  @override
  _BalancePageState createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  String selectedPeriod = 'weekly';
  late List<double> percentages;
  late double totalAmount;
  late Balance selectedBalance;

  Future<List<Balance>> loadBalanceData() async {
    return await loadBalanceFromJson();
  }

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
                  selectedBalance = balances.firstWhere(
                      (balance) => balance.period == selectedPeriod);

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
                              [
                                Color.fromARGB(255, 0, 89, 255),
                                Color.fromARGB(255, 245, 62, 138)
                              ],
                              [
                                Color.fromARGB(255, 0, 255, 0),
                                Color.fromARGB(255, 144, 238, 144)
                              ],
                              [
                                Color.fromARGB(255, 255, 191, 0),
                                Color(0xffB6FE02)
                              ],
                              [
                                Color.fromARGB(255, 255, 0, 0),
                                Color(0xff00FCD0)
                              ],
                            ],
                            backgroundColors: [
                              Colors.blue.withOpacity(0.2),
                              const Color.fromARGB(255, 0, 255, 0)
                                  .withOpacity(0.2),
                              const Color.fromARGB(255, 225, 255, 0)
                                  .withOpacity(0.2),
                              Colors.red.withOpacity(0.2),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PeriodButton(
                            label: 'Settimana',
                            period: 'weekly',
                            onPressed: () {
                              setState(() {
                                selectedPeriod = 'weekly';
                              });
                            },
                            isSelected: selectedPeriod == 'weekly',
                          ),
                          const SizedBox(width: 10),
                          PeriodButton(
                            label: 'Mese',
                            period: 'monthly',
                            onPressed: () {
                              setState(() {
                                selectedPeriod = 'monthly';
                              });
                            },
                            isSelected: selectedPeriod == 'monthly',
                          ),
                          const SizedBox(width: 10),
                          PeriodButton(
                            label: 'Anno',
                            period: 'annual',
                            onPressed: () {
                              setState(() {
                                selectedPeriod = 'annual';
                              });
                            },
                            isSelected: selectedPeriod == 'annual',
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      FlippableCard(
                        front: Card(
                          elevation: 5,
                          margin: const EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Informazioni per il periodo: ${selectedBalance.startPeriod} - ${selectedBalance.finalPeriod}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                IconList(balance: selectedBalance),
                              ],
                            ),
                          ),
                        ),
                        back: Card(
                          elevation: 5,
                          margin: const EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Altri dettagli:',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                    'Puoi aggiungere qui altre informazioni sul retro.'),
                              ],
                            ),
                          ),
                        ),
                      ),
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
