import 'package:agrogenicprl/model/pirDataModel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class PIRDataPage extends StatefulWidget {
  const PIRDataPage({Key? key}) : super(key: key);

  @override
  State<PIRDataPage> createState() => _PIRDataPageState();
}

class _PIRDataPageState extends State<PIRDataPage> {
  List<Widget> _pirWidgetList = [];
  @override
  void initState() {
    super.initState();
    _loadPirData();
  }

  void _loadPirData() {
    final databaseRef = FirebaseDatabase.instance.ref();
    List<PirDataModel> _pirDateList = [];

    databaseRef.onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        var mapData = data as Map;
        Map mapPIRactiveData = mapData["Pest_Repellent"]["PIR_Status"];
        mapPIRactiveData.forEach(
          (key, value) {
            print("$key $value");
            _pirDateList.add(PirDataModel.fromMap(value));
          },
        );
        print(_pirDateList);
        print(mapPIRactiveData);
        loadPirWidgetList(_pirDateList);
      }
    });
  }

  loadPirWidgetList(List<PirDataModel> pirDateList) {
    if (pirDateList.isNotEmpty) {
      for (PirDataModel item in pirDateList) {
        _pirWidgetList.add(Card(
          color: Colors.lightBlue.withOpacity(0.6),
          child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "${item.currentDate} ${item.formatedtime}",
                style: const TextStyle(color: Colors.white, fontSize: 20),
              )),
        ));
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Active Time")),
      body: SingleChildScrollView(
        child: _pirWidgetList.isNotEmpty
            ? Center(
                child: AnimationLimiter(
                  child: Column(
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 1000),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "PIR active time list",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ..._pirWidgetList
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ),
    );
  }
}
