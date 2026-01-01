import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/prediction_model.dart';

class PredictionGraphView extends StatelessWidget {
  final List<PricePrediction> predictions;

  const PredictionGraphView({
    super.key,
    required this.predictions,
  });

  @override
  Widget build(BuildContext context) {
    if (predictions.isEmpty) {
      return const Center(child: Text("No data"));
    }

    return SizedBox(
      height: 300,
      child: LineChart(
        LineChartData(
          minX: 1,
          maxX: predictions.length.toDouble(),
          gridData: FlGridData(show: true),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.grey.shade400),
          ),

          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              color: Colors.green,
              barWidth: 3,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: Colors.green.withOpacity(0.2),
              ),
              spots: List.generate(
                predictions.length,
                (index) => FlSpot(
                  (index + 1).toDouble(), 
                  predictions[index].price,
                ),
              ),
            ),
          ],

          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),

            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 42,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),

            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  return Text(
                    "Day ${value.toInt()}",
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
