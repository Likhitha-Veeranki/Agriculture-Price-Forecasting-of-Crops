import 'package:flutter/material.dart';
import '../../models/prediction_model.dart';

class PredictionListView extends StatelessWidget {
  final List<PricePrediction> predictions;

  const PredictionListView({
    super.key,
    required this.predictions,
  });

  @override
  Widget build(BuildContext context) {
    if (predictions.isEmpty) {
      return const Center(child: Text("No predictions available"));
    }

    return Scrollbar(
      thumbVisibility: true, 
      child: ListView.builder(
        itemCount: predictions.length,
        itemBuilder: (context, index) {
          final p = predictions[index];

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            child: ListTile(
              leading: CircleAvatar(
                child: Text("${index + 1}"),
              ),
              title: Text("Day ${index + 1}"),
              trailing: Text(
                "₹ ${p.price.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
