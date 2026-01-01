import 'package:get/get.dart';
import '../models/prediction_model.dart';
import '../services/api_service.dart';

enum ViewType { list, graph }

class PredictionController extends GetxController {

  var states = <String>[].obs;
  var districts = <String>[].obs;
  var markets = <String>[].obs;
  var commodities = <String>[].obs;

  var selectedState = RxnString();
  var selectedDistrict = RxnString();
  var selectedMarket = RxnString();
  var selectedCommodity = RxnString();

  var predictions = <PricePrediction>[].obs;
  var isLoading = false.obs;

  var selectedView = ViewType.list.obs;

  @override
  void onInit() {
    super.onInit();
    loadStates();
  }

  Future<void> loadStates() async {
    try {
      final data = await ApiService.getStates();
      print("States received:");
      states.assignAll(data);
    } catch (e) {
      print("STATE API ERROR: $e");
    }
  }

  Future<void> loadDistricts(String state) async {
    try {
      districts.clear();
      markets.clear();
      commodities.clear();

      selectedDistrict.value = null;
      selectedMarket.value = null;
      selectedCommodity.value = null;

      final data = await ApiService.getDistricts(state);
      districts.assignAll(data);
    } catch (e) {
      print("DISTRICT API ERROR: $e");
    }
  }

  Future<void> loadMarkets(String state, String district) async {
    try {
      markets.clear();
      commodities.clear();

      selectedMarket.value = null;
      selectedCommodity.value = null;

      final data = await ApiService.getMarkets(state, district);
      markets.assignAll(data);
    } catch (e) {
      print("MARKET API ERROR: $e");
    }
  }
  Future<void> loadCommodities(
    String state,
    String district,
    String market,
  ) async {
    try {
      commodities.clear();
      selectedCommodity.value = null;

      final data =
          await ApiService.getCommodities(state, district, market);
      commodities.assignAll(data);
    } catch (e) {
      print("COMMODITY API ERROR: $e");
    }
  }
  Future<void> predict({required int days}) async {
    if (selectedState.value == null ||
        selectedDistrict.value == null ||
        selectedMarket.value == null ||
        selectedCommodity.value == null) {
      Get.snackbar("Error", "Please select all fields");
      return;
    }

    try {
      isLoading.value = true;
      predictions.clear();

      final startDate = DateTime.now().add(const Duration(days: 1));
      const double lag1 = 100;
      const double lag7 = 95;
      const double lag14 = 90;
      const double lag30 = 85;
      const double rolling7 = 97;
      const double rolling14 = 92;
      final result = await ApiService.predictPrices(
        state: selectedState.value!,
        district: selectedDistrict.value!,
        market: selectedMarket.value!,
        commodity: selectedCommodity.value!,
        day: startDate.day,
        month: startDate.month,
        year: startDate.year,
        dayOfWeek: startDate.weekday,
        lag1: lag1,
        lag7: lag7,
        lag14: lag14,
        lag30: lag30,
        rolling7: rolling7,
        rolling14: rolling14,
        days: days,
      );
      predictions.assignAll(
        List.generate(result.length, (index) {
          return PricePrediction(
            day: index + 1,
            price: result[index].toDouble(),
          );
        }),
      );

      print(" Predictions count: ${predictions.length}");
    } catch (e) {
      print(" PREDICTION ERROR: $e");
      Get.snackbar("Error", "Prediction failed:Insufficient historical data for this combination");
    } finally {
      isLoading.value = false;
    }
  }
}
