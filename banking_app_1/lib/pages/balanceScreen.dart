import 'package:circular_gradient_progress/circular_gradient_progress.dart';
import 'package:flutter/material.dart';
import 'package:banking_app_1/models/balance_model.dart';

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
    double incomePercentage = balance.income / total * 100;
    double costPercentage = balance.cost / total * 100;
    double savingsPercentage = balance.totalSavings / total * 100;

    return [
      moneyInBankPercentage,
      incomePercentage,
      savingsPercentage,
      costPercentage
    ];
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
                  return Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularGradientCombineWidget(
                            size: 220,
                            duration: Duration(seconds: 3),
                            centerCircleSizeRatio: 0.11,
                            sweepAngles: [
                              percentages[0],
                              percentages[1],
                              percentages[2],
                              percentages[3],
                            ],
                            gapRatio: 0.15,
                            backgroundColors: [
                              Colors.blue.withOpacity(0.2),
                              Color.fromARGB(255, 0, 255, 0).withOpacity(0.2),
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
                                Color.fromARGB(255, 0, 255, 0),
                                Color.fromARGB(255, 144, 238, 144),
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
                                'Informazioni per il periodo: ${selectedBalance.startPeriod} - ${selectedBalance.finalPeriod}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20),
                              buildIconList(selectedBalance),
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

Widget buildIconWithText(String text, Color iconColor) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
          color: iconColor,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(8),
      ),
      SizedBox(width: 10),
      Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
    ],
  );
}

Widget buildIconList(Balance balance) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildIconWithText('In banca: \$${balance.totalMoneyInBank}', Colors.blue),
      SizedBox(height: 16),
      buildIconWithText('Entrate: \$${balance.income}', const Color.fromARGB(255, 0, 255, 38)),
      SizedBox(height: 16),
      buildIconWithText('Risparmi: \$${balance.totalSavings}', const Color.fromARGB(255, 212, 255, 0)),
      SizedBox(height: 16),
      buildIconWithText('Spese: \$${balance.cost}', Colors.red),
    ],
  );
}
