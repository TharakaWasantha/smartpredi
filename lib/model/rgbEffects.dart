class RgbEffects {
  RgbEffects({
    required this.rgbEffects,
  });

  RgbEffectsClass rgbEffects;

  factory RgbEffects.fromJson(Map<dynamic, dynamic> json) => RgbEffects(
        rgbEffects: RgbEffectsClass.fromJson(json["RGB_Effects"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "RGB_Effects": rgbEffects.toJson(),
      };
}

class RgbEffectsClass {
  RgbEffectsClass({
    required this.the0,
    required this.range,
  });

  The0 the0;
  int range;

  factory RgbEffectsClass.fromJson(Map<dynamic, dynamic> json) =>
      RgbEffectsClass(
        the0: The0.fromJson(json["0"]),
        range: json["range"],
      );

  Map<String, dynamic> toJson() => {
        "0": the0.toJson(),
        "range": range,
      };
}

class The0 {
  The0({
    required this.b,
    required this.r,
    required this.g,
  });

  int b;
  int r;
  int g;

  factory The0.fromJson(Map<dynamic, dynamic> json) => The0(
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
