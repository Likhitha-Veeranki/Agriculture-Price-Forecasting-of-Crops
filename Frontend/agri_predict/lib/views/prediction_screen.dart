import 'package:agri_predict/views/prediction_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/prediction_controller.dart';
import 'widgets/app_dropdown.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  late final PredictionController controller;
  final TextEditingController daysController = TextEditingController(text: "7");

  @override
  void initState() {
    super.initState();
    controller = Get.put(PredictionController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/farm.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(0.4),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Obx(
              () => Column(
                children: [
                  const SizedBox(height: 60),
                  const Text(
                    "Agriculture Price Prediction",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      
                    ),
                  ),

                  const SizedBox(height: 20),
                  Center(
                    child: Container(
                      width: 350,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.92),
                        borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                          color: Colors.black, 
                          width: 2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppDropdown(
                            label: "State",
                            items: controller.states.toList(),
                            value: controller.selectedState.value,
                            onChanged: (val) {
                              controller.selectedState.value = val;
                              if (val != null) controller.loadDistricts(val);
                            }, 
                            
                          ),
                    
                          const Padding(
                            padding: EdgeInsets.only(top: 6, left: 4),
                            child: Text(
                              "* Andhra Pradesh includes historical data of present-day Telangana",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                    
                          const SizedBox(height: 12),
                          AppDropdown(
                            label: "District",
                            items: controller.districts.toList(),
                            value: controller.selectedDistrict.value,
                            onChanged: (val) {
                              controller.selectedDistrict.value = val;
                              if (val != null && controller.selectedState.value != null) {
                                controller.loadMarkets(controller.selectedState.value!, val);
                              }
                            },
                          ),
                          const SizedBox(height: 12),
                          AppDropdown(
                            label: "Market",
                            items: controller.markets.toList(),
                            value: controller.selectedMarket.value,
                            onChanged: (val) {
                              controller.selectedMarket.value = val;
                              if (val != null &&
                                  controller.selectedState.value != null &&
                                  controller.selectedDistrict.value != null) {
                                controller.loadCommodities(
                                  controller.selectedState.value!,
                                  controller.selectedDistrict.value!,
                                  val,
                                );
                              }
                            }, 
                          ),
                          const SizedBox(height: 12),
                          AppDropdown(
                            label: "Commodity",
                            items: controller.commodities.toList(),
                            value: controller.selectedCommodity.value,
                            onChanged: (val) {
                              controller.selectedCommodity.value = val;
                            }, 
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: daysController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,                
                              fillColor: Colors.white, 
                              labelText: "Days to predict (1–30)",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                    
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                      side: const BorderSide(
                                        color: Colors.black,
                                        width: 1.1, 
                                        ),
                                ),
                              ),
                              
                              onPressed: controller.isLoading.value
                                  ? null
                                  : () async {
                                      FocusScope.of(context).unfocus();
                    
                                      final days = int.tryParse(daysController.text) ?? 7;
                                      if (days <= 0) {
                                        Get.snackbar("Invalid input", "Days must be greater than 0");
                                        return;
                                      }
                    
                                      await controller.predict(days: days);
                    
                                      if (controller.predictions.isNotEmpty) {
                                        Get.to(() => const PredictionResultScreen());
                                      }
                                    },
                              child: controller.isLoading.value
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text("Predict"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
