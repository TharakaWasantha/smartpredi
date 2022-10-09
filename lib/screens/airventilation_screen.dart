import 'package:agrogenicprl/utils/airventi_utility/custom_styles.dart';
import 'package:agrogenicprl/utils/airventi_utility/my_sensor_card.dart';
import 'package:agrogenicprl/utils/airventi_utility/sensor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Airventilation extends StatefulWidget {
  const Airventilation({Key? key}) : super(key: key);
  @override
  State<Airventilation> createState() => _AirventilationState();
}
class _AirventilationState extends State<Airventilation>   with SingleTickerProviderStateMixin {
  List<double>? tempList;
  List<double>? rhList;
  List<double>? smokeList;
  List<double>? lpgList;


  static String collectionName = 'Air_Ventilation';
  final sensorRef = FirebaseFirestore.instance
      .collection(collectionName)
      .withConverter<Sensor>(
    fromFirestore: (snapshots, _) => Sensor.fromJson(snapshots.data()!),
    toFirestore: (movie, _) => movie.toJson(),

  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[100],
      appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 0,
          title: Text('Air Ventilation Charts',)
      ),
        body: StreamBuilder<QuerySnapshot<Sensor>>(
          stream: sensorRef.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final data = snapshot.requireData;

            if (tempList == null) {
              tempList = List.filled(5, data.docs.first
                  .data()
                  .temperature,
                  growable: true);
            } else {
              tempList!.add(data.docs.first
                  .data()
                  .temperature);
              tempList!.removeAt(0);
            }

            if (rhList == null) {
              rhList =
                  List.filled(5, data.docs.first
                      .data()
                      .humidity, growable: true);
            } else {
              rhList!.add(data.docs.first
                  .data()
                  .humidity);
              rhList!.removeAt(0);
            }

            if (lpgList == null) {
              lpgList = List.filled(5, data.docs.first
                  .data()
                  .lpg,
                  growable: true);
            } else {
              lpgList!.add(data.docs.first
                  .data()
                  .lpg);
              lpgList!.removeAt(0);
            }

            if (smokeList == null) {
              smokeList = List.filled(5, data.docs.first
                  .data()
                  .smoke,
                  growable: true);
            } else {
              smokeList!.add(data.docs.first
                  .data()
                  .smoke);
              smokeList!.removeAt(0);
            }

            return Padding(
              padding:
              const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 30),
              child: CustomScrollView(slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  MySensorCard(
                                    value: data.docs.first
                                        .data()
                                        .humidity,
                                    unit: '%',
                                    name: 'Humidity',
                                    assetImage: AssetImage(
                                      'assets/hummi.png',
                                    ),
                                    trendData: rhList!,
                                    linePoint: Colors.green,
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),

                                  MySensorCard(
                                    value: data.docs.first
                                        .data()
                                        .temperature,
                                    unit: '°C',
                                    name: 'Temperature',
                                    assetImage: AssetImage(
                                      'assets/temmi.png',
                                    ),
                                    trendData: tempList!,
                                    linePoint: Colors.redAccent,
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),

                                  MySensorCard(
                                    value: data.docs.first
                                        .data()
                                        .lpg,
                                    unit: 'ppm',
                                    name: 'LPG',
                                    assetImage: AssetImage(
                                      'assets/lpgi.png',
                                    ),
                                    trendData: tempList!,
                                    linePoint: Colors.yellowAccent,
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),
                                  MySensorCard(
                                    value: data.docs.first
                                        .data()
                                        .smoke,
                                    unit: 'ppm',
                                    name: 'Smoke',
                                    assetImage: AssetImage(
                                      'assets/smoki.png',
                                    ),
                                    trendData: tempList!,
                                    linePoint: Colors.purpleAccent,
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            );
          },
        ));
  }
}