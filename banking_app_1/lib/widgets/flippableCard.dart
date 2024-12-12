import 'package:banking_app_1/models/balance_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FlippableCard extends StatefulWidget {
  final Widget front;
  final Widget back;

  const FlippableCard({
    Key? key,
    required this.front,
    required this.back,
  }) : super(key: key);

  @override
  _FlippableCardState createState() => _FlippableCardState();
}

class _FlippableCardState extends State<FlippableCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {
      isFront = !isFront;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flipCard,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value * 3.14159;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            child: isFront
                ? widget.front
                : Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(3.14159),
                    child: widget.back,
                  ),
          );
        },
      ),
    );
  }
}

class FlippableCardPage extends StatelessWidget {
  final Balance selectedBalance;

  FlippableCardPage({required this.selectedBalance});

  @override
  Widget build(BuildContext context) {
    final List<BalanceData> data = [
      BalanceData(selectedBalance.startPeriod, selectedBalance.finalPeriod, selectedBalance.income, selectedBalance.cost),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Flippable Card with Chart'),
      ),
      body: Center(
        child: FlippableCard(
          front: Card(
            elevation: 5,
            child: Center(
              child: Text(
                'Fronte della carta',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          back: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 300, // Aumentato per migliorare la visibilità
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  title: ChartTitle(text: 'Entrate ed Uscite'),
                  legend: Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <LineSeries<BalanceData, String>>[
                    // Linea per le Entrate
                    LineSeries<BalanceData, String>(
                      dataSource: data,
                      xValueMapper: (BalanceData balance, _) => balance.startPeriod,
                      yValueMapper: (BalanceData balance, _) => balance.income,
                      name: 'Entrate',
                      color: Colors.green,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    ),
                    // Linea per le Uscite
                    LineSeries<BalanceData, String>(
                      dataSource: data,
                      xValueMapper: (BalanceData balance, _) => balance.finalPeriod,
                      yValueMapper: (BalanceData balance, _) => balance.cost,
                      name: 'Uscite',
                      color: Colors.red,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    ),
                  ],
                  primaryYAxis: NumericAxis(
                    minimum: 0, // Imposta il valore minimo per l'asse Y
                    maximum: selectedBalance.income > selectedBalance.cost
                        ? selectedBalance.income * 1.2 // Aumentato per maggiore visibilità
                        : selectedBalance.cost * 1.2,
                    interval: 10, // Imposta l'intervallo tra le etichette dell'asse Y
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BalanceData {
  BalanceData(this.startPeriod, this.finalPeriod, this.income, this.cost);
  final String startPeriod;
  final String finalPeriod;
  final double income;
  final double cost;
}