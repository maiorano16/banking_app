import 'dart:convert';
import 'package:banking_app_1/models/mainAccountAnnualTransaction_model.dart';
import 'package:banking_app_1/utility/get_logo.dart';
import 'package:banking_app_1/widgets/mainCard_transaction.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:banking_app_1/models/card_model.dart';
import 'package:fl_chart/fl_chart.dart';

class MainAccountPage extends StatefulWidget {
  const MainAccountPage({Key? key}) : super(key: key);

  @override
  _MainAccountPageState createState() => _MainAccountPageState();
}

class _MainAccountPageState extends State<MainAccountPage> {
  List<Carta> carte = [];
  List<MainCardTransaction> transactions = [];
  List<Map<String, dynamic>> chartData = [];
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _loadCarteFromJson();
    _loadTransactionsFromJson();
    _loadChartData();
  }

  // Caricamento dei dati delle carte
  Future<void> _loadCarteFromJson() async {
    final String response =
        await rootBundle.loadString('assets/fileJson/card.json');
    final Map<String, dynamic> data = json.decode(response);
    final List<dynamic> carteList = data['cards'];

    setState(() {
      carte = carteList.map((json) => Carta.fromJson(json)).toList();
    });
  }

  // Caricamento delle transazioni annuali
  Future<void> _loadTransactionsFromJson() async {
    final String response = await rootBundle
        .loadString('assets/fileJson/mainAccountTransactionAnnual.json');
    final Map<String, dynamic> data = json.decode(response);
    final transactionsData = TransactionsData.fromJson(
        data); // Use TransactionsData instead of AnnualReport

    List<MainCardTransaction> allTransactions = [];

    // Supponiamo che le transazioni siano separate per mese
    for (var month in transactionsData.transactions) {
      allTransactions
          .addAll(month.transactions); // Aggiungi tutte le transazioni mensili
    }

    setState(() {
      transactions = allTransactions;
    });
  }

  // Caricamento dei dati del grafico
  Future<void> _loadChartData() async {
    final String response =
        await rootBundle.loadString('assets/fileJson/annualExpense.json');
    final Map<String, dynamic> data = json.decode(response);
    final List<dynamic> dataList = data['data'];

    setState(() {
      chartData = List<Map<String, dynamic>>.from(dataList);
    });
  }

  // Costruzione del grafico
  // Costruzione del grafico
Widget _buildChart() {
  if (chartData.isEmpty) {
    return Center(child: CircularProgressIndicator());
  }

  // Dati per le spese (rossa)
  List<FlSpot> expenseSpots = chartData.asMap().entries.map((entry) {
    int index = entry.key;
    Map<String, dynamic> data = entry.value;
    return FlSpot(index.toDouble(), data['expense']?.toDouble() ?? 0.0);
  }).toList();

  // Dati per le entrate (verde)
  List<FlSpot> incomeSpots = chartData.asMap().entries.map((entry) {
    int index = entry.key;
    Map<String, dynamic> data = entry.value;
    return FlSpot(index.toDouble(), data['income'].toDouble());
  }).toList();

  return Padding(
  padding: const EdgeInsets.only(left: 30, right: 30), // Sposta il grafico a destra e aggiunge spazio a sinistra
  child: SizedBox(
    height: 300,
    child: LineChart(
      LineChartData(
        lineBarsData: [
          // Linea per le spese
          LineChartBarData(
            spots: expenseSpots,
            isCurved: true,
            color: Colors.red,
            barWidth: 3,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(show: false),
            dotData: FlDotData(show: true),
          ),
          // Linea per le entrate
          LineChartBarData(
            spots: incomeSpots,
            isCurved: true,
            color: Colors.green,
            barWidth: 3,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(show: false),
            dotData: FlDotData(show: true),
          ),
        ],
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: true),
        // Aggiungi spazio extra per mostrare il primo e l'ultimo punto
        clipData: FlClipData(
          top: false,
          bottom: false,
          left: false,
          right: false,
        ),
      ),
    ),
  ),
);

}


  @override
  Widget build(BuildContext context) {
    final mainAccountCards =
        carte.where((card) => card.tipoAccount == 'Main account').toList();
    if (mainAccountCards.isNotEmpty) {
      final mainCard = mainAccountCards.first;
      return Scaffold(
        appBar: AppBar(
          title: const Text('Main Account Card'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Visualizzazione della card aggiornata
              Container(
                width: 350,
                height: 200,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 32),
                            Text(
                              '\$${mainCard.saldoCarta}', // Visualizza il saldo
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 30),
                            Text(
                              '${mainCard.numeroCarta}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 150,
                        right: 16,
                        child: Text(
                          mainCard.scadenzaCarta,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 16,
                        child: Image.asset(
                          getLogoForCards(mainCard.circuito),
                          width: 60,
                          height: 60,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        top: 150,
                        left: 15,
                        child: Text(
                          mainCard.tipoCarta,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Barra di navigazione tra le sezioni
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Transactions',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Graphics',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // PageView per gestire lo swipe
              Expanded(
                child: PageView(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  children: [
                    // Sezione Transazioni
                    transactions.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              final transaction = transactions[index];
                              return Card(
                                elevation: 2,
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: ListTile(
                                  title: Text(transaction.description),
                                  subtitle: Text(transaction.transactionDate),
                                  trailing:
                                      Text('\$${transaction.transactionCost}'),
                                ),
                              );
                            },
                          ),
                    // Sezione Grafico
                    _buildChart(), // Mostra il grafico
                  ],
                  onPageChanged: (pageIndex) {
                    // Puoi gestire eventuali logiche aggiuntive
                  },
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('No Main Account Cards'),
        ),
        body: Center(
          child: const Text('No main account cards available'),
        ),
      );
    }
  }
}
