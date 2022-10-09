import 'package:flutter/foundation.dart';

@immutable
class Sensor {
  Sensor({
    required this.humidity,
    required this.temperature,
    required this.lpg,
    required this.smoke,
  });

  Sensor.fromJson(Map<String, Object?> json)
      : this(
    humidity: json['humidity']! as double,
    temperature: json['temperature']! as double,
    lpg: json['temperature']! as double,
    smoke: json['temperature']! as double,
  );

  final double humidity;
  final double temperature;
  final double lpg;
  final double smoke;

  Map<String, Object?> toJson() {
    return {
      'humidity': humidity,
      'temperature': temperature,
      'lpg': lpg,
      'humidity': humidity,
    };
  }
}