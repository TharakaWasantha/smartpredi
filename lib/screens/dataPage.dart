import 'package:agrogenicprl/model/airVentilation.dart';
import 'package:agrogenicprl/model/neoPixels.dart';
import 'package:agrogenicprl/model/rgbEffects.dart';
import 'package:agrogenicprl/screens/air.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DataPage extends StatefulWidget {
  const DataPage({Key? key}) : super(key: key);

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  var _humitidityValue;
  var _lpgValue;
  var _smokeValue;
  var _temperature;

  var _coolingStatus;
  var _pestRepellentDestinationRange;
  var _pestRepellentPirStatus;
  var _rgbEffectsR, _rgbEffectsG, _rgbEffectsB, _rgbEffectsRange;
  var _warmingBulbStatus;

  @override
  void initState() {
    super.initState();
    _humitidityValue = "";
    _lpgValue = "";
    _smokeValue = "";
    _temperature = "";
    _coolingStatus = "";
    _pestRepellentDestinationRange = "";
    _pestRepellentPirStatus = "";

    _rgbEffectsR = "";
    _rgbEffectsG = "";
    _rgbEffectsB = "";
    _rgbEffectsRange = "";
    _warmingBulbStatus = "";

    _loadData();
  }

  _loadData() {
    final databaseRef = FirebaseDatabase.instance.ref();
    // databaseRef.child("Air_Ventilation").onChildChanged.listen((data) {
    //   // print(data.snapshot.key);
    //   // print(data.snapshot.value as Map);
    //   print(data.snapshot.value);
    //   // Map<dynamic, dynamic> map = data.snapshot.children as Map;
    //   // print(map);
    // });
    databaseRef.onValue.listen((event) {
      final data = event.snapshot.value;
      // print(data);
      //TODO: main code begins
      if (data != null) {
        var mapData = data as Map;
        print(mapData);
        print(mapData["Air_Ventilation"]);

// TODO:1:
        AirVentilation airVentilation =
            AirVentilation.fromJson(mapData["Air_Ventilation"] as Map);
        print(airVentilation.humidity.data);
        _humitidityValue = airVentilation.humidity.data.toString();
        _lpgValue = airVentilation.lpg.data.toString();
        _smokeValue = airVentilation.smoke.data.toString();
        _temperature = airVentilation.temperature.data.toString();
//air ventilation ends

        _coolingStatus = mapData["Cooling"]["Fan"]["Fan_status"];
        _pestRepellentDestinationRange =
            mapData["Pest_Repellent"]["Destination"]["Range"];
        // _pestRepellentPirStatus = mapData["Pest_Repellent1"]["PIR"]["Status"];

        RgbEffects rgbEffects = RgbEffects.fromJson(mapData);
        _rgbEffectsRange = rgbEffects.rgbEffects.range.toString();
        _rgbEffectsR = rgbEffects.rgbEffects.the0.r.toString();
        _rgbEffectsG = rgbEffects.rgbEffects.the0.g.toString();
        _rgbEffectsB = rgbEffects.rgbEffects.the0.b.toString();

        _warmingBulbStatus = mapData["Warming"]["Bulb"]["Bulb_status"];
        print(rgbEffects);

        NeoPixels neoPixels = NeoPixels.fromJson(mapData);
        print(neoPixels);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Page"),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Column(
            children: [
              const Text("AireVentilation Data"),
              const SizedBox(height: 5),
              Text("Humidity Value:$_humitidityValue"),
              const SizedBox(height: 5),
              Text("LPG Value:$_lpgValue"),
              const SizedBox(height: 5),
              Text("Smoke :$_smokeValue"),
              const SizedBox(height: 5),
              Text("Temperature :$_temperature"),
              const SizedBox(height: 5),
            ],
          )),
          Text("Cooling Status: $_coolingStatus"),
          const SizedBox(height: 5),
          Text(
              "Pest Repellent Destination Range: $_pestRepellentDestinationRange"),
          const SizedBox(height: 5),
          Text("Pest Repellent PIR Status: $_pestRepellentPirStatus"),
          const SizedBox(height: 5),
          Text(
              "RGB effects range $_rgbEffectsRange  R: $_rgbEffectsR , G:$_rgbEffectsG ,B:$_rgbEffectsB"),
          const SizedBox(height: 5),
          Text("Warming Bulb Status $_warmingBulbStatus"),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
