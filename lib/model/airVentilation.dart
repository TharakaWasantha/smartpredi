import 'dart:convert';

// AirVentilation airVentilationFromJson(String str) =>
//     AirVentilation.fromJson(json.decode(str));

// String airVentilationToJson(AirVentilation data) => json.encode(data.toJson());

class AirVentilation {
  AirVentilation({
    required this.lpg,
    required this.temperature,
    required this.humidity,
    required this.smoke,
  });

  Humidity lpg;
  Humidity temperature;
  Humidity humidity;
  Humidity smoke;

  factory AirVentilation.fromJson(Map<dynamic, dynamic> json) => AirVentilation(
        lpg: Humidity.fromJson(json["LPG"]),
        temperature: Humidity.fromJson(json["Temperature"]),
        humidity: Humidity.fromJson(json["Humidity"]),
        smoke: Humidity.fromJson(json["Smoke"]),
      );

  Map<String, dynamic> toJson() => {
        "LPG": lpg.toJson(),
        "Temperature": temperature.toJson(),
        "Humidity": humidity.toJson(),
        "Smoke": smoke.toJson(),
      };
}

class Humidity {
  Humidity({
    required this.data,
  });

  double data;

  factory Humidity.fromJson(Map<dynamic, dynamic> json) => Humidity(
        data: json["Data"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "Data": data,
      };
}
