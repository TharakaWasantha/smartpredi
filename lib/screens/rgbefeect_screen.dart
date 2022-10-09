import 'package:agrogenicprl/utils/theme.dart';
import 'package:flutter/material.dart';


import 'package:firebase_database/firebase_database.dart';

import 'dart:math';

class RGBeffects extends StatefulWidget {
  const RGBeffects({Key? key}) : super(key: key);

  @override
  State<RGBeffects> createState() => _RGBeffectsState();
}

class _RGBeffectsState extends State<RGBeffects> {
  final database = FirebaseDatabase.instance.reference();
  final npIDController = TextEditingController();
  double hueGlobal = 0;
  double saturationGlobal = 0;
  double valueGlobal = 0;
  String ledID = "0";
  List<String> ledRange = ["-1","-1"];
  bool updateState = false;
  final _random_tinge = new Random();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    npIDController.dispose();
    super.dispose();
  }

  //Other Manipulation Functions

  //UPDATE HSV value
  void _updateHue(double hue){
    setState(() {
      hueGlobal = hue;
    });
  }
  void _updateSaturation(double saturation){
    setState(() {
      saturationGlobal = saturation;
    });
  }
  void _updateValue(double value){
    setState(() {
      valueGlobal = value;
    });
  }
  void _updateLedID(text){
    setState((){
      updateState = false;
      ledID = text;
    });
  }

  Future<void> _updateColorDB() async{
    Color c = HSVColor.fromAHSV(1, hueGlobal, saturationGlobal, valueGlobal).toColor();
    int tinge = -1+_random_tinge.nextInt(2);
    Map<String, dynamic> rgb = {
      'r': c.red + (c.red==0?0:tinge),
      'g': c.green + (c.green==0?0:tinge),
      'b': c.blue + (c.blue==0?0:tinge),
    };
    if(ledID.contains(',')){
      rgb['range'] = ledID;
      await database.child('RGB_Effects').child('range').update(rgb);
    }
    else await database.child('RGB_Effects').child(ledID=="-1"?'all':int.parse(ledID).toString()).update(rgb);
    if(ledID == '-1'){
      var data;
      await database.child('RGB_Effects').once();

      await database.update({'RGB_Effects':data});
    }
    setState(() {
      updateState = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 8.0, // gap between adjacent chips
          runSpacing: 4.0,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                GestureDetector(
                  onTap: () async{
                    //changes the ledID to -1 just to make the function work then switch back
                    String lastState = ledID;
                    setState(() {
                      ledID = "-1";
                    });
                    await _updateColorDB();
                    setState(() {
                      ledID = lastState;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(50),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color:  HSVColor.fromAHSV(0.5, hueGlobal, saturationGlobal, valueGlobal).toColor(),
                          blurRadius: valueGlobal*20,
                          spreadRadius: valueGlobal*20,
                        ),
                      ],
                      shape: BoxShape.circle,
                      // Capping value to follow slower than linear decay rate
                     // color: HSVColor.fromAHSV(1, hueGlobal, saturationGlobal, pow(valueGlobal,0.65)).toColor(),
                    ),
                  ),
                ),

                Padding(padding: EdgeInsets.all(20),),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 200, height: 40,
                      child: TextField(
                        textAlign: TextAlign.center,
                        onChanged: _updateLedID,
                        controller: npIDController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 20),),
                    ),
                    Padding(padding: EdgeInsets.all(8),),
                    ElevatedButton(
                      onPressed: _updateColorDB,
                      //color: updateState? Theme.of(context).accentColor: Theme.of(context).unselectedWidgetColor.withAlpha(200),
                      child: Text(
                        updateState?"Updated":"Update "+ledID.toString(),
                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12),
                      ),
                    ),
                  ],
                ),


// -----------------Sliders------------------

                Padding(padding: EdgeInsets.all(20),),
                //Hue Slider
                Text("HUE "+hueGlobal.toStringAsFixed(2)),
                SliderTheme(
                  data: customSliderTheme(context),
                  child: Slider(
                    min: 0,
                    divisions: 100,
                    max: 360,
                    value: hueGlobal,
                    label: "Hue "+hueGlobal.floor().toStringAsFixed(2),
                    onChanged: _updateHue,
                  ),
                ),

                Padding(padding: EdgeInsets.all(20),),
                //Saturation Slider
                Text("SAT "+saturationGlobal.toStringAsFixed(2)),
                SliderTheme(
                  data: customSliderTheme(context),
                  child: Slider(
                    min: 0,
                    divisions: 100,
                    max: 1,
                    value: saturationGlobal,
                    label: "Saturation "+saturationGlobal.toStringAsFixed(2),
                    onChanged: _updateSaturation,
                  ),
                ),

                Padding(padding: EdgeInsets.all(20),),
                //Value slider
                Text("VAL "+valueGlobal.toStringAsFixed(2)),
                SliderTheme(
                  data: customSliderTheme(context),
                  child: Slider(
                    min: 0,
                    divisions: 100,
                    max: 1,
                    value: valueGlobal,
                    label: "Value "+valueGlobal.toStringAsFixed(2),
                    onChanged: _updateValue,
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}