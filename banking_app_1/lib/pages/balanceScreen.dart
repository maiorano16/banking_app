import 'package:flutter/material.dart';
import 'package:banking_app_1/models/balance_model.dart';
import 'package:banking_app_1/widgets/circular_progres_bar_balance.dart';

class BalancePage extends StatefulWidget {
  @override
  _BalancePageState createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {

  String selectedPeriod = 'weekly';

  Future<List<Balance>> loadBalanceData() async {
    return await loadBalanceFromJson();
  }

   List<double> _calculatePercentages(Balance balance) {
    double total = balance.totalMoneyInBank + balance.totalSavings + balance.cost;
    double moneyInBankPercentage = balance.totalMoneyInBank / total;
    double costPercentage = balance.cost / total;
    double savingsPercentage = balance.totalSavings / total;

    return [moneyInBankPercentage, costPercentage, savingsPercentage];
  }

  void _showBottomSheet(BuildContext context, String period) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 250,
          width: 400,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Selezionato: $period', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Periodo: $period', style: TextStyle(fontSize: 16)),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedPeriod = period;
                  });
                  Navigator.pop(context);
                },
                child: Text('Conferma'),
              ),
            ],
          ),
        );
      },
    );
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
                  return const Center(child: Text('Errore nel caricamento dei dati'));
                } else if (snapshot.hasData) {
                  final balances = snapshot.data!;
                  final selectedBalance = balances.firstWhere((balance) => balance.period == selectedPeriod);

                  List<double> percentages = _calculatePercentages(selectedBalance);

                  return CircularBar(
                    values: percentages,
                    colors: const [
                      Color(0xFF29D3E8),
                      Color.fromARGB(255, 255, 5, 5),
                      Color.fromARGB(255, 225, 255, 0),
                    ],
                    label: 'Period of balance',
                    innerText: '                   Period: \n(${selectedBalance.startPeriod}) - (${selectedBalance.finalPeriod})',
                  );
                } else {
                  return const Center(child: Text('Nessun dato disponibile'));
                }
              },
            ),
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
           _showBottomSheet(context, period);
        });
      },
      child: Text(label),
    );
  }
}