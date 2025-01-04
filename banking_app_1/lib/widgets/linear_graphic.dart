/*import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LineChartSample1 extends StatefulWidget {
  const LineChartSample1({Key? key}) : super(key: key);

  @override
  _LineChartSample1State createState() => _LineChartSample1State();
}

class _LineChartSample1State extends State<LineChartSample1> {
  late List<FlSpot> dataPoints;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      String response = await rootBundle.loadString('assets/fileJson/annualExpense.json');
      final Map<String, dynamic> jsonData = json.decode(response);
      final List<dynamic> data = jsonData['data'];

      setState(() {
        dataPoints = data.asMap().entries.map((entry) {
          final index = entry.key;
          final value = entry.value;
          return FlSpot(index.toDouble(), (value['value'] as int).toDouble());
        }).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error loading data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

 

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : _LineChart(dataPoints: dataPoints),
    );
  }
}

class _LineChart extends StatelessWidget {
  final List<FlSpot> dataPoints;

  const _LineChart({Key? key, required this.dataPoints}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: dataPoints,
            isCurved: true,
            color: Colors.blue,
            barWidth: 4,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(show: false),
          ),
        ],
        titlesData: titlesData,
        borderData: borderData,
        gridData: const FlGridData(show: false),
      ),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              const style = TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              );
              final months = [
                'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
              ];
              return SideTitleWidget(
                child: Text(months[value.toInt() % months.length], style: style),
                axisSide: meta.axisSide,
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) => Text('${value.toInt()}',
                style: const TextStyle(fontSize: 12)),
          ),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border.all(color: Colors.grey, width: 1),
      );
}*/