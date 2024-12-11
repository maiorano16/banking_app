import 'package:flutter/material.dart';
import 'package:banking_app_1/models/balance_model.dart';
import 'package:circular_gradient_progress/circular_gradient_progress.dart';

class BalancePage extends StatefulWidget {
  @override
  _BalancePageState createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  String selectedPeriod = 'weekly';
  late List<double> percentages;
  late double totalAmount;

  List<double> _calculatePercentages(Balance balance) {
    double total =
        balance.totalMoneyInBank + balance.totalSavings + balance.cost;
    double moneyInBankPercentage = balance.totalMoneyInBank / total * 100;
    double costPercentage = balance.cost / total * 100;
    double savingsPercentage = balance.totalSavings / total * 100;

    return [moneyInBankPercentage, savingsPercentage, costPercentage];
  }

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
                  final selectedBalance = balances.firstWhere(
                      (balance) => balance.period == selectedPeriod);

                  percentages = _calculatePercentages(selectedBalance);
                  totalAmount = selectedBalance.totalMoneyInBank +
                      selectedBalance.totalSavings +
                      selectedBalance.cost;

                  String periodLabel = selectedPeriod == 'weekly'
                      ? 'Settimana'
                      : selectedPeriod == 'monthly'
                          ? 'Mese'
                          : 'Anno';

                  return Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularGradientCombineWidget(
                            size: 200,
                            duration: Duration(seconds: 3),
                            centerCircleSizeRatio: 0.11,
                            sweepAngles: [
                              percentages[0],
                              percentages[1],
                              percentages[2],
                            ],
                            gapRatio: 0.25,
                            backgroundColors: [
                              Colors.blue.withOpacity(0.2),
                              const Color.fromARGB(255, 225, 255, 0)
                                  .withOpacity(0.2),
                              Colors.red.withOpacity(0.2),
                            ],
                            gradientColors: const [
                              [
                                Color.fromARGB(255, 0, 89, 255),
                                Color.fromARGB(255, 245, 62, 138)
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
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildPeriodButton('Settimana', 'weekly'),
                          const SizedBox(width: 10),
                          _buildPeriodButton('Mese', 'monthly'),
                          const SizedBox(width: 10),
                          _buildPeriodButton('Anno', 'annual'),
                        ],
                      ),
                      SizedBox(height: 20),
                      Card(
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Informazioni per il periodo: $periodLabel',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                  'Totale: \$${totalAmount.toStringAsFixed(2)}'),
                              SizedBox(height: 10),
                              Text(
                                  'In banca: ${percentages[0].toStringAsFixed(2)}%'),
                              Text(
                                  'Risparmi: ${percentages[1].toStringAsFixed(2)}%'),
                              Text(
                                  'Costi: ${percentages[2].toStringAsFixed(2)}%'),
                            ],
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

  Widget _buildPeriodButton(String label, String period) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedPeriod = period;
        });
      },
      child: Text(label),
    );
  }
}
