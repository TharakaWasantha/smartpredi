import 'dart:convert';

NeoPixels neoPixelsFromJson(String str) => NeoPixels.fromJson(json.decode(str));

String neoPixelsToJson(NeoPixels data) => json.encode(data.toJson());

class NeoPixels {
  NeoPixels({
    required this.neopixels,
  });

  List<Neopixel> neopixels;

  factory NeoPixels.fromJson(Map<dynamic, dynamic> json) => NeoPixels(
        neopixels: List<Neopixel>.from(
            json["neopixels"].map((x) => Neopixel.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
        "neopixels": List<dynamic>.from(neopixels.map((x) => x.toJson())),
      };
}

class Neopixel {
  Neopixel({
    required this.b,
    required this.r,
    required this.g,
  });

  int b;
  int r;
  int g;

  factory Neopixel.fromJson(Map<dynamic, dynamic> json) => Neopixel(
        b: json["b"],
        r: json["r"],
        g: json["g"],
      );

  Map<String, dynamic> toJson() => {
        "b": b,
        "r": r,
        "g": g,
      };
}
