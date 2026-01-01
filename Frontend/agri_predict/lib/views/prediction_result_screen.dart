import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/prediction_controller.dart';
import 'widgets/prediction_list_view.dart';
import 'widgets/prediction_graph_view.dart';

class PredictionResultScreen extends StatelessWidget {
  const PredictionResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PredictionController>();


    controller.selectedView.value = ViewType.list;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/farm.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.predictions.isEmpty) {
              return const Center(
                child: Text(
                  "No predictions available",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return Column(
              children: [
                const SizedBox(height: 16),

                const Text(
                  "Crop Price Prediction Result",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 6),
                const Text(
                  "Note: Prices are predicted as MSP per quintal",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                const SizedBox(height: 14),

                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChoiceChip(
                      label: const Text("List View"),
                      selected:
                          controller.selectedView.value == ViewType.list,
                      selectedColor: Colors.green.shade200,
                      onSelected: (_) {
                        controller.selectedView.value = ViewType.list;
                      },
                    ),
                    const SizedBox(width: 12),
                    ChoiceChip(
                      label: const Text("Graph View"),
                      selected:
                          controller.selectedView.value == ViewType.graph,
                      selectedColor: Colors.green.shade200,
                      onSelected: (_) {
                        controller.selectedView.value = ViewType.graph;
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 12),


                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: MediaQuery.of(context).size.height * 0.60, 
                      child: Card(
                        elevation: 6,
                        color: Colors.white.withOpacity(0.95),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.selectedView.value == ViewType.list
                                    ? "Predicted Prices (List)"
                                    : "Predicted Prices (Graph)",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),

                            
                              Expanded(
                                child: controller.selectedView.value ==
                                        ViewType.list
                                    ? PredictionListView(
                                        predictions:
                                            controller.predictions,
                                      )
                                    : PredictionGraphView(
                                        predictions:
                                            controller.predictions,
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
