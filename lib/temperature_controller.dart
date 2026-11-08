
import 'package:flutter/material.dart';


enum TemperatureUnit {
  celsius,
  fahrenheit,
}


class TemperatureResult {
  final double value;
  final TemperatureUnit unit;

  const TemperatureResult({
    required this.value,
    required this.unit,
  });

  String get formattedValue =>
      '${value.toStringAsFixed(2)} ${unit.symbol}';
}

// Unit Extensions
extension TemperatureUnitExtension on TemperatureUnit {
  String get label {
    switch (this) {
      case TemperatureUnit.celsius:
        return 'Celsius';
      case TemperatureUnit.fahrenheit:
        return 'Fahrenheit';
    }
  }

  String get symbol {
    switch (this) {
      case TemperatureUnit.celsius:
        return '°C';
      case TemperatureUnit.fahrenheit:
        return '°F';
    }
  }
}

// Controller
class TemperatureController extends ChangeNotifier {
  TemperatureUnit _fromUnit = TemperatureUnit.fahrenheit;

  TemperatureResult? _result;
  String? _errorMessage;

  TemperatureUnit get fromUnit => _fromUnit;

  TemperatureUnit get toUnit =>
      _fromUnit == TemperatureUnit.celsius
          ? TemperatureUnit.fahrenheit
          : TemperatureUnit.celsius;

  TemperatureResult? get result => _result;

  String? get errorMessage => _errorMessage;

  bool get hasResult => _result != null;


  void changeUnit(TemperatureUnit unit) {
    _fromUnit = unit;
    _result = null;
    _errorMessage = null;
    notifyListeners();
  }


  void swapUnits() {
    _fromUnit = toUnit;
    _result = null;
    _errorMessage = null;
    notifyListeners();
  }

  // Convert Temperature
  void convert(String input) {
    if (input.trim().isEmpty) {
      _showError('Please enter a temperature.');
      return;
    }

    final double? temperature = double.tryParse(input.trim());

    if (temperature == null || !temperature.isFinite) {
      _showError('Please enter a valid number.');
      return;
    }

    double convertedValue;

    if (_fromUnit == TemperatureUnit.celsius) {

      convertedValue = (temperature * 9 / 5) + 32;
    } else {

      convertedValue = (temperature - 32) * 5 / 9;
    }

    _result = TemperatureResult(
      value: convertedValue,
      unit: toUnit,
    );

    _errorMessage = null;
    notifyListeners();
  }

  // Clear Result
  void clear() {
    _result = null;
    _errorMessage = null;
    notifyListeners();
  }

  void _showError(String message) {
    _result = null;
    _errorMessage = message;
    notifyListeners();
  }
}
