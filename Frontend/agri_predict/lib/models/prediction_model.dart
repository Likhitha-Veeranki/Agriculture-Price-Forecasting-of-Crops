class PricePrediction {
  final int day; 
  final double price;

  const PricePrediction({
    required this.day,
    required this.price,
  });

  factory PricePrediction.fromJson(Map<String, dynamic> json) {
    return PricePrediction(
      day: _parseInt(json['day'], defaultValue: 1),
      price: _parseDouble(json['price'], defaultValue: 0.0),
    );
  }

  Map<String, dynamic> toJson() => {
        'day': day,
        'price': price,
      };


  static int _parseInt(dynamic value, {int defaultValue = 0}) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? defaultValue;
    if (value is double) return value.toInt();
    return defaultValue;
  }

  static double _parseDouble(dynamic value, {double defaultValue = 0.0}) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? defaultValue;
    return defaultValue;
  }
}
